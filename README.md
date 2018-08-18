# Khushi
A WhatsApp Parser web Application built on Ruby on Rails using WhatsApp API provided by Twilio. 

## Working Demo

https://969472a4.ngrok.io

WhatsApp Number where you can send messages: `+44 161 850 7453`.
During the signup process, you will be asked to give your phone number. However to receive OTP, you need first send `join mulberry-chamois` to the above number. 
#### What messages you will receive?
Only OTP for phone number verification. 

## Kick Start Application
#### Step 1 (Clone the Application): 
Via SSH
```
git clone git@github.com:NoSkillGuy/khushi.git
```
Via HTTPS 
```
git clone https://github.com/NoSkillGuy/khushi.git
```

#### Step 2 (Set the environment variables):
Ideally these variables should go to `~/.zshrc` or `~/.bashrc` or `~/.environmentrc` file.
```
export SENDMAIL_USERNAME=YOUR_GMAIL_USER_NAME
export SENDMAIL_PASSWORD=YOUR_GMAIL_PASSWORD
export MAIL_HOST=YOUR_MAIL_HOST
export MAIL_DOMAIN=gmail.com
export OTP_SECRET_ENCRYPTION_KEY=YOUR_OTP_SECRET_ENCRYPTION_KEY
export OTP_KEY=YOUR_OTP_KEY
export TWILIO_ACCOUNT_SID=YOUR_TWILIO_ACCOUNT_SID
export TWILIO_AUTH_TOKEN=YOUR_TWILIO_AUTH_TOKEN
```
Make sure you replace the above variables with actual values.

`YOUR_OTP_SECRET_ENCRYPTION_KEY` and `YOUR_OTP_KEY` can be replaced with values generated by either `bin/rake secret` or `bin/rails secret`

`YOUR_TWILIO_ACCOUNT_SID` and `YOUR_TWILIO_AUTH_TOKEN` can be found at [Twilio](https://www.twilio.com/console). You can learn more details on how to use WhatsApp API [here](https://www.twilio.com/console/sms/whatsapp/sandbox)

`YOUR_MAIL_HOST` can't be localhost because you need to send and receive WhatsApp Messages over a secure protocol(HTTPS). Solution for this: [ngrok](https://ngrok.com/) (ngrok exposes local servers behind NATs and firewalls to the public internet over secure tunnels.)

[Download ngrok](https://ngrok.com/download)
```
1. Open a new tab/ terminal
2. cd /path/to/ngrok
3. unzip /path/to/ngrok.zip
4. ./ngrok http 3001
```
Now, you will something similar to this `Forwarding https://969472a4.ngrok.io -> localhost:3001`. Here, your `YOUR_MAIL_HOST` is `https://969472a4.ngrok.io`

#### Step 3 (Running the application):
```
bin/rails s -p 3001
```



