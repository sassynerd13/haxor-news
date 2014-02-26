class ArticleSerializer < ActiveModel::Serializer
  attributes :id,
    :user_email,
    :title,
    :url,
    :score,
    :current_vote,
    :created_at

  def user_email
    object.user.email
  end

  def current_vote
    object.vote_for(current_user).try(:direction)
  end
end
