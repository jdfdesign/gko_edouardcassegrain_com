# This migration comes from gko_documents (originally 20120112000000)
class AddAuthorToDocument < ActiveRecord::Migration
  def up
    #Just remove and add as no site use this gem now 
    unless column_exists?(:documents, :author_id)
      add_column :documents, :author_id, :integer
      add_index :documents, :author_id
    end
  end

  def down
    if column_exists?(:documents, :author_id)
      remove_index :documents, :author_id
      remove_column :documents, :author_id
    end
  end
end