require "rake"

desc 'send email to report sales'
task send_email_to_report_sales: :environment do
  ReportSaleMailer.send_report_sales.deliver_later
end
