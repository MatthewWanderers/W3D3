# == Schema Information
#
# Table name: visits
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  shortened_url_id :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Visit < ApplicationRecord
  def self.visit!(user, shortened_url)
    Visit.create!(user, shortened_url)
  end

  belongs_to :user,
    class_name: :User,
    foreign_key: :user_id,
    primary_key: :id

  belongs_to :shortened_url,
    class_name: :ShortenedUrl,
    foreign_key: :shortened_url_id,
    primary_key: :id




end
