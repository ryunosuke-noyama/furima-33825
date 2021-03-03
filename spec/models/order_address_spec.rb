require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '商品購入機能' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
      sleep(0.3)
    end
    context '成功時' do
      it '配送先の情報として、郵便番号・都道府県・市区町村・番地・電話番号があれば購入できること' do
        expect(@order_address).to be_valid
      end
    end
    context 'エラー発生時' do
      it '配送先の情報として、郵便番号・都道府県・市区町村・番地・電話番号が必須であること' do
        expect(@order_address).to be_valid
      end
      it '郵便番号の保存にはハイフンが必要であること（123-4567となる）' do
        @order_address.postal_code = 1234567
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it '電話番号は11桁以内の数値のみ保存可能なこと（09012345678となる）' do
        @order_address.phone_number = 123456789012
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is invalid.")
      end
    end
  end
end
