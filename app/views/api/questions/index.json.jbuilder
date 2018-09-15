json.array! @questions do |question|
  json.extract! question, :id, :title, :question, :created_at
end