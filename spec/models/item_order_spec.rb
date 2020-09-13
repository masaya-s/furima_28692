require 'rails_helper'

describe ItemOrder do
  before do
    @item_order = FactoryBot.build(:item_order)
  end

  describe '商品購入' do
    context '商品購入がうまくいくとき' do
      it 'token、user_id、item_id、postal_code、prefecture、city、address、building、phone_numberが存在すれば購入できる' do
        expect(@item_order).to be_valid
      end
      it 'buildingが空でも購入できる' do
        @item_order.building = ''
        expect(@item_order).to be_valid
      end
    end

    context '商品購入がうまくいかないとき' do
      it 'tokenが空では購入できない' do
        @item_order.token = ''
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("Token can't be blank")
      end
      it 'user_idが空では購入できない' do
        @item_order.user_id = ''
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが空では購入できない' do
        @item_order.item_id = ''
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("Item can't be blank")
      end
      it 'postal_codeが空では購入できない' do
        @item_order.postal_code = ''
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeにハイフンを3文字目と4文字目の間に含めなければ購入できない' do
        @item_order.postal_code = '0000-000'
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it 'postal_codeが7ケタでなければ購入できない' do
        @item_order.postal_code = '000-00000'
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it 'postal_codeが半角でなければ購入できない' do
        @item_order.postal_code = '０００−００００'
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it 'prefectureを(初期値の1以外で)選択しなければ購入できない' do
        @item_order.prefecture = 1
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include('Prefecture Select')
      end
      it 'cityが空では購入できない' do
        @item_order.city = ''
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("City can't be blank")
      end
      it 'addressが空では購入できない' do
        @item_order.address = ''
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("Address can't be blank")
      end
      it 'phone_numberが空では購入できない' do
        @item_order.phone_number = ''
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberにハイフンを含むと購入できない' do
        @item_order.phone_number = '090-1111-2222'
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include('Phone number is invalid')
      end
      it 'phone_numberが11ケタでなければ購入できない' do
        @item_order.phone_number = '0011112222'
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include('Phone number is invalid')
      end
      it 'phone_numberが半角でなければ購入できない' do
        @item_order.phone_number = '０９０１１１１２２２２'
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include('Phone number is invalid')
      end
    end
  end
end
