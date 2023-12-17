# frozen_string_literal: true

require "rails_helper"

RSpec.describe "[STEP1]社員ログイン前のテスト" do
  let!(:employee) {create(:employee)}
  let!(:department) {create(:department)}
  describe "トップ画面のテスト" do
    before do
      visit "/"
    end
    context "表示内容の確認" do
      it "ゲストログインボタンが存在する" do
        expect(page).to have_link "ゲストログイン", href: "/employees/guest_sign_in"
      end
      it "ログインボタンが存在する" do
        expect(page).to have_link "ログイン", href: new_employee_session_path
      end
      it "新規登録ボタンが存在する" do
        expect(page).to have_link "新規登録", href: new_employee_registration_path
      end
    end
  end
  describe "ログイン画面のテスト" do
    before do
      visit new_employee_session_path
    end

    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq "/employees/sign_in"
      end
      it "emailフォームが表示される" do
        expect(page).to have_field "employee[email]"
      end
      it "passwordフォームが表示される" do
        expect(page).to have_field "employee[password]"
      end
      it "ログインボタンが表示される" do
        expect(page).to have_button "ログイン"
      end
      it "新規登録画面へのリンクが表示される" do
        expect(page).to have_link "新規登録がまだの方はこちらから新規登録をお願いします"
      end
    end

    context "ログイン成功のテスト" do
      before do
        fill_in "employee[email]", with: employee.email
        fill_in "employee[password]", with: employee.password
        click_on "ログイン"
      end
      it "ログイン後のリダイレクト先がマイページになっている" do
        expect(current_path).to eq employee_path(employee)
      end
      it "ログイン時にフラッシュメッセージが表示される" do
        expect(page).to have_content "ログインしました。"
      end
    end

    context "ログイン失敗のテスト" do
      before do
        fill_in "employee[email]", with: ""
        fill_in "employee[password]", with: ""
        click_on "ログイン"
      end
      it "ログインに失敗し、ログイン画面にリダイレクトされる" do
        expect(current_path).to eq new_employee_session_path
      end
      it "ログインに失敗し、エラーメッセージが表示される" do
        expect(page).to have_content "メールアドレスまたはパスワードが違います。"
      end
    end
  end
  
  describe "新規登録画面のテスト" do
    before do
      visit new_employee_registration_path
    end
    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq "/employees/sign_up"
      end
      it "「氏名」が表示されている" do
        expect(page).to have_content "氏名"
      end
      it "「氏名(カナ)」が表示されている" do
        expect(page).to have_content "氏名(カナ)"
      end
      it "「生年月日」が表示されている" do
        expect(page).to have_content "生年月日"
      end
      it "「出身地」が表示されている" do
        expect(page).to have_content "出身地"
      end
      it "「部署」が表示されている" do
        expect(page).to have_content "部署"
      end
      it "部署のセレクトボックスは「部署を選択してください」が選択されている" do
        expect(page).to have_content "部署を選択してください"
      end
      it "「メールアドレス」が表示されている" do
        expect(page).to have_content "メールアドレス"
      end
      it "「パスワード」が表示されている" do
        expect(page).to have_content "パスワード"
      end
      it "「パスワード確認用」が表示されている" do
        expect(page).to have_content "パスワード確認用"
      end
      it "新規登録ボタンが表示される" do
        expect(page).to have_button "新規登録"
      end
      it "新規登録画面へのリンクが表示される" do
        expect(page).to have_link "登録済みの方はこちらからログイン"
      end
    end
    
    context "新規登録成功のテスト" do
      before do
        fill_in "employee[last_name]", with: "田中"
        fill_in "employee[first_name]", with: "太一"
        fill_in "employee[last_name_furigana]", with: "タナカ"
        fill_in "employee[first_name_furigana]", with: "タイチ"
        fill_in "employee[birthdate]", with: "2000-01-01"
        fill_in "employee[prefecture]", with: "北海道"
        select "#{department.name}"
        fill_in "employee[email]", with: "tanaka@example.com"
        fill_in "employee[password]", with: "password"
        fill_in "employee[password_confirmation]", with: "password"
        click_on "新規登録"
      end
      it "新規登録後のリダイレクト先がマイページになっている" do
        expect(current_path).to eq "/employees/2"
      end
      it "新規登録時にフラッシュメッセージが表示される" do
        expect(page).to have_content "アカウント登録が完了しました。"
      end
    end
  end

  describe "ヘッダーのテスト: ログイン時" do
    before do
      visit new_employee_session_path
      fill_in "employee[email]", with: employee.email
      fill_in "employee[password]", with: employee.password
      click_on "ログイン"
    end

    context "ヘッダーの表示を確認" do
      it "OfficeCircleリンクが表示される" do
        expect(page).to have_link "OfficeCircle"
      end
      it "通知一覧が表示される" do
        expect(page).to have_link "通知一覧", href: activities_path
      end
      it "マイページへが表示される" do
        expect(page).to have_link "マイページへ", href: employee_path(employee)
      end
      it "新規投稿が表示される" do
        expect(page).to have_link "新規投稿", href: new_article_path
      end
      it "社員一覧が表示される" do
        expect(page).to have_link "社員一覧", href: employees_path
      end
      it "投稿一覧が表示される" do
        expect(page).to have_link "投稿一覧", href: articles_path
      end
      it "グループ一覧が表示される" do
        expect(page).to have_link "グループ一覧", href: groups_path
      end
      it "ログアウトが表示される" do
        expect(page).to have_link "ログアウト" , href: destroy_employee_session_path
      end
    end
  end

  describe "ログアウト機能のテスト" do
    before do
      visit new_employee_session_path
      fill_in "employee[email]", with: employee.email
      fill_in "employee[password]", with: employee.password
      click_on "ログイン"
      click_on "ログアウト"
    end
    it "正しくログアウトできている: ログアウト後のリダイレクト先がトップ画面になっている" do
      expect(current_path).to eq "/"
    end
  end
end
