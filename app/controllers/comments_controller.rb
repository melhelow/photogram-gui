class CommentsController < ApplicationController
  def create
    author_id = params.fetch("query_author_id")
    photo_id = params.fetch("query_photo_id")
    body = params.fetch("query_body")

    new_comment = Comment.new
    new_comment.author_id = author_id  # <== use author_id here
    new_comment.photo_id = photo_id
    new_comment.body = body

    if new_comment.save
      redirect_to("/photos/#{photo_id}")
    else
      render plain: "Failed to save comment: #{new_comment.errors.full_messages.join(', ')}", status: 400
    end
  end
end
