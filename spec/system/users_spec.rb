# frozen_string_literal: true

require 'rails_helper'


describe 'マイページのテスト' do
  let!(:user) { create(:user, name: 'tarou', email: 'tarou@example.com', password: 'tarou0000', password_confirmation: 'tarou0000') }

  before do
    login_as(user) 
    visit user_path(user)
  end
  
  it '現在のパスが正しく表示されているか' do
    expect(current_path).to eq(user_path(user))
  end
  
  
  it 'ユーザー情報が正しく表示されているか' do
    expect(page).to have_content(user.name)
    expect(page).to have_content('なし') 
    expect(page).to have_content('-')
  end
  
  it 'リンクが正しく機能しているか' do
    click_link 'マイページを編集'
    expect(current_path).to eq(edit_user_path(user))
    
    visit user_path(user)
    
    click_link '新規投稿'
    expect(current_path).to eq(new_post_path)
    
    visit user_path(user)
    
    click_link '投稿履歴一覧はこちら'
    expect(current_path).to eq(post_list_path(user))
  end
end  
  # ここからユーザー編集
 RSpec.describe 'ユーザー編集ページ', type: :system do
  let!(:user) { create(:user, name: 'tarou', email: 'tarou@example.com', password: 'tarou0000', password_confirmation: 'tarou0000') }
  
  before do
    login_as(user)
    visit edit_user_path(user)
  end

  it 'ページが正しく表示される' do
    expect(page).to have_content('ユーザー内容編集')
    expect(page).to have_selector("input[name='user[name]']")
    expect(page).to have_selector("select[name='user[like_genre]']")
    expect(page).to have_selector("input[name='user[introduction]']")
    expect(page).to have_selector("input[type='file'][name='user[profile_image]']")
    expect(page).to have_button('変更を保存')
  end
  
  it 'エラーメッセージが正しく表示される' do
    fill_in 'ユーザーネーム', with: ''
    click_button '変更を保存'
    expect(page).to have_content('ユーザーネームを入力してください')
  end

  it 'フォームを送信後、ユーザー情報が更新される' do
    fill_in 'ユーザーネーム', with: '新しい名前'
    fill_in '自己紹介(一言)', with: '新しい自己紹介文'
    click_button '変更を保存'
    expect(user.reload.name).to eq('新しい名前')
    expect(user.reload.introduction).to eq('新しい自己紹介文')
    expect(current_path).to eq(user_path(user))
  end

  it '退会リンクが正しく機能する' do
    click_link '退会する'
    expect(current_path).to eq(confirm_path(user))
    
  end
end  
# ここから退会
RSpec.describe 'ユーザー退会処理', type: :system do
  let!(:user) { create(:user, name: 'tarou', email: 'tarou@example.com', password: 'tarou0000', password_confirmation: 'tarou0000') }

  before do
    login_as(user)
    visit confirm_path(user) 
  end

  it '退会確認ページが正しく表示される' do
    expect(page).to have_content('本当に退会してもよろしいですか？')
    expect(page).to have_link('退会しない')
    expect(page).to have_content('退会する')
  end

  it '退会しないリンクがユーザーページへ戻る' do
    click_link '退会しない'
    expect(current_path).to eq(user_path(user))
  end

  it '退会処理が正しく機能する' do
    expect {
      find("#confirm-open").click
      find("#confirm-action").click
      find("#delete").click
      expect(page).to have_current_path(root_path) 
    }.to change { user.reload.is_active }.from(true).to(false)  
  end
end
