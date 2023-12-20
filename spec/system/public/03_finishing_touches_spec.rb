# frozen_string_literal: true

require "rails_helper"

RSpec.describe "[STEP3]その他のテスト" do
  let!(:employee) {create(:employee)}
  let!(:article) {create(:article, employee_id: employee.id)}
  let!(:group) {create(:group, creater_id: employee.id)}
  let!(:notice) {Notice.create(group_id: group.id, title: Faker::Lorem.characters(number: 10), body: Faker::Lorem.characters(number: 10))}
  before do
    visit new_employee_session_path
    fill_in "employee[email]", with: employee.email
    fill_in "employee[password]", with: employee.password
    click_on "ログイン"
  end
  describe "フラッシュメッセージのテスト: 新規作成/ログイン/ログアウトは実行済み" do
    it "社員の編集成功時" do
      visit edit_employee_path(employee)
      click_on "変更内容を保存"
      expect(page).to have_content "登録内容の変更が完了しました"
    end
    it "記事の投稿成功時" do
      visit new_article_path(article)
      fill_in "article[title]", with: Faker::Lorem.characters(number: 10)
      fill_in "article[body]", with: Faker::Lorem.characters(number: 10)
      click_on "投稿する"
      expect(page).to have_content "投稿完了しました"
    end
    it "記事の下書き保存成功時" do
      visit new_article_path(article)
      fill_in "article[title]", with: Faker::Lorem.characters(number: 10)
      fill_in "article[body]", with: Faker::Lorem.characters(number: 10)
      click_on "下書き保存する"
      expect(page).to have_content "投稿を下書き保存しました"
    end
    it "記事の編集成功時" do
      visit edit_article_path(article)
      click_on "投稿する"
      expect(page).to have_content "投稿内容の変更が完了しました"
    end
    it "記事の削除成功時" do
      visit article_path(article)
      click_on "投稿削除"
      expect(page).to have_content "投稿の削除が完了しました"
    end
    it "グループの新規作成時" do
      visit new_group_path
      fill_in "group[name]", with: Faker::Lorem.characters(number: 10)
      fill_in "group[description]", with: Faker::Lorem.characters(number: 10)
      click_on "グループ作成"
      expect(page).to have_content "グループを作成しました"
    end
    it "グループの編集成功時" do
      visit edit_group_path(group)
      click_on "変更内容を保存"
      expect(page).to have_content "グループの変更が完了しました"
    end
    it "グループの削除成功時" do
      visit group_path(group)
      click_on "グループを削除"
      expect(page).to have_content "グループを削除しました"
    end
    it "お知らせの新規作成時" do
      visit new_group_notice_path(group)
      fill_in "notice[title]", with: Faker::Lorem.characters(number: 10)
      fill_in "notice[body]", with: Faker::Lorem.characters(number: 10)
      click_on "送信"
      expect(page).to have_content "お知らせを作成しました"
    end
    it "お知らせの削除成功時" do
      visit group_notice_path(group, notice)
      click_on "お知らせを削除"
      expect(page).to have_content "お知らせを削除しました"
    end
  end
  describe "処理失敗時のメッセージテスト(保存されないことに関しては単体テストで実証済み)" do
    context "社員の編集失敗" do
    before do
        visit edit_employee_path(employee)
        fill_in "employee[last_name]", with: ""
        fill_in "employee[last_name_furigana]", with: "たろう"
        click_on "変更内容を保存"
      end
      it "社員情報編集画面が表示されており、フォームの内容が正しい" do
        expect(page).to have_button "変更内容を保存"
        expect(page).to have_field "employee[last_name]", with: ""
        expect(page).to have_field "employee[last_name_furigana]", with: "たろう"
      end
      it "エラーメッセージが表示される(空の場合のメッセージを検証)" do
        expect(page).to have_content "苗字を入力してください"
      end
      it "エラーメッセージが表示される(カナ表記でない場合のメッセージを検証)" do
        expect(page).to have_content "苗字のフリガナは全角カタカナで入力してください"
      end
    end # context "社員の編集失敗"
    
    context "記事の投稿失敗" do
      before do
        visit new_article_path
        fill_in "article[title]", with: "長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿"
        fill_in "article[body]", with: ""
        click_on "投稿する"
      end
      it "新規投稿作成画面が表示されており、フォームの内容が正しい" do
        expect(page).to have_button "投稿する"
        expect(page).to have_field "article[title]", with: "長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿"
        expect(page).to have_field "article[body]", with: ""
      end
      it "エラーメッセージが表示される(文字数超過の場合のメッセージを検証)" do
        expect(page).to have_content "タイトルは100文字以内で入力してください"
      end
      it "エラーメッセージが表示される(空の場合)" do
        expect(page).to have_content "本文を入力してください"
      end
    end # context "記事の投稿失敗"
    
    context "記事の編集失敗" do
      before do
        visit edit_article_path(article)
        fill_in "article[title]", with: "長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿"
        fill_in "article[body]", with: ""
        click_on "投稿する"
      end
      it "新規投稿作成画面が表示されており、フォームの内容が正しい" do
        expect(page).to have_button "投稿する"
        expect(page).to have_field "article[title]", with: "長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿長文の投稿"
        expect(page).to have_field "article[body]", with: ""
      end
      it "エラーメッセージが表示される(文字数超過の場合のメッセージを検証)" do
        expect(page).to have_content "タイトルは100文字以内で入力してください"
      end
      it "エラーメッセージが表示される(空の場合)" do
        expect(page).to have_content "本文を入力してください"
      end
    end # context "記事の編集失敗"
    
    context "グループの新規作成失敗" do
      before do
        visit new_group_path
        fill_in "group[name]", with: "長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ"
        fill_in "group[description]", with: ""
        click_on "グループ作成"
      end
      it "グループ新規作成画面が表示されており、フォームの内容が正しい" do
        expect(page).to have_button "グループ作成"
        expect(page).to have_field "group[name]", with: "長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ"
        expect(page).to have_field "group[description]", with: ""
      end
      it "エラーメッセージが表示される(文字数超過の場合のメッセージを検証)" do
        expect(page).to have_content "グループ名は100文字以内で入力してください"
      end
      it "エラーメッセージが表示される(空の場合)" do
        expect(page).to have_content "活動内容を入力してください"
      end
    end # context "グループの新規作成失敗"
    
    context "グループの編集失敗" do
      before do
        visit edit_group_path(group)
        fill_in "group[name]", with: "長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ"
        fill_in "group[description]", with: ""
        click_on "変更内容を保存"
      end
      it "グループ新規作成画面が表示されており、フォームの内容が正しい" do
        expect(page).to have_button "変更内容を保存"
        expect(page).to have_field "group[name]", with: "長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ"
        expect(page).to have_field "group[description]", with: ""
      end
      it "エラーメッセージが表示される(文字数超過の場合のメッセージを検証)" do
        expect(page).to have_content "グループ名は100文字以内で入力してください"
      end
      it "エラーメッセージが表示される(空の場合)" do
        expect(page).to have_content "活動内容を入力してください"
      end
    end # context "グループの編集失敗"
    
    context "お知らせの新規作成失敗" do
      before do
        visit new_group_notice_path(group)
        fill_in "notice[title]", with: "長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ"
        fill_in "notice[body]", with: ""
        click_on "送信"
      end
      it "お知らせ新規作成画面が表示されており、フォームの内容が正しい" do
        expect(page).to have_button "送信"
        expect(page).to have_field "notice[title]", with: "長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ長文はだめ"
        expect(page).to have_field "notice[body]", with: ""
      end
      it "エラーメッセージが表示される(文字数超過の場合のメッセージを検証)" do
        expect(page).to have_content "タイトルは100文字以内で入力してください"
      end
      it "エラーメッセージが表示される(空の場合)" do
        expect(page).to have_content "本文を入力してください"
      end
    end # context "グループの新規作成失敗"
  end # describe "処理失敗時のメッセージテスト(保存されないことに関しては単体テストで実証済み)"
end # RSpec.describe "[STEP3]その他のテスト"
