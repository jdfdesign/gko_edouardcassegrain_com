class GamesController < BaseController
  respond_to :html
  belongs_to :game_list
  before_filter :set_id, :only => :show
  before_filter :load_section_categories, :only => [:show, :index] 
  before_filter :load_section_stickers, :only => [:show, :index]
  #add_crumb("home", :root_url)
  
  # Save whole Page after delivery
  after_filter { |c| c.write_cache? }
  #caches_page :index, :show
  
  def show
    show! do
      #add_crumb(parent.title, parent_url)
      #add_crumb(resource.title, resource_url)
      page_meta_tags(resource)
      load_resource_associations
      #render(:template => "galleries/show") and return 
    end
  end

  def index
    index! do |success, failure|
      #add_crumb(parent.title, parent_url)
      page_meta_tags(parent) 
      success.any do
        if parent.redirect_url.present?
          #TODO DEFINE FORMAT REQUEST ?
          redirect_to("/#{parent.redirect_url}") and return
        elsif parent.layout.present?
          render(:template => "pages/#{parent.layout}")
        end
      end
    end
  end
  
  protected
    def set_id
      section = site.game_lists.find(params[:game_list_id])
      permalink = params[:permalink].split('/')
      params[:id] = section.games.by_permalink(*permalink).first.try(:id)
    end

    def load_resource_associations
      #FIXME image no necessary need translation !!!!
      #@images = resource.images.with_translations(I18n.locale)
      @images = resource.images
      @categories = resource.available_categories if parent.categorizable?
      @stickers = resource.available_categories if parent.stickable?

      if parent.commentable?
        @comments = resource.comments
        @comment = resource.comments.new
        if user_signed_in?
          @comment.name = current_user.username
          @comment.email = current_user.email
        end
      end
    end

    # TODO should be in category engine  
    def load_section_categories
      @section_categories ||= parent.available_categories if parent.categorizable?
    end 

    # TODO should be in sticker engine 
    def load_section_stickers
      @section_stickers ||= parent.available_categories if parent.stickable?
    end


    def resource
      get_resource_ivar ||= begin
        if params[:id].present?
          c = end_of_association_chain.with_translations(I18n.locale).find(params[:id])
          set_resource_ivar(c)
        else
          #super
        end
      end
    end

    def collection
      get_collection_ivar || begin
        c = load_resources
        c = filter_collection(c)
        c = search_all(c) if searching?
        c = order_all(c) 
        c = paginate_all(c) if paging?
        set_collection_ivar(c)
      end
    end

    def load_resources
      end_of_association_chain.published.with_translations(I18n.locale)
    end

    # Override this methods in sub-controller if needed
    def filter_collection(collection)
       if parent.categorizable? && params[:category_id].present?
         @category = Category.find(params[:category_id])
         category_ids = @category.self_and_descendants.map(&:id) 
         collection = collection.categorized(category_ids)
       end

       if parent.stickable? && params[:sticker_id].present?
         @sticker = Sticker.find(params[:sticker_id])
         collection = collection.sticked(@sticker.name)
       end

       return collection
    end

    def search_all(collection)
      apply_scopes(collection, params[:search])
    end

    def order_all(collection)
      ord = if ordering?
        params[:search][:order]
      else
        'games.position ASC'
      end
      collection.order(ord.to_s)
    end

    def paginate_all(collection)
      collection.paginate(:page => params[:page], :per_page => per_page)
    end

    def paging?
      @paging ||= searching? && params[:search].has_key?(:per_page)
    end

    def ordering?
      @ordering ||= searching? && params[:search].has_key?(:order)
    end

    def searching?
      @searching ||= params.has_key?(:search)
    end
end