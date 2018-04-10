# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string           default("")
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  exercise_category_id   :integer
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_exercise_category_id  (exercise_category_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (exercise_category_id => exercise_categories.id)
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :exercise_categories, dependent: :destroy
  has_many :exercises, through: :exercise_categories
  has_many :body_parts, dependent: :destroy
  has_many :routines, dependent: :destroy
  has_many :workouts, dependent: :destroy
end
