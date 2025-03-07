Table post {
  id bigint [primary key]
  user_id bigint
  point_id bigint
  title varchar [not null]
  content varchar[] [not null]
  created_at timestamp
}

Table comment {
  id bigint [primary key]
  post_id bigint
  user_id bigint
  reply_comment_id bigint
  title varchar [not null]
  created_at timestamp
}

Table like {
  id bigint [primary key]
  post_id bigint
  user_id bigint
  created_at timestamp
}


Ref: comment.post_id > post.id

Ref: like.post_id > post.id