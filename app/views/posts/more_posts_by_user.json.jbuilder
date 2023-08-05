
json.more_posts_by_user @more_posts do |post|
  json.id post.id
  json.title post.title
  json.text post.text
  json.published_datetime post.published_datetime
  json.number_of_likes post.likes.count
  json.number_of_comments post.comments.count
end
