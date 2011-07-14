class UserFollowing < ActiveRecord::Base
  belongs_to :user
  validates_uniqueness_of :following_user_id, :scope => :user_id, :message => "this user is already being followed"

  def following_user
    User.where(:id => self.following_user_id).first
  end

end