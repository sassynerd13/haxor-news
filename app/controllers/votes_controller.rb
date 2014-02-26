class VotesController < ApplicationController
  before_action :authenticate_user!

  def update
    vote = Vote.find_or_initialize_by(user: current_user, votable: votable)
    vote.update!(direction: params[:direction])

    respond_to do |wants|
      wants.html { redirect_to :back }
      wants.json { render json: vote }
    end
  end

  private

  def votable
    votable_id = params["#{params[:votable_type].underscore}_id"]
    params[:votable_type].constantize.find(votable_id)
  end
end
