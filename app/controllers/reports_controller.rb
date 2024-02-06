class ReportsController < ApplicationController

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

  def new
    @report = Report.new
  end

  def create
    @report = Report.new(report_params)
    @report.user = current_user
    @report.save

    if @report.save
      redirect_to reports_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def report_params
    params.require(:report).permit(:title, :category, :content, :report_date)
  end
end
