# README

# テーブル設計

## users テーブル

| Column           | Type   | Options     |
| ---------------- | ------ | ----------- |
| nickname         | string | null: false |
| email            | string | null: false |
| password         | string | null: false |
| family_name      | string | null: false |
| first_name       | string | null: false |
| family_name_kana | string | null: false |
| first_name_kana  | string | null: false |

### Association

- has_many :items
- has_many :address
- has_one :order


<br>


## items テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| name             | string     | null: false                    |
| image            | string     | null: false                    |
| price            | integer    | null: false                    | 
| introduction     | text       | null: false                    |
| category         | integer    | null: false                    |
| status           | integer    | null: false                    |
| postage          | integer    | null: false                    |
| prefecture       | integer    | null: false                    |
| shipping_day     | integer    | null: false                    |
| user_id          | references | null: false, foreign_key: true |

### Association

- has_one :order
- belongs_to :user


<br>


## orders テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| user_id     | references | null: false, foreign_key: true |
| item_id     | references | null: false, foreign_key: true |
| address_id  | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- belongs_to :address


<br>


## addresses テーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| postal_code     | string     | null: false                    |
| prefecture      | string     | null: false                    |
| city            | string     | null: false                    |
| address         | string     | null: false                    |
| building        | string     |                                |
| phone_number    | string     | null: false                    |
| user_id         | references | null: false, foreign_key: true |

### Association

- has_one :order
- belongs_to :user
