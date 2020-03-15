# == Schema Information
#
# Table name: calendars
#
#  id         :bigint           not null, primary key
#  g_id       :string           not null
#  summary    :string
#  timezone   :string
#  bg_color   :string
#  fg_color   :string
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Calendar < ApplicationRecord
  belongs_to :user
  has_many :events, dependent: :destroy
end