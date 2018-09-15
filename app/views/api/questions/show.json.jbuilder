json.links do
  json.self api_question_url(@question)
  json.list api_questions_url
end
json.data do
  json.id @question.id
  json.attributes do
    json.title @question.title
    json.question @question.question
    json.answers_count @question.answers.count
    json.answers @question.answers
  end
end