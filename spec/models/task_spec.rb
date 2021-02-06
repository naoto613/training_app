# frozen_string_literal: true

# == Schema Information
#
# Table name: tasks
#
#  id         :bigint           not null, primary key
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Task, type: :model do
  before do
    @task = build(:task)
  end

  describe 'バリデーション' do
    it 'titleに値が設定されていれば、OK' do
      expect(@task.valid?).to eq(true)
    end

    it 'titleが空だとNG' do
      @task.title = ''
      expect(@task.valid?).to eq(false)
    end
  end
end
