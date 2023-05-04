# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
|------------------- | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| family_name        | string | null: false               |
| first_name         | string | null: false               |
| family_name_kana   | string | null: false               |
| first_name_kana    | string | null: false               |
| birthday           | date   | null: false               |

## Association

- has_many :items
- has_many :purchases

## items テーブル

| Column             | Type       | Options                        |
|------------------- | ---------- | ------------------------------ |
| name               | string     | null: false                    |
| introduction       | text       | null: false                    |
| price              | integer    | null: false                    |
| user_id            | references | null: false, foreign_key: true |
| category_id        | integer    | null: false                    |
| condition_id       | integer    | null: false                    |
| prefecture_id      | integer    | null: false                    |
| postage_type_id    | integer    | null: false                    |
| shipping_day_id    | integer    | null: false                    |

## Association

- belongs_to             :user
- has_one                :purchase
- belongs_to_active_hash :category
- belongs_to_active_hash :condition
- belongs_to_active_hash :prefecture
- belongs_to_active_hash :postage_type
- belongs_to_active_hash :shipping_day

## purchases テーブル

| Column             | Type       | Options                        |
|------------------- | ------     | ------------------------------ |
| user_id            | references | null: false, foreign_key: true |
| item_id            | references | null: false, foreign_key: true |

## Association

- belongs_to :user
- belongs_to :item
- has_one    :payment

## payments テーブル

| Column             | Type       | Options                        |
|------------------- | ---------- | ------------------------------ |
| post_code          | string     | null: false                    |
| prefecture_id      | integer    | null: false                    |
| city               | string     | null: false                    |
| address            | string     | null: false                    |
| building           | string     |                                |
| phone_number       | string     | null: false                    |
| purchase_id        | references | null: false, foreign_key: true |

## Association

- belongs_to             :purchase