require 'rails_helper'

describe Item do
  before do
    @item = FactoryBot.build(:item)
    @item.image = fixture_file_upload('public/images/test_image.JPG')
  end

  describe '商品出品登録' do
    context '商品出品登録がうまくいくとき' do
      it 'name、image、price、introduction、category、status、postage、prefecture、shipping_dayが存在すれば登録できる' do
        expect(@item).to be_valid
      end
      it 'priceが300円以上で登録できる' do
        @item.price = 300
        expect(@item).to be_valid
      end
      it 'priceが9999999円まで登録できる' do
        @item.price = 9_999_999
        expect(@item).to be_valid
      end
    end

    context '商品出品登録がうまくいかないとき' do
      it 'imageが空では登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it 'nameが空では登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it 'priceが空では登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it 'priceが300円未満では登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is out of setting range')
      end
      it 'priceが9999999円を超えたら登録できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is out of setting range')
      end
      it 'introductionが空では登録できない' do
        @item.introduction = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Introduction can't be blank")
      end
      it 'categoryが選択されていなければ登録できない' do
        @item.category = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Category Select')
      end
      it 'statusが選択されていなければ登録できない' do
        @item.status = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Status Select')
      end
      it 'postageが選択されていなければ登録できない' do
        @item.postage = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Postage Select')
      end
      it 'prefectreが選択されていなければ登録できない' do
        @item.prefecture = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture Select')
      end
      it 'shipping_dayが選択されていなければ登録できない' do
        @item.shipping_day = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping day Select')
      end
    end
  end
end
