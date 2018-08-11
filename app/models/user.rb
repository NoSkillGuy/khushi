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
end
