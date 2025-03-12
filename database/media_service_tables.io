// Replication:
// - master-slave (one sync + async) асинхронная, так как данные не особо критичные
// - replication factor 3
//
// Sharding:
// - key based by post_id (чтобы обеспечить равномерное распределение по шардам + основная запросы будут по post_id)
// - 1000 virtual shards (чтобы упростить дальнейшее увеличение количества физических шардов)
// - использование CDN для быстрого доступа к данным в разных уголках СНГ
// - обращение к шардам через proxy

Table relation {
  key varchar [not null]
  post_id bigint
  created_at timestamp
}