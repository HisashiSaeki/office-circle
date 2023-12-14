# frozen_string_literal: true

require "rails_helper"

RSpec.describe "[STEP1]管理者ログイン前のテスト" do
  let!(:admin) { create(:admin) }
  describe "ログイン画面のテスト" do
    before do
      visit new_admin_session_path
    end

    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq "/admin/sign_in"
      end
      it "emailフォームが表示される" do
        expect(page).to have_field "admin_email"
      end
      it "passwordフォームが表示される" do
        expect(page).to have_field "admin_password"
      end
      it "ログインボタンが表示される" do
        expect(page).to have_button "ログイン"
      end
    end

    context "ログイン成功のテスト" do
      before do
        fill_in "admin_email", with: admin.email
        fill_in "admin_password", with: admin.password
        click_on "ログイン"
      end
      it "ログイン後のリダイレクト先が管理者側の社員一覧画面になっている" do
        expect(current_path).to eq admin_employees_path
      end
      it "ログイン時にフラッシュメッセージが表示される" do
        expect(page).to have_content "ログインしました。"
      end
    end

    context "ログイン失敗のテスト" do
      before do
        fill_in "admin_email", with: ""
        fill_in "admin_password", with: ""
        click_on "ログイン"
      end
      it "ログインに失敗し、ログイン画面にリダイレクトされる" do
        expect(current_path).to eq new_admin_session_path
      end
      it "ログインに失敗し、エラーメッセージが表示される" do
        expect(page).to have_content "Emailまたはパスワードが違います。"
      end
    end
  end

  describe "ヘッダーのテスト: ログイン時" do
    before do
      visit new_admin_session_path
      fill_in "admin_email", with: admin.email
      fill_in "admin_password", with: admin.password
      click_on "ログイン"
    end

    context "ヘッダーの表示を確認" do
      it "OfficeCircleリンクが表示される" do
        expect(page).to have_link "OfficeCircle"
      end
      it "社員一覧リンクが表示される" do
        expect(page).to have_link "社員一覧"
      end
      it "投稿一覧リンクが表示される" do
        expect(page).to have_link "投稿一覧"
      end
      it "部署一覧リンクが表示される" do
        expect(page).to have_link "部署一覧"
      end
      it "ログアウトリンクが表示される" do
        expect(page).to have_link "ログアウト"
      end
    end
  end

  describe "ログアウト機能のテスト" do
    before do
      visit new_admin_session_path
      fill_in "admin_email", with: admin.email
      fill_in "admin_password", with: admin.password
      click_on "ログイン"
      click_on "ログアウト"
    end
    it "正しくログアウトできている: ログアウト後のリダイレクト先がトップ画面になっている" do
      expect(current_path).to eq "/"
    end
  end
end
