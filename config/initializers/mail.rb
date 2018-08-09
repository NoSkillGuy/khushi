ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.default_url_options = { host: ENV['MAIL_HOST'] }
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  user_name:      ENV['SENDMAIL_USERNAME'],
  password:       ENV['SENDMAIL_PASSWORD'],
  domain:         ENV['MAIL_DOMAIN'],
  address:       'smtp.gmail.com',
  port:          '587',
  authentication: :plain,
  enable_starttls_auto: true
}