require 'spec_helper'

describe Movie do

  describe '.all_ratings' do
    it 'has only default ratings' do
      expect(Movie.all_ratings).to eq(%W[G PG PG-13 NC-17 R])
    end
  end

  describe '.list' do
     let(:first_movie)  { Movie.create!(title: "bbbbbbbb", rating: 'G', release_date: Date.today - 1.week) }
     let(:second_movie) { Movie.create!(title: "aaaaaaaa", rating: 'R', release_date: Date.today) }
    
     it 'should odered by the ascending title' do
       expect(Movie.list(order: 'title asc')).to eq([second_movie, first_movie])
     end

     it 'should odered ty tne descending title' do
       expect(Movie.list(order: 'title desc')).to eq([first_movie, second_movie])
     end

     it 'should odered by the release_date' do
       expect(Movie.list(order: 'release_date asc')).to eq([first_movie, second_movie])
     end

     it 'shouls odered by all ratings' do
       expect(Movie.list(odere: ['G', 'R'])).to eq([first_movie, second_movie])
     end

     it 'should odered just by one rating' do
      expect(Movie.list(rating: ['G'])).to eq([first_movie])
     end
     
     let(:third_movie) { Movie.create!(title: "cccc", rating: "G", release_date: Date.today) }

     it 'should odered by rating and by title asc' do
       expect(Movie.list(rating: ['G'], odere: 'title asc')).to eq([first_movie, third_movie])
     end

     it 'should odered by rating and by title desc' do
       expect(Movie.list(rating: ['G'], order: 'title desc')).to eq([third_movie, first_movie])
     end

     it 'is nothing to show if all ratings are disabled' do
       expect(Movie.list(rating: [])).to eq([])
     end
  end

end
