// Replication:
// - master-slave (one sync + async) асинхронная, так как данные не особо критичные
// - replication factor 3
//
// Sharding:
// - key based by post_id (чтобы обеспечить равномерное распределение по шардам и чтобы не перегружать какой-то из шардов)
// - 1000 virtual shards (чтобы упростить дальнейшее увеличение количества физических шардов)
// - обращение к шардам через coordinator, который будет уметь выполнять аггрегированные запросы (для составлении ленты)

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