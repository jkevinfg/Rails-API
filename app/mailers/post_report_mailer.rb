class PostReportMailer < ApplicationMailer
  def post_report(user, post, report)
    @post = post
    mail to: user.email, subject: "Report post#{post.id}"
  end
end
