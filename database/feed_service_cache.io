Table user_feed_chrono  {
  user_id bigint [primary key]
  posts json[] [note: 'by crono order']
}

Table home_feed_chrono {
  user_id bigint [primary key]
  posts json[] [note: 'by crono order']
}

Table country_feed_pop {
  country_id bigint [primary key]
  posts json[] [note: 'by like count']
}

Table region_feed_pop {
  region_id bigint [primary key]
  posts json[] [note: 'by like count']
}