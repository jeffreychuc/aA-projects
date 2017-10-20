# == Schema Information
#
# Table name: shortened_urls
#
#  id         :integer          not null, primary key
#  long_url   :string           not null
#  short_url  :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShortenedUrl < ApplicationRecord
  belongs_to :users,
    class_name: :User,
    primary_key: :id,
    foreign_key: :user_id

  has_many :visits,
    class_name: :Visit,
    primary_key: :id,
    foreign_key: :short_url_id

  has_many :visitors,
    through: :visits,
    source: :users

  def self.random_code
    url = SecureRandom.urlsafe_base64
    return url unless ShortenedUrl.exists?(short_url: url)
    self.random_code
  end

  def self.make_short_url(user, long_url)
    ShortenedUrl.create!(long_url: long_url, user_id: user, short_url: ShortenedUrl.random_code)
  end

  def submitter
    user_id
  end

  def num_clicks
    #  count the number of clicks on a ShortenedUrl
    Visit.select(:short_url_id).count
  end

  def num_uniques
    Visit.select(:short_url_id).distinct.count
  end

  def num_recent_uniques
    Visit.select(:short_url_id).where("created_at < ?", 10.minutes.ago).distinct.count
  end
end
