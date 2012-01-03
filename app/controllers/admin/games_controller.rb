class Admin::GamesController < Admin::ResourcesController
  has_scope :with_title, :only => :index
  belongs_to :site
  belongs_to :game_list
  respond_to :html, :js, :mobile
  before_filter :get_unstranstaled_resources, :only => [:index]

  # update a single position
  def move
    if params[:position].present?
      resource = Game.find(params[:id])
      resource.insert_at(params[:position].to_i)
      render :nothing => true
    else
      puts "something wrong"
    end
  end

  def toggle_in_homepage
    @game = Game.find_by_id(params[:id])
    in_homepage = @game.show_in_homepage
    @game.update_attribute(:show_in_homepage, !in_homepage)
    if !in_homepage
      flash[:notice] = t(:'flash.game.add_in_homepage')
    else
      flash[:notice] = t(:'flash.game.delete_from_homepage')
    end
    respond_with(resources)
  end
end