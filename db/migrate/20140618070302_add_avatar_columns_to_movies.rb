class AddAvatarColumnsToMovies < ActiveRecord::Migration
  def self.up
    add_attachment :movies, :avatar
  end

  def self.down
    remove_attachement :users, :avatar
  end
end
