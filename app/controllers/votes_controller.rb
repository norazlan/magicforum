class VotesController < ApplicationController
  respond_to :js
  before_action :authenticate!
  before_action :find_or_reate_vote

  def upvote
    update_vote(1)
    flash.now[:sucess] = "You have liked this comment"
  end

  def downvote
    update_vote(-1)
    flash.now[:success] = ":( You have take back your like on this comment"
  end

  private

  def find_or_reate_vote
    @vote = current_user.votes.find_or_create_by(comment_id: params[:comment_id])
  end

  def update_vote(value)
    if @vote && @vote.value != value
      @vote.update(value: value)
    end
  end



end
