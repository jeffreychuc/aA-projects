# == Schema Information
#
# Table name: visits
#
#  id           :integer          not null, primary key
#  short_url_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer          not null
#

class Visit < ApplicationRecord
  belongs_to :users,
    class_name: :User,
    primary_key: :id,
    foreign_key: :user_id

  belongs_to :shortened_urls,
    class_name: :ShortenedUrl,
    primary_key: :id,
    foreign_key: :short_url_id

    def self.record_visit!(user_id, shortened_url)
      Visit.create!(user_id: user_id, short_url_id: shortened_url)
    end
end
