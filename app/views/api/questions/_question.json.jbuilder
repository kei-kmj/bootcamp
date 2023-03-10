json.id question.id
json.title question.title
json.url question_url(question)
json.has_correct_answer question.correct_answer.present?
json.wip question.wip
json.updated_at question.updated_at

if question.published_at.present?
  json.published_at question.published_at
end

json.user do
  json.partial! 'api/users/user', user: question.user
end

json.practice do
  json.title question.practice.title
  json.id question.practice.id
end if question.practice

json.answers do
  json.size question.answers.size
end

json.tags question.tags.each do |tag|
  json.name tag.name
  json.url questions_url(tag: tag.name)
end
