class Movie < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :rating, presence: true, format: { with: /\AG|PG|PG-13|NC-17|R\z/ }, length: { minimum: 1 }#, message: "Only G, PG, PG-13, NC-17, R, please"
  #validates :
end
