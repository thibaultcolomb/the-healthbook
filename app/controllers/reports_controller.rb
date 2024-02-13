class ReportsController < ApplicationController
  require 'rqrcode'
  def index
    if params[:query].present?
      @reports = current_user.reports.order(report_date: :desc).search_by_title_and_note(params[:query])
    elsif params[:category].present?
      @reports = current_user.reports.order(report_date: :desc).where(category: params[:category])
    elsif params[:report_date].present?
      @reports = current_user.reports.order(report_date: :desc).where(report_date: params[:report_date])

    else
      @reports = current_user.reports.all.order(report_date: :desc)
    end

    @categories = Report.pluck(:category).uniq
  end

  def show
    @report = current_user.reports.find(params[:id])
    @report.viewed_at = Time.now
    @report.save

    @link_for_qr_code = "www.thehealthbook.online/reports/#{@report.id}"
    @qr_code = RQRCode::QRCode.new(@link_for_qr_code)
    @svg = @qr_code.as_svg(
      offset: 0,
      fill: 'white',
      color: '64CCC5',
      shape_rendering: 'crispEdges',
      standalone: true,
      module_size: 4
    )
  end

  def new
    @report = Report.new
    @report.build_doctor
  end

  def create
    @report = Report.new(report_params)
    @doctor = Doctor.new(report_params[:doctor_attributes])
    @doctor.user = current_user
    @doctor.save
    @report.user = current_user
    @report.doctor = @doctor
    if params[:report][:doctor_id].present?
      @report.doctor = Doctor.find(params[:report][:doctor_id])
    end

    @report.viewed_at = Time.now

    if params[:report][:photo].present?
      to_be_formatted = convert_image_to_content
      @report.save
      NewReportJob.perform_later(@report.id, to_be_formatted)
      flash[:notice] = "Your report is being updated"

      # @report.note = format_content(to_be_formatted)
    elsif params[:report][:pdf].present?
      @report.note = convert_pdf_to_text
    end

    if @report.save
      redirect_to reports_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @report = current_user.reports.find(params[:id])
  end

  def update
    @report = current_user.reports.find(params[:id])
    @report.update(report_params)
    @report.viewed_at = Time.now
    redirect_to report_path(@report)
  end

  def destroy
    @report = current_user.reports.find(params[:id])
    @report.destroy
    redirect_to reports_path, status: :see_other
  end

  def share
    @report = current_user.reports.find(params[:id])
    @doctors = Doctor.all
    recipient_email = params[:report][:doctor_email]
    @link_for_qr_code = "www.thehealthbook.online/reports/#{@report.id}"
    @qr_code = RQRCode::QRCode.new(@link_for_qr_code)
    @svg = @qr_code.as_svg(
      offset: 1,
      color: white,
      shape_rendering: 'crispEdges',
      standalone: true,
      module_size: 4
    )
  end

  def email
    @report = Report.find(params[:id])
    @recipient_email = params[:doctor_email]
    HealthMailer.share_report(@report, @recipient_email).deliver_now

   redirect_to report_path(@report)
  end

  private

  require 'net/http'

  def report_params
    params.require(:report).permit(:title, :category, :note, :current_user_id, :report_date, :photo, :qr_code, :doctor_id, :doctor_first_name, :doctor_last_name, doctor_attributes: [:email, :first_name, :last_name, :specialty])
  end

  def doctor_params
    params.require(:doctor).permit(:first_name, :last_name, :specialty, :email)
  end
  def convert_image_to_content
    # image_url = Cloudinary::Utils.cloudinary_url(@report.photo)
    begin
      # uri = URI.parse(image_url)
      # response = Net::HTTP.get_response(uri)
      # tempfile = Tempfile.new(['image', '.png']).set_encoding('ASCII-8BIT')
      # tempfile.write(response.body)
      # RTesseract.new(tempfile.path).to_s
      uploaded_file = params[:report][:photo]
      result = RTesseract.new(uploaded_file.path).to_s
    end
  end

  def convert_pdf_to_text
    pdf_io = params[:report][:pdf].tempfile
    result = PDF::Reader.new(pdf_io).pages.first.text
  end

  def format_content(to_be_formatted)
    client = OpenAI::Client.new
    chaptgpt_response = client.chat(parameters: {
      model: "gpt-3.5-turbo",
      messages: [{ role: "user", content: "Format the report content for it to be displayed in a nice format. Make sure it is HTML formatted as it will be displayed in an html.erb file: #{to_be_formatted}. Give me only your formatted output, without any of your own comments"}]
      })
    chaptgpt_response["choices"][0]["message"]["content"]
  end
end
