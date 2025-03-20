# social_network_system_design
Developing a social network architecture for travelers
System Design of a social network for travelers [System Design course](https://balun.courses/courses/system_design)

## Функциональные требования:
- публикация постов из путешествий с фотографиями, небольшим описанием и привязкой к конкретному месту путешествия;
- оценка и комментарии постов других путешественников;
- подписка на других путешественников, чтобы следить за их активностью;
- поиск популярных мест для путешествий и просмотр постов с этих мест;
- просмотр ленты других путешественников и ленты пользователя, основанной на подписках в обратном хронологическом порядке;
- взаимодействие через мобильные устройства и браузер

## Нефункциональные требования:
- DAU: 10 000 000
- Геораспределенность: страны СНГ
- Отказоустойчивость: 99.995
- Сезонность: возрастающая нагрузка летом + выходные и праздники (множитель сезона: 1.3)
- 2 секунды отправка поста
- 1 секунда отправка комментария к посту
- 1 секунда поставить оценку посту
- 2 секунды загрузка ленты
- хранение постов всегда
- запись поста в среднем на пользователя 15 постов в год
- запись комментария в среднем на пользователя 2 раза в день
- оценка поста в среднем 10 постов в день
- подписка/отписка в среднем 50 раз в год
- чтение ленты 100 постов в день (10 раз по 10 постов в выдаче)
- чтение комментариев к постам 50 комментариев в день (5 постов по 10 комментариев в выдаче)
- просмотр лайков к постам 50 лайков в день (5 постов по 10 лайков в выдаче)
- максиммум 10 000 подписок может иметь пользователь
- максимум 3 фотографии на пост
- размер фотографии максимум 500KB
- комментарии и описание постов максимум 2000 символов
- просмотр карты (поиск точки) 10 раз в день (увеличение - уменьшение карты)

## Объем данных
### write (post):
``
  {
    "userId": 88329,
    "title": "Эйфелева башня в Париже",
    "pointId": 88329,
    "content": ["binary500KB", "binary500KB", "binary500KB"]
  }
``
size-media: 3 * 500 000b = 1 500 000b
size-meta: 8b + (2000 * 2b) + 8b + (2000 * 2b) + (2000 * 2b) + (2000 * 2b) = 16 016b

### write (point):
``
{
  "title": "Эйфелева башня (южная сторона)",
  "latitude": 48.8584,
  "longitude": 2.2945
}
``
size: (2000 * 2b) + 8b + 8b = 4016b

### write (comment):
``
  {
    "postId": 13129,
    "userId": 7281,
    "comment": "Красиво, скоро приеду"
  }
``
size: 8b + 8b + (2000 * 2b) = 4 016b

### write (like):
``
  {
    "postId": 13129,
    "userId": 7281
  }
``
size: 8b + 8b = 16b

### write (follow):
``
  {
    "authorId": 88329,
    "followerId": 7281,
    "follow": true
  }
``
size: 8b + 8b = 16b

### read (points):
``
[
  {
    "id": 2281712345678901200,
    "title": "Эйфелева башня (южная сторона)",
    "latitude": 48.8584,
    "longitude": 2.2945,
    "country": "Франция",
    "region": "Париж",
    "postCount": 9271,
    "createdDate": 1739539192
  }
]
``
size: 8b + (2000 * 2b) + 8b + 8b + (200 * 2b) + (200 * 2b) + 4b + 8b = 4 836b * 50 = 241 800b

### read (posts):
``
[
  {
    "postId": 13129,
    "authorId": 88329,
    "pointId": 7218,
    "title": "Эйфелева башня в Париже",
    "likesCount": 6,
    "commentsCount": 1,
    "content": ["binary500KB", "binary500KB", "binary500KB"],
    "createdDate": 1739539192
  }
]
``
size-media: 3 * 500 000 b = 1 500 000 b * 10 (постов в выдаче) = 15 000 000 b
size-meta: 8b + 8b + 8b + (2000 * 2b) + 4b + 4b + (2000 * 2b) + (2000 * 2b) + (2000 * 2b) = 16 032 b * 10 (постов в выдаче) = 160 320 b
size-points: 8b + (2000 * 2b) + 8b + 8b + (200 * 2b) + (200 * 2b) + 4b + 8b = 4 836b * 10 (постов в выдаче) = 48 360b

### read (comments):
``
[
  {
    "id": 22817,
    "userId": 7281,
    "title": "Красиво, скоро приеду",
    "createdDate": 1739539192
  }
]
``
size: 8b + 8b + (2000 * 2b) + 8b = 4 024b * 10 = 40 240b

### read (likes):
``
[
  {
    "id": 22817,
    "userId": 7281,
    "createdDate": 1739539192
  }
]
``
size: 8b + 8b + 8b = 24b * 10 = 240b

## RPS
- write (post - media): (13 000 000 * 0,041095890410959) / 86 400sec = 6
- write (post - meta): (13 000 000 * 0,041095890410959) / 86 400sec = 6
- write (point): (13 000 000 * 0,041095890410959) / 86 400sec = 6
- write (comment): (13 000 000 * 2) / 86 400sec = 301
- write (like): (13 000 000 * 10) / 86 400sec = 1 505
- write (follow): (13 000 000 * 0,136986301369863) / 86 400sec = 21
- read (posts - media): (13 000 000 * 10) / 86 400sec = 1 505
- read (posts - meta): (13 000 000 * 10) / 86 400sec = 1 505
- read (posts-points): (13 000 000 * 10) / 86 400sec = 1 505
- read (points): (13 000 000 * 10) / 86 400sec = 1 505
- read (comments): (13 000 000 * 5) / 86 400sec = 3 010
- read (likes): (13 000 000 * 5) / 86 400sec = 3 010

## traffic
- write (post-media): 6 RPS * 1 500 000b = 9 000 000 b = 9 Mb/sec
- write (post-meta): 6 RPS * 16 016b = 96 096 b = 0,096 Mb/sec
- write (point): 6 RPS * 4 016b = 24 096 b = 0,024 Mb/sec
- write (comment): 301 RPS * 4 016b = 1 208 816 b = 1,2 Mb/sec
- write (like): 1 505 RPS * 16b = 24 080 b = 0,024 Mb/sec
- write (follow): 21 RPS * 16b = 336 b = 0,0003 Mb/sec
- read (posts-media): 1 505 RPS * 15 000 000b = 22 575 000 000 b = 22 575 Mb/sec
- read (posts-meta): 1 505 RPS * 160 320 b = 241 281 600 b = 241 Mb/sec
- read (posts-points): 1 505 RPS * 48 360b = 72 781 800 b = 73 Mb/sec
- read (points): 1 505 RPS * 241 800 b = 363 909 000 b = 364 Mb/sec
- read (comments): 3 010 RPS * 40 240b = 121 122 400 b = 121 Mb/sec
- read (likes): 3 010 RPS * 240b = 722 400 b = 0,7 Mb/sec

Преобладает трафик на чтение

## connections
Число одновременных подключений: 13 000 000 * 0,1 = 1 300 000

## capacity (1 year)
- write (post-media): 9 Mb/sec * 86400 * 365 = 284 Tb
- write (post-meta): 0,096 Mb/sec * 31536000 = 3 Tb
- write (comment): 1,2 Mb/sec * 31536000 = 38 Tb
- write (like): 0,024 Mb/sec * 31536000 = 1 Tb
- write (point): 0,024 Mb/sec * 31536000 = 1 Tb
- write (follow): 0,0003 Mb/sec * 31536000 = 0,009 Tb

## disks
post-service:  9337 RPS, 370 Mb/s, 42 Tb
point-service: 3016 RPS, 440 Mb/s, 1 Tb
relation-service: 50 RPS, 0,001 Mb/s, 0,009 Tb
media-service: 1 511 RPS, 22 584 Mb/sec, 284 Tb

#### HDD
post-service: (9337 RPS / 100 = 94) or (370 Mb/s / 100 Mb/s = 4) or (42 Tb / 20 Tb = 3) = 94 disks by 1 Tb (3500 $)
point-service: (3016 RPS / 100 = 31) or (440 Mb/s / 100 Mb/s = 5) or (1 Tb / 20 Tb = 1) = 31 disks by 0,5 Tb (600 $)
relation-service: (50 RPS / 100 = 1) or (0,001 Mb/s / 100 Mb/s = 1) or (0,009 Tb / 20 Tb = 1) = 1 disk by 0,5 Tb (20 $)
media-service: (1 511 RPS / 100 = 16) or (22 584 Mb/sec / 100 Mb/s = 226) or (284 Tb / 20 Tb = 15) = 226 disks by 2 Tb (18080 $)
#### SSD (SATA)
post-service: (9337 RPS / 1000 = 10) or (370 Mb/s / 500 Mb/s = 1) or (42 Tb / 80 Tb = 1) = 10 disks by 5 Tb (4500 $)
point-service: (3016 RPS / 1000 = 4) or (440 Mb/s / 500 Mb/s = 1) or (1 Tb / 80 Tb = 1) = 4 disks by 0,5 Tb (150 $)
relation-service: (50 RPS / 1000 = 1) or (0,001 Mb/s / 500 Mb/s = 1) or (0,009 Tb / 80 Tb = 1) = 1 disk by 0,5 Tb (40 $)
media-service: (1 511 RPS / 1000 = 2) or (22 584 Mb/sec / 500 Mb/s = 46) or (284 Tb / 80 Tb = 4) = 46 disk by 10 Tb (69000 $)
#### SSD (nVME)
post-service: (9337 RPS / 10 000 = 1) or (370 Mb/s / 3000 Mb/s = 1) or (42 Tb / 20 Tb = 3) = 3 disks by 20 Tb (18 000 $)
point-service: (3016 RPS / 10 000 = 1) or (440 Mb/s / 3000 Mb/s = 1) or (1 Tb / 20 Tb = 1) = 1 disks by 1 Tb (200 $)
relation-service: (50 RPS / 10 000 = 1) or (0,001 Mb/s / 3000 Mb/s = 1) or (0,009 Tb / 20 Tb = 1) = 1 disk by 0,5 Tb (100 $)
media-service: (1 511 RPS / 10 000 = 1) or (22 584 Mb/sec / 3000 Mb/s = 8) or (284 Tb / 20 Tb = 15) = 15 disks by 20 Tb (90000 $)

### final configuration
post-service: 10 SSD(SATA) by 5 Tb (4500 $)
point-service: 4 SSD(SATA) by 0,5 Tb (150 $)
relation-service: 1 HDD by 0,5 Tb (20 $)
media-service: 15 SSD(nVME) by 20 Tb (90000 $)

## hosts
post-service (PgSQL): 15 hosts by 2 disks
point-service (PgSQL): 3 hosts by 4 disks (RAID)
relation-service (PgSQL): 2 hosts by 1 disk
media-service (Amazon S3): 23 hosts by 2 disks

PgSQL:
1) хорошо работает с relation
2) транзакционность из коробки
3) больше экспертизы среди разработчиков

Amazon S3:
1) типичный выбор для blob storage
2) больше экспертизы среди разработчиков
3) репликация из коробки

Так же, исходя из ограничений доступа на территории СНГ, в качестве альтернативы можно использовать Yandex Object Storage
вместо Amazon S3 (гипотеза, нужно изучить может ли из коробки реплицироваться)

Полезные ссылки:
https://www.plantuml.com/
https://editor.swagger.io/
https://dbdiagram.io/