class Item < ApplicationRecord
  # extend ActiveHash::Associations::ActiveRecordExtensions
  # belongs_to_active_hash :category, :status, :postage, :prefecture, :shipping_day

  has_one_attached :image
  belongs_to :user

  # 空の投稿を保存できないようにする
  with_options presence: true do
    validates :image
    validates :name, length: { maximum: 40 }
    validates :introduction, length: { maximum: 1000 }
    validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'is out of setting range' }

    # ジャンルの選択が「--」の時は保存できないようにする
    with_options numericality: { other_than: 1, message: 'Select' } do
      validates :category
      validates :status
      validates :postage
      validates :prefecture
      validates :shipping_day
    end
  end
end
