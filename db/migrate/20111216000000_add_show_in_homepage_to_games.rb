class AddShowInHomepageToGames < ActiveRecord::Migration
  def self.up
    add_column :games, :show_in_homepage, :boolean, :default => false
    add_column :games, :feature_title, :string 
    add_column :game_translations, :feature_title, :string
  end

  def self.down
    remove_column :games, :show_in_homepage
    remove_column :games, :feature_title
    remove_column :game_translations, :feature_title
  end
end  
