class Authorization < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user_id, :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider
  

  def self.find_from_hash(hash)
    p hash['provider']
    p hash['uid']
    find_by_provider_and_uid(hash['provider'], hash['uid'])
  end

  def self.create_from_hash(hash, user = nil)
    "create Authorization---------------------------"

    if (hash['provider'] == 'facebook')
      p user ||= User.create_from_hash_facebook!(hash)
      secret = ''
    elsif (hash['provider'] == 'twitter')
      p user ||= User.create_from_hash_twitter!(hash)
      secret = hash['credentials']['secret']
    elsif (hash['provider'] == 'foursquare')
      secret = hash['credentials']['secret']
    end

    auth = Authorization.create(:user => user, 
      :uid => hash['uid'], 
      :provider => hash['provider'], 
      :token => hash['credentials']['token'],
      :secret => secret,
      :provider_user_name => hash['user_info']['nickname'])

    p auth.errors
    p auth.valid?

    if !auth.valid?
      a_find = Authorization.find_from_hash(hash)
      a_find.token = hash['credentials']['token']
      a_find.secret = hash['credentials']['secret']
      a_find.save
      return a_find
    end
    
    return auth
  end
  
end
