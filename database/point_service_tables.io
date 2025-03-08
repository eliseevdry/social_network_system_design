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