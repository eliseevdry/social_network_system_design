// Replication:
// - master-slave (one sync + async) асинхронная, так как данные не особо критичные
// - replication factor 3
//
// - Sharding не требуется, так как общее количество данных за все время можно считать фиксированной величиной
// (ограничения по площади Земли/России - примерно 1 точка на кв км) 
// - на каждом хосте будет по несколько дисков (RAID)

Table point {
  id bigint [primary key]
  title varchar [not null]
  coordinates point [not null]
  post_count int
  region_id int
  created_at timestamp
}

Table country {
  id bigint [primary key]
  title varchar [not null]
  post_count int
}

Table region {
  id bigint [primary key]
  country_id bigint
  title varchar [not null]
  post_count int
}

Ref: point.region_id > region.id

Ref: region.country_id > country.id