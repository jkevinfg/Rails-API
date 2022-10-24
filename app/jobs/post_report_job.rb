class PostReportJob < ApplicationJob
  queue_as :default

  def perform(post_id)
    post = Post.find(post_id)
    PostReport.generate(post)
  end
end
