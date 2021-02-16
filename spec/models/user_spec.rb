require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    it 'ニックネームが必須であること' do
      @user.nickname = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end
    it 'メールアドレスが必須であること' do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it 'メールアドレスが一意性であること' do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end
    it 'メールアドレスは、@を含む必要があること' do
      @user.email = 'sample.sample.com'
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end
    it 'パスワードが必須であること' do
      @user.password = ''
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it 'パスワードは、6文字以上での入力が必須であること（6文字が入力されていれば、登録が可能なこと）' do
      @user.password = '12345'
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end
    it 'パスワードとパスワード（確認用）は、値の一致が必須であること' do
      @user.password = '123abc'
      @user.password_confirmation = '456def'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'パスワードは、数字のみでは登録できない' do
      @user.password = '123456'
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid", "Password confirmation is invalid")
    end
    it 'パスワードは、英字のみでは登録できない' do
      @user.password = 'abcdef'
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid", "Password confirmation is invalid")
    end
    it 'パスワードは、全角では登録できない' do
      @user.password = '１２３ａｂｃ'
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid", "Password confirmation is invalid")
    end
    it 'ユーザー本名は、名字が必須であること' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank", 'First name is invalid')
    end
    it 'ユーザー本名は、名字が全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
      @user.first_name = 'aaa'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name is invalid')
    end
    it 'ユーザー本名は、名前が必須であること' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank", 'Last name is invalid')
    end
    it 'ユーザー本名は、名前が全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
      @user.last_name = 'bbb'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name is invalid')
    end
    it 'ユーザー本名のフリガナは、名字が必須であること' do
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank", "First name kana is invalid")
    end
    it 'ユーザー本名のフリガナは、名字が全角（カタカナ）での入力が必須であること' do
      @user.first_name_kana = 'ああ'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name kana is invalid')
    end
    it 'ユーザー本名のフリガナは、名前が必須であること' do
      @user.last_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank", 'Last name kana is invalid')
    end
    it 'ユーザー本名のフリガナは、名前が全角（カタカナ）での入力が必須であること' do
      @user.last_name_kana = 'ああ'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name kana is invalid')
    end
    it '生年月日が必須であること' do
      @user.birthday = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end
  end

end
