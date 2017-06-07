class PostMailer < ActionMailer::Base
  default from: "support@blog.com"

  def post_created user,post
  	@post = post

  	send_mail user.email,"Successfully created post #{post.title}"
  end

  def post_updated
  
  	send_mail user.email,"Successfully created post #{post.title}"
  end 

  def comment_on_post post,commentor
  	@post = post
  	@commentor = commentor
  	send_mail user.email,"#{commentor.name} commented on your post #{post.title}"
  end

  def reply_on_comment post,commentor,comment
  	@post = post
  	@commentor = commentor
  	@comment = comment
  	send_mail user.email,"#{commentor.name} replied on your comment"
  end

  private 

  def send_mail to,subject
  	mail(to: to ,  subject: subject)
  end

end
