class Movie < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :rating, presence: true, format: { with: /\AG|PG|PG-13|NC-17|R\z/ }, length: { minimum: 1 }

  def self.all_ratings
    @all_ratings = %W[G PG PG-13 NC-17 R]
  end

  scope :list, ->(options) {
    res = all
    res = res.where(rating: options[:rating]) if options.key? :rating
    res = res.order(options[:order]) if options.key? :order
    res
  }
end
