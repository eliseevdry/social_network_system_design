// Replication:
// - master-slave (one sync + async) асинхронная, так как данные не особо критичные
// - replication factor 2 + backup-ы каждые 2 часа
//
// Sharding не требуется, так как мы можем примерно посчитать сколько понадобится данных для хранения
// (количество пользователей * 2) и capacity очень низкое. Шардирование только увеличит latency.

Table relation {
  from_user_id bigint
  to_user_id bigint
}

Table influencer {
  user_id bigint
  subscribers_count int
}