# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :string
#  sub_id     :string           not null
#  author_id  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ApplicationRecord
  belongs_to :author,
  primary_key: :id,
  foreign_key: :author_id,
  class_name: :User

  has_many :postsubs,
  primary_key: :id,
  foreign_key: :post_id,
  class_name: :PostSub


  has_many :subs,
  through: :postsubs,
  source: :sub
end
