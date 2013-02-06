# This migration comes from gko_documents (originally 20110326444445)
class GkoDocumentsGlobalize < ActiveRecord::Migration
  def up
    unless table_exists?(:document_translations)
      Document.create_translation_table!({
                                             :title => :string,
                                             :alt => :text
                                         }, {:migrate_data => true})
    end
  end


  def down
    Document.drop_translation_table! :migrate_data => true
  end
end
