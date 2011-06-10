class Notifier < ActionMailer::Base
  default :from => "no-reply@getcrave.com"

  # send a signup email to the user, pass in the user object that contains the user's email address
  def signup_email(user)
    mail( :to => user.email, :subject => "Thanks for signing up for Crave!", :body => "Your friends at Crave" )
  end
  
  def review_helpful(current_user, to_user, menu_item)
    @body = "Hey there, " + current_user.user_name + " found your Crave of " + menu_item.name + 
      " helpful. Check it out. http://getcrave.com/menu_items/" + menu_item.id.to_s
    
    mail( :to => to_user.email, :subject => "Someone liked your Crave!", :body => @body)
  end
end