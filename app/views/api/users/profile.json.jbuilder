json.links do
  json.self api_profile_path
  json.update do
    json.method "PUT"
    json.href api_user_url(@user)
  end
  json.delete do
    json.method "DELETE"
    json.href api_user_url(@user)
  end
end
json.data do
  json.id @user.id
  json.attributes do
    json.first_name @user.first_name
    json.last_name @user.last_name
    json.username @user.username
    json.email @user.email
    json.api_token @user.api_token
    json.questions @user.questions.count
    json.answers @user.answers.count
  end
end