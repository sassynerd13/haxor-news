class VoteSerializer < ActiveModel::Serializer
  attributes :direction, :votable_score

  def votable_score
    object.votable.score
  end
end
