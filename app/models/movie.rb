class Movie < ActiveRecord::Base
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.jpeg"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates_attachment :avatar,
  :content_type => { :content_type => "image/jpeg" },
  :size => { :in => 0..5.megabytes }

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
