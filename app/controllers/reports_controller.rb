class ReportsController < ApplicationController
  require 'rqrcode'
  def index

    if params[:query].present?
      @reports = Report.search_by_title(params[:query])
    elsif params[:category].present?
      @reports = Report.where(category: params[:category])
    else
      @reports = Report.all
    end

    @categories = Report.pluck(:category).uniq
  end

  def show
    @report = Report.find(params[:id])
  end

  def new
    @report = Report.new
  end

  def create
    @report = Report.new(report_params)
    @report.user = current_user

    if params[:report][:photo].present?
      @report.content = convert_image_to_content
    elsif params[:report][:pdf].present?
      @report.content = convert_pdf_to_text
    end

    @report.save

    if @report.save
      redirect_to reports_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @report = Report.find(params[:id])
  end

  def update
    @report = Report.find(params[:id])
    @report = Report.update(report_params)
    redirect_to report_path(@report)
  end

  def destroy
    @report = Report.find(params[:id])
    @report.destroy
    redirect_to report_path(@report), status: :see_other
  end

  def share
    @report = Report.find(params[:id])
    @doctors = Doctor.all
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





  private

  require 'net/http'



  def report_params
    params.require(:report).permit(:title, :category, :content, :report_date, :photo, :qr_code)
  end

  def convert_image_to_content
    # image_url = Cloudinary::Utils.cloudinary_url(@report.photo)
    begin
      # uri = URI.parse(image_url)
      # response = Net::HTTP.get_response(uri) #  make an HTTP request to fetch the image data from the URL. The response object contains the image data.
      # tempfile = Tempfile.new(['image', '.png']).set_encoding('ASCII-8BIT') #  temporary file is created using Tempfile.new. The file is given a name starting with "image" and a ".png" extension to match the image format.
      # tempfile.write(response.body)
      # RTesseract.new(tempfile.path).to_s
      uploaded_file = params[:report][:photo]
      result = RTesseract.new(uploaded_file.path).to_s

      # formatted_result = result.gsub(/\. /, ".\n")
      # Example: Adding HTML formatting
      # formatted_result = "<p>#{ocr_result}</p>"
      # Example: Extracting specific information using regular expressions
      # dates = result.scan(/\b\d{2}\/\d{2}\/\d{4}\b/)
    end
  end

  def convert_pdf_to_text
    pdf_io = params[:report][:pdf].tempfile
    result = PDF::Reader.new(pdf_io).pages.first.text
  end

  # def format_content(to_be_formatted)
  #     client = OpenAI::Client.new
  #     chaptgpt_response = client.chat(parameters: {
  #       model: "gpt-3.5-turbo",
  #       messages: [{ role: "user", content: "Format the report content: #{to_be_formatted}. Give me only the text of report, without any of your own answer like 'Here is the formatted content'."}]
  #     })
  #     chaptgpt_response["choices"][0]["message"]["content"]
  # end
end
