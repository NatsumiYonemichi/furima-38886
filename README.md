# テーブル設計

## users テーブル

| Column             | Type   | Options     |
|------------------- | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |
| family_name        | string | null: false |
| first_name         | string | null: false |
| family_name_kana   | string | null: false |
| first_name_kana    | string | null: false |
| birthday           | date   | null: false |

## Association

- has_many :items
- has_one  :card
- has_one  :payment


## cards テーブル

| Column             | Type       | Options                        |
|------------------- | ------     | ------------------------------ |
| customer           | string     | null: false                    |
| card               | string     | null: false                    |
| user               | references | null: false, foreign_key: true |

## Association

- belongs_to :user

## payments テーブル

| Column             | Type       | Options                        |
|------------------- | ---------- | ------------------------------ |
| family_name        | string     | null: false                    |
| first_name         | string     | null: false                    |
| family_name_kana   | string     | null: false                    |
| first_name_kana    | string     | null: false                    |
| post_code          | string     | null: false                    |
| prefecture         | string     | null: false                    |
| city               | string     | null: false                    |
| building           | string     |                                |
| phone_number       | string     | null: false                    |
| user               | references | null: false, foreign_key: true |

## Association

- belongs_to :user


## items テーブル

| Column             | Type       | Options                        |
|------------------- | ---------- | ------------------------------ |
| name               | string     | null: false                    |
| introduction       | text       | null: false                    |
| price              | string     | null: false                    |
| user               | references | null: false, foreign_key: true |
| category           | string     | null: false                    |
| condition          | string     | null: false                    |
| sender_area        | string     | null: false                    |
| postage_type       | string     | null: false                    |
| shipping_day       | string     | null: false                    |

## Association

- belongs_to             :user
- has_many               :images
- belongs_to_active_hash :category
- belongs_to_active_hash :condition
- belongs_to_active_hash :sender_area
- belongs_to_active_hash :postage_type
- belongs_to_active_hash :shipping_day

## images テーブル

| Column             | Type       | Options                        |
|------------------- | ---------- | ------------------------------ |
| image              | string     | null: false                    |
| item               | references | null: false, foreign_key: true |

## Association

- belongs_to :item