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
class Task < ApplicationRecord
  validates :title, presence: true
  validates :title, length: { maximum: 20 }
end
