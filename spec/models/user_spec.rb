require 'rails_helper'

describe User do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it 'nickname、email、password、password_confirmation、birthday、family_name、first_name、family_name_kana、first_name_kanaが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordが6文字以上であれば登録できる(先頭は英字で数字を含む)' do
        @user.password = 'a00000'
        @user.password_confirmation = 'a00000'
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'emailに@が無ければ登録できない' do
        @user.email = 'abc123gmail.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが5文字以下であれば登録できない' do
        @user.password = 'a0000'
        @user.password_confirmation = 'a0000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordは英数字混合でなければ登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password Include both letters and numbers')
      end
      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'ユーザー本名は、名字と名前それぞれを入力しないと登録できない' do
        @user.family_name = ''
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank", "First name can't be blank")
      end
      it 'ユーザー本名は、全角(漢字・ひらがな・カタカナ)で入力しないと登録できない' do
        @user.family_name = 'yamada'
        @user.first_name = 'hanako'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name Full-width characters', 'First name Full-width characters')
      end
      it 'ユーザー本名のフリガナは、名字と名前それぞれを入力しないと登録できない' do
        @user.family_name_kana = ''
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana can't be blank", "First name kana can't be blank")
      end
      it 'ユーザー本名のフリガナは、全角(カタカナ)で入力しないと登録できない' do
        @user.family_name_kana = 'やまだ'
        @user.first_name_kana = 'はなこ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name kana Full-width katakana characters', 'First name kana Full-width katakana characters')
      end
      it '生年月日が空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
