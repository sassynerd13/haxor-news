class CommentSerializer < ActiveModel::Serializer
  attributes :id, :user_email, :body, :score, :created_at

  def user_email
    object.user.email
  end
end
