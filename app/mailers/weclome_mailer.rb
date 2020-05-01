class WeclomeMailer < ApplicationMailer
    def send_welcome_email(user)
        @user = user
        
        mail to: @user.email, subject:  "Welcome to rails book", from: "noreply@rails-book.com"
    end
end
