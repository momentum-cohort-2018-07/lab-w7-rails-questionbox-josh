class AnswerMailer < ApplicationMailer
  
 
  def answer_noti(user)
    @user = user
    @greeting = "You have recieved a potential answer to your question, Please review!"
    mail(to: @user, from: 'noreply@questionbox.com', subject: 'Your Question Recieved an Answer')
  end
end
