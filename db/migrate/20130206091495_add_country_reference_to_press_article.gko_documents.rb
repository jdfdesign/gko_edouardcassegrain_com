# This migration comes from gko_documents (originally 20110803000001)
class AddCountryReferenceToPressArticle < ActiveRecord::Migration
  def up
    #Just remove and add as no site use this gem now
    unless column_exists?(:press_articles, :country_id)
      add_column :press_articles, :country_id, :integer
      remove_column :press_articles, :country
      add_index :press_articles, :country_id
    end
  end

  def down
    remove_index :press_articles, :country_id
    remove_column :press_articles, :country_id
    add_column :press_articles, :country, :string
  end
end