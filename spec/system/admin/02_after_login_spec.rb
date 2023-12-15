# frozen_string_literal: true

require "rails_helper"

RSpec.describe "[STEP2]管理者ログイン後のテスト" do
  let!(:admin) { create(:admin) }
  let!(:department) { create(:department) }
  before do
    visit new_admin_session_path
    fill_in "admin_email", with: admin.email
    fill_in "admin_password", with: admin.password
    click_on "ログイン"
  end

  describe "ヘッダーのテスト:ログインしている場合" do
    context "リンクの内容を確認: ※logoutは『ログアウト機能のテスト』でテスト済みになります。" do
      it "社員一覧を押すと社員一覧画面に移動する" do
        click_on "社員一覧"
        expect(current_path).to eq "/admin/employees"
      end
      it "投稿一覧を押すと投稿一覧画面に移動する" do
        click_on "投稿一覧"
        expect(current_path).to eq "/admin/articles"
      end
      it "部署一覧を押すと部署一覧新規作成画面に移動する" do
        click_on "部署一覧"
        expect(current_path).to eq "/admin/departments"
      end
    end
  end

  describe "部署一覧/新規作成画面のテスト" do
    before do
      visit admin_departments_path
    end
    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq "/admin/departments"
      end
      it "部署名入力フォームが存在する" do
        expect(page).to have_field "department[name]"
      end
      it "部署登録ボタンが存在する" do
        expect(page).to have_button "登録"
      end
      it "部署一覧というテキストが存在する" do
        expect(page).to have_content "部署一覧"
      end
      it "既存の部署名が存在する" do
        expect(page).to have_content "#{department.name}"
      end
      it "既存の部署の編集ボタンが存在する" do
        expect(page).to have_link "編集", href: edit_admin_department_path(department)
      end
    end

    context "部署の新規登録テスト(成功するケースのみ)" do
      before do
        fill_in "department[name]", with: "開発部"
      end
      it "新しい部署が正しく保存される" do
        expect { click_on "登録"}.to change { Department.count }.by(1)
      end
      it "保存は非同期で行われるため、リロードせず部署一覧に追加される" do
        click_on "登録"
        expect(page).to have_content "開発部"
      end
    end

    context "編集リンクのテスト" do
      it "作成した部署の編集画面に遷移する" do
        click_on "編集"
        expect(current_path).to eq edit_admin_department_path(department)
      end
    end
  end

  describe "部署編集画面のテスト" do
    before do
      visit edit_admin_department_path(department)
    end

    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq edit_admin_department_path(department)
      end
      it "部署名の入力フォームが存在し、編集前の部署名が表示されている" do
        expect(page).to have_field "department[name]", with: department.name
      end
      it "登録ボタンが存在する" do
        expect(page).to have_button "登録"
      end
    end

    context "部署名の編集テスト(成功するケースのみ)" do
      before do
        @old_department = department.name
        fill_in "department[name]", with: Faker::Lorem.characters(number: 5)
        click_on "登録"
      end
      it "部署名が更新される" do
        expect(department.reload.name).not_to eq @old_department
      end
      it "リダイレクト先が部署一覧/新規作成画面になっている" do
        expect(current_path).to eq admin_departments_path
      end
    end
  end

  describe "投稿一覧画面のテスト" do
    let!(:employee) { create(:employee) }
    let!(:article) { create(:article, employee_id: employee.id) }
    let!(:comment) { Comment.create(employee_id: employee.id, article_id: article.id, comment: "テスト")}
    before do
      list_tags = ["公開中"]
      article.save_tags(list_tags)
      visit admin_articles_path
    end
    
    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq "/admin/articles"
      end
      it "検索フォームが存在する" do
        expect(page).to have_field "keyword"
      end
      it "検索ボタンが存在する" do
        expect(page).to have_button "検索"
      end
      it "タグ検索の見出しが存在する" do
        expect(page).to have_content "タグ検索"
      end
      it "公開中の記事に紐づくタグがタグ検索欄に表示されている" do
        within ".search-group" do
          expect(page).to have_content "公開中"
        end
      end
      it "投稿した記事が存在する" do
        expect(page).to have_content "#{article.title}"
      end
      it "投稿した記事の作成日が表示される" do
        expect(page).to have_content "#{ Time.zone.today.strftime("%Y年%m月%d日")}"
      end
      it "投稿した記事の作者が表示される" do
        expect(page).to have_content "#{article.employee.full_name}"
      end
      it "投稿した記事のタイトルが表示される" do
        expect(page).to have_selector "h2", text: "#{article.title}"
      end
      it "投稿した記事に紐づくタグが表示される" do
        within ".article-record" do
          expect(page).to have_content "公開中"
        end
      end
      it "投稿した記事のコメントアイコンが表示される" do
        expect(page).to have_selector "i.fa-regular.fa-comments"
      end
      it "投稿した記事のコメント数が表示される" do
        expect(page).to have_selector ".horizontal-icon-list__item", text: "#{article.comments.size}"
      end
    end

  end
end