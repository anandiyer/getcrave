class Notifier < ActionMailer::Base
  default :from => "crave@getcrave.com"

  # send a signup email to the user, pass in the user object that contains the user's email address
  def signup_email(user)
    if (user.email && !user.email.empty?)
      mail( :to => user.email, :subject => "Thanks for signing up for crave!", :body => "Your friends at crave" )
    end
  end
  
  def review_helpful(current_user, to_user, menu_item)
    if (to_user.email && !to_user.email.empty?)
      p "HERE - review helpful!"
      @body = "Hey there, " + current_user.user_name + " found your crave of " + menu_item.name + 
        " helpful. Check it out. http://getcrave.com/menu_items/" + menu_item.id.to_s
      mail( :to => to_user.email, :subject => "Someone liked your crave!", :body => @body)
    end
  end
  
  def follow_user_email(current_user, to_user)
    if (to_user.email && !to_user.email.empty?)
      @subject = current_user.user_name + " is now following you on crave"
      @body = "Hey there, " + current_user.user_name + " (http://getcrave.com/users/" + current_user.id.to_s + " )" +
      " seems to be digging your reviews and " +
      " has just started following you on crave. crave on!"

      p "HERE - follow_user_email"
      p to_user.email
      p @subject
      p @body
      
      mail( :to => to_user.email, :subject => @subject, :body => @body)
    end
  end
  
end