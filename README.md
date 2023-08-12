# README

Completed all features till level 3. Also included every feature from level 5 except Revision history (Reading time can be calculated on frontend side).  
(Added features: Posts (drafts and published), Lists, Bookmarks)
For Level 4: Added the payment gateway using stripe. User can pay for subscription by going to 'http://127.0.0.1:3000/checkout'. There will be a button there that will lead to stripe page.
For testing code using Postman:

* Users


=> Post -   http://127.0.0.1:3000/users    [For register]
{
  "user": {
    "email": "test@example.com",
    "password": "password",
    "password_confirmation": "password",
    "name": "Test User"
  }
}

=> Post -   http://127.0.0.1:3000/users/sign_in   [For signin]
{
  "user": {
    "email": "test@example.com",
    "password": "password"
  }
}

=> Get - http://127.0.0.1:3000/users/:id   [For getting user profile (with no. of followers and following)]

=> Post -   http://127.0.0.1:3000/users/:user_id/relationships   [For following user having given user_id]

=> Delete  -   http://127.0.0.1:3000/users/:user_id/relationships   [For unfollowing user having given user_id]

=> Delete  -   http://127.0.0.1:3000/users/sign_out  [for log out]


* Posts 

=> POST URL: http://127.0.0.1:3000/posts (for making a post)
{
  "post": {
    "title": "My New Post",
    "topic": "Technology",
    "text": "This is the content of my new post.",
    "published_datetime": "2023-08-05T12:00:00"
  }
}

=> POST URL: http://127.0.0.1:3000/posts/publish (making published post)

{
  "post": {
    "title": "My Published Post",
    "topic": "Technology",
    "text": "This is the content of my published post.",
    "published_datetime": "2023-08-05T10:00:00"
  },
  "publish": true
}


=> POST URL: http://127.0.0.1:3000/posts/draft (making a draft post)

{
  "post": {
    "title": "My Draft Post",
    "topic": "Technology",
    "text": "This is the content of my draft post.",
    "published_datetime": "2023-08-05T10:00:00"
  },
  "publish": false
}


=> GET URL: http://127.0.0.1:3000/posts/my_posts (for current loggedin user to get his posts (with likes and comments counts))

=> GET URL: http://127.0.0.1:3000/posts/top_posts (top posts (By likes))

=> GET URL: http://127.0.0.1:3000/posts/posts_by_topic?topic=Technology (for getting posts by topic, here I use Technology)

=> GET URL: http://127.0.0.1:3000/posts/recommended_posts (for recommended posts, I used most liked ones (because it was showing to use ML for it))

=> GET URL: http://127.0.0.1:3000/posts/most_commented_posts (most commented posts)

=> GET URL: http://127.0.0.1:3000/posts/posts_by_date?start_date=<start_date>&end_date=<end_date>  (For getting posts published between these dates)

=>PUT or PATCH URL: http://127.0.0.1:3000/posts/:id (For editing the post (only authorize user can edit it))
{
  "post": {
    "title": "Updated Post Title",
    "topic": "Updated Topic",
    "text": "Updated content of the post.",
    "published_datetime": "2023-08-05T14:00:00"
  }
}

=> DELETE URL: http://127.0.0.1:3000/posts/:id (deleting the post (only authorize user can delete it))

* Bookmarks

=> POST URL: http://127.0.0.1:3000/posts/:id/bookmark (user can bookmark a post to read it later)

=> GET URL: http://127.0.0.1:3000/posts/bookmarked_posts (user can get all the posts he bookmarked).


* Lists

=> POST URL: http://127.0.0.1:3000/lists   (user can create a new list)

{
  "list": {
    "title": "My Reading List",
    "description": "A collection of interesting posts."
  }
}

=> PUT URL: http://127.0.0.1:3000/lists/:id  (user can update his list)

{
  "list": {
    "title": "Updated Reading List",
    "description": "An updated collection of posts."
  }
}


=> POST URL: http://127.0.0.1:3000/lists/:list_id/list_items   (user can add post to his list)

{
  "list_item": {
    "post_id": [Post ID]
  }
}

=> GET URL: http://127.0.0.1:3000/lists/:id   (for getting all the information about his/her list)


* Likes

=> POST URL: http://127.0.0.1:3000/posts/:post_id/likes (for liking the post by current loggedin user)
{
  "like": {
  }
}

=> DELETE URL: http://127.0.0.1:3000/posts/:post_id/likes (for unliking the post by current loggedin user)

=> GET URL: http://127.0.0.1:3000/posts/:post_id/likes/users (for viewing users who liked the post)

=> GET URL: http://127.0.0.1:3000/posts/:post_id/likes/count (for getting like count)

* Comments

=> POST URL: http://127.0.0.1:3000/posts/:post_id/comments (posting a comment by loggedin user)
{
  "comment": {
    "text": "This is a new comment."
  }
}

=> DELETE URL: http://127.0.0.1:3000/posts/:post_id/comments/:comment_id (for deleting the comment by original user)

=> GET URL: http://127.0.0.1:3000/posts/:post_id/comments/:comment_id (for getting a comment for a given post).

* Follow operations (Relationships)

=> POST URL: http://127.0.0.1:3000/users/:user_id/relationships (for following user having given user_id by loggedin user)
{
  "relationship": {
  }
}

=>DELETE URL: http://127.0.0.1:3000/users/:user_id/relationships (for unfollowing)





