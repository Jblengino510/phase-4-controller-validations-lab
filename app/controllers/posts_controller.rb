class PostsController < ApplicationController

  #SHOW/UPDATE/DESTROY is it in the DB?
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  #CREATE/UPDATE checks the model validations
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def show
    post = Post.find(params[:id])
    render json: post
  end

  def update
    post = Post.find_by(params[:id])
    post.update!(post_params)
    render json: post, status: :ok
  end

  private

  def post_params
    params.permit(:category, :content, :title)
  end

  def render_not_found_response
    render json: { error: "Post not found" }, status: :not_found
  end

  def render_unprocessable_entity_response(invalid)
    render json: { errors: invalid.record.errors }, status: :unprocessable_entity
  end

end
