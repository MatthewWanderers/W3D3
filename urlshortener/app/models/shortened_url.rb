require 'securerandom'
# == Schema Information
#
# Table name: shortened_urls
#
#  id        :integer          not null, primary key
#  short_url :string
#  long_url  :string
#  user_id   :integer
#

class ShortenedUrl < ApplicationRecord
  validates :long_url, uniqueness: true, presence: true
  validates :short_url, uniqueness: true, presence: true

  def self.random_code
    short = SecureRandom::urlsafe_base64
      unless ShortenedUrl.where(:short_url => short).exists?
        short = SecureRandom::urlsafe_base64
      end
    short
  end

  def self.create!(user, url)
    ShortenedUrl.new(short_url: self.random_code,
       long_url: url, user_id: user.id).save!
  end

  belongs_to :user,
    class_name: :User,
    foreign_key: :user_id,
    primary_key: :id


  has_many :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :visitor



  def num_clicks
    total_visits = Visit.all.select { |visit| visit.shortened_url_id }
    total_visits.count

  end

  def num_uniques
    num_clicks.distinct.count
  end

  def num_recent_uniques

  end
end
