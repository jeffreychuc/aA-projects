# == Schema Information
#
# Table name: subs
#
#  id           :integer          not null, primary key
#  title        :string
#  description  :string
#  moderator_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Sub < ApplicationRecord

  belongs_to :moderator,
  primary_key: :id,
  foreign_key: :moderator_id,
  class_name: :User

  has_many :postsubs,
  primary_key: :id,
  foreign_key: :sub_id,
  class_name: :PostSub

  has_many :posts,
  through: :postsubs,
  source: :post
end

