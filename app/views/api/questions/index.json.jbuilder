json.array! @questions do |question|
  json.extract! question, :id, :title, :body, :created_at
end