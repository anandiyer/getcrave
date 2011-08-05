class UserVoteCity < ActiveRecord::Base
  validates_presence_of :email, :message => "email must be provided"
end
