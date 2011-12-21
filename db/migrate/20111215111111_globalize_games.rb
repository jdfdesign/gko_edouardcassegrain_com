class GlobalizeGames < ActiveRecord::Migration
  def self.up
    Game.create_translation_table!({
      :title => :string,
      :body => :text, 
      :properties => :text, 
      :meta_title => :string,
      :meta_description => :text,
      :meta_keywords => :text,
      :slug => :string
    }, {:migrate_data => true})

  end

  def self.down
    Game.drop_translation_table! :migrate_data => true
  end
end
