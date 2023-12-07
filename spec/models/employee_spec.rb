# frozen_string_literal: true

require "rails_helper"

RSpec.describe Employee, type: :model do
  describe "バリデーションテスト" do
    context "正しい内容を保存する場合" do
      it "保存される" do
        
      end
    end
    
    context "各カラムの値が空である場合" do
      it "保存されない" do
        
      end
    end
    
    context "furiganaカラムの値がカナ文字でない場合" do
      it "保存されない" do
        
      end
    end
  end
end
