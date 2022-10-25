class PostReportMailer < ApplicationMailer
  def post_report(user, post, report)
    # report => struct PostReport
    @post = post
    @report = report.word_count
    mail to: user.email, subject: "Report post#{post.id}"
  end
end
