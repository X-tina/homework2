require 'spec_helper'

describe Movie do

  describe '.all_ratings' do
    it 'No movies - no ratings' do
      expect(Movie.all_ratings.clear).to eq([])
    end
   
    it 'No duplicates' do
      Movie.create(title: 'aaa', rating: 'PG', release_date: Date.today)
      Movie.create(title: 'aaa', rating: 'PG', release_date: Date.today)  
      expect(Movie.all.where('rating' == 'PG').count).to eq(1)
    end

    it ' has no blank ratings' do
      Movie.create(title: 'aaa', rating: ' ', release_date: Date.today)
      expect(Movie.where('title' == 'aaa')).to raise_error()
    end

    it 'has only default ratings' do
      expect(Movie.all_ratings).to eq(%W[G PG PG-13 NC-17 R])
    end
  end  

end
