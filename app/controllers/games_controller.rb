class GamesController < ContentsController
  respond_to :html
  belongs_to :game_list
  before_filter :set_id, :only => :show

  protected
    def set_id
      section = site.game_lists.find(params[:game_list_id])
      permalink = params[:permalink].split('/')
      params[:id] = section.games.by_permalink(*permalink).first.try(:id)
    end

    def filter_collection(collection)
      if params[:category_id].present?
        @category = Category.find(params[:category_id])
        category_ids = category.self_and_descendants.map(&:id)
        collection = collection.published.categorized(category_ids)
      end

      if params[:sticker_id].present?
        @sticker = Sticker.find(params[:sticker_id])
        collection = collection.published.sticked(@sticker.name)
      end

      return collection
    end
end