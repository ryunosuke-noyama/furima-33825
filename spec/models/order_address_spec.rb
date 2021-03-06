require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '商品購入機能' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
      sleep(0.5)
    end
    context '成功時' do
      it '配送先の情報として、郵便番号・都道府県・市区町村・番地・電話番号があれば購入できること' do
        expect(@order_address).to be_valid
      end
      it '建物名がなくても登録できること' do
        @order_address.building = nil
        expect(@order_address).to be_valid
      end
    end
    context 'エラー発生時' do
      it '配送先の情報として、郵便番号・都道府県・市区町村・番地・電話番号が必須であること' do
        expect(@order_address).to be_valid
      end
      it '郵便番号の保存にはハイフンが必要であること（123-4567となる）' do
        @order_address.postal_code = 1_234_567
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it '郵便番号がないと登録できないこと' do
        @order_address.postal_code = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code can't be blank",
                                                               'Postal code is invalid. Include hyphen(-)')
      end
      it '都道府県がないと登録できないこと' do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Prefecture must be other than 1')
      end
      it '市区町村がないと登録できないこと' do
        @order_address.city = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank",
                                                               'City is invalid. Input full-width characters.')
      end
      it '番地がないと登録できないこと' do
        @order_address.address = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Address can't be blank")
      end
      it '電話番号がないと登録できないこと' do
        @order_address.phone_number = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank", 'Phone number is invalid.')
      end
      it '電話番号は11桁以内の数値のみ保存可能なこと（09012345678となる）' do
        @order_address.phone_number = 123_456_789_012
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is invalid.')
      end
      it '電話番号は数字でなければ登録できないこと（09012345678となる）' do
        @order_address.phone_number = 'abcdefg'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is invalid.')
      end
      it 'user_idがないと登録できないこと' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idがないと登録できないこと' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
      it 'tokenが空では登録できないこと' do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
