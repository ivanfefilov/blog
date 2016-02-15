class UserMailer < ActionMailer::Base
  def comments_email(user, post)
    recipients    user.email
    from          "Blog site <notifications@example.com>"
    subject       "Congratulation! Your post got 3 comments"
    sent_on       Time.now
    @body[:user] = user
    @body[:post] = post
  end
end
