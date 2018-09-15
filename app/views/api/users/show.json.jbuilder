json.links do
  json.self api_user_url(@user)
  json.list api_users_url
end
json.data do
  json.id @user.id
  json.attributes do
    json.username @user.username
    json.api_token @user.api_token
    json.questions_count @user.questions.count
    json.questions @user.questions
    json.answers_count @user.answers.count
    json.answers @user.answers
  end
end