class Movie < ActiveRecord::Base
  validates :title, presence: true
  validates :rating, presence: true

  def self.all_ratings
    Movie.select(:rating).distinct.pluck(:rating)
  end
end
