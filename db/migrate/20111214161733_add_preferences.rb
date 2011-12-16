class AddPreferences < ActiveRecord::Migration
  def self.up

    create_table "preferences", :force => true do |t|
      t.string   "name",       :limit => 100, :null => false
      t.integer  "owner_id",                  :null => false
      t.string   "owner_type", :limit => 50,  :null => false
      t.integer  "group_id"
      t.string   "group_type", :limit => 50
      t.text     "value"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "preferences", ["owner_id", "owner_type", "name", "group_id", "group_type"], :name => "ix_prefs_on_owner_attr_pref", :unique => true
    
  end

  def self.down
    remove_table "preferences"
  end
end