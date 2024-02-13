class NewReportJob < ApplicationJob
  queue_as :default

  sidekiq_options retry: false

  def perform(report_id, to_be_formatted)
    client = OpenAI::Client.new
    chaptgpt_response = client.chat(parameters: {
      model: "gpt-3.5-turbo",
      messages: [{ role: "user", content: "Format the report content for it to be displayed in a nice format. Make sure it is HTML formatted as it will be displayed in an html.erb file: #{to_be_formatted}. Give me only your formatted output, without any of your own comments"}]
      })
    formatted_note = chaptgpt_response["choices"][0]["message"]["content"]

    report = Report.find(report_id)
    report.update(note: formatted_note)
  end
end
