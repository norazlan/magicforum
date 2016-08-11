class TopicPolicy < ApplicationPolicy

  def new?
    user.present? && user.admin?
  end

  def create?
    new?
  end

  def edit?
    user.present? && poswer_user?
  end

  def update?
    user.present? && poswer_user?
  end

  def destroy?
    new?
  end

  private
  def poswer_user?
    user.admin? || user.moderator?
  end

end
