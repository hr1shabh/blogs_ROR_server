json.my_posts @my_posts do |post|
  json.id post.id
  json.title post.title
  json.text post.text
  json.status post.status
  json.author post.user.name
  json.published_datetime post.published_datetime
  json.number_of_likes post.likes.count
  json.number_of_comments post.comments.count
  json.view_count post.view_count # Add this line
end
