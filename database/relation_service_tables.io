// Replication:
// - master-slave (one sync + async) асинхронная, так как данные не особо критичные
// - replication factor 2 + backup-ы каждые 2 часа
//
// Sharding не требуется, так как мы можем примерно посчитать сколько понадобится данных для хранения
// (users * 10 000 подписок максимум = 40 Tb на СНГ) за год ожидаемое увеличение capacity меньше 0,009 Tb
// Шардирование только увеличит latency

Table relation {
  from_user_id bigint
  to_user_id bigint
}

Table influencer {
  user_id bigint
  subscribers_count int
}