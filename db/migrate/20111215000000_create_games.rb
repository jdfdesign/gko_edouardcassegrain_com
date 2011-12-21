class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games, :force => true do |t|
      t.references :site
      t.references :section
      t.string :title
      t.string :slug
      t.text :body
      t.text :properties
      t.datetime :published_at
      t.string :layout, :limit => 40
      t.string :meta_title
      t.text :meta_description
      t.text :meta_keywords
      t.integer :position, :default => 1
      
      t.string :preview_mime_type
      t.string :preview_name
      t.integer :preview_size
      t.integer :preview_width
      t.integer :preview_height
      t.string :preview_uid
      t.string :preview_ext
      
      t.timestamps
    end
    
    add_index :games, :site_id
    add_index :games, :section_id
    add_index :games, :slug
    add_index :games, [:position, :section_id] 
  end

  def self.down
    drop_table :games
  end
end