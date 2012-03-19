class AddLiquidModelTable < ActiveRecord::Migration
  def change
    create_table :liquid_models, :force => true do |t|
      t.references :site
      t.text :body
      t.string :path
      t.string :format
      t.string :locale
      t.string :handler
      t.boolean :partial, :default => false
      t.timestamps
    end
  end
end