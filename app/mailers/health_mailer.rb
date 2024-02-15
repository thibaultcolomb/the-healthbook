require "open-uri"
class HealthMailer < ApplicationMailer
  default from: "info@thehealthbook.online"
  def share_report(report, recipient_email)
    @report = report

    if @report.pdf.attached?
      attachments["#{report.title}.pdf"] = open(Cloudinary::Utils.cloudinary_url(@report.pdf.key)).read
    end
    mail(to: recipient_email, subject: "Report: #{report.title}")
  end
end
