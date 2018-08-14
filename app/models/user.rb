class User < ApplicationRecord
  devise :two_factor_authenticatable,
  			 :two_factor_backupable,
         :otp_secret_encryption_key => Rails.application.secrets.otp_key

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
	has_many :whatspp_messages
	has_many :events, through: :whatspp_messages
	enum role: {
		'admin': 0,
		'worker': 1
	}

	def otp_qr_code
    issuer = 'Khushi'
    label = "#{issuer}:#{email}"
    qrcode = RQRCode::QRCode.new(otp_provisioning_uri(label, issuer: issuer))
    qrcode.as_svg(module_size: 4)
  end

  def otp_backup_codes
    super_return_value = super
    JSON.parse(super_return_value) if super_return_value.present?
  end	

  def generate_new_mobile_otp
    otp = rand(10**6)
    self.sms_otp = otp
    self.save
  end

  def send_otp_to_user_mobile
    require 'twilio-ruby'

    # # Your Account Sid and Auth Token from twilio.com/console
    account_sid = Rails.application.secrets.twilio_account_sid
    auth_token = Rails.application.secrets.twilio_auth_token
    @client = Twilio::REST::Client.new(account_sid, auth_token)

    # message = @client.messages
    #   .create(
    #      body: "OTP #{self.sms_otp}",
    #      from: '+13073177442', 
    #      # status_callback: 'http://requestb.in/1234abcd',
    #      to: self.phone_number.to_s
    #    )

    @client = Twilio::REST::Client.new(account_sid, auth_token)

    message = @client.messages.create(
                                 body: "OTP #{self.sms_otp}",
                                 from: 'whatsapp:+441618507453',
                                 to: "whatsapp:#{self.phone_number.to_s}"
                               )

    puts message.sid

  end
end
