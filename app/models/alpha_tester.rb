class AlphaTester < ActiveRecord::Base
  validates_uniqueness_of :facebook_id
end
