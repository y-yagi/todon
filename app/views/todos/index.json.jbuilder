json.array!(@todos) do |todo|
  json.extract! todo, :detail, :tag_id, :priority
  json.end_date_month todo.end_date.month
  json.end_date_day todo.end_date.day
  json.url todo_url(todo, format: :json)
end
