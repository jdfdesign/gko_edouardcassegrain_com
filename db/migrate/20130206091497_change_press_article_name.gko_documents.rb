# This migration comes from gko_documents (originally 20120120000000)
class ChangePressArticleName < ActiveRecord::Migration
  def up
    rename_table :press_articles, :document_items unless table_exists?(:document_items)
    sections = select_all "SELECT * FROM sections"
    sections.each do |section|
      if section['type'] == 'PressArticleList'
        execute "UPDATE sections SET type = 'DocumentList' WHERE id = #{section['id']}"
      end
    end
  end

  def down
    rename_table :document_items, :press_articles unless table_exists?(:press_articles)
  end
end