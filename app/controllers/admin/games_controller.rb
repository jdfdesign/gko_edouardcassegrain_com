class Admin::GamesController < Admin::ResourcesController
  include Extensions::Controllers::Cacheable
  has_scope :with_title, :only => :index
  nested_belongs_to :site, :game_list
  respond_to :html, :js
  custom_actions :collection => [:selected]  
  
  def toggle_in_homepage
    @game = Game.find_by_id(params[:id])
    in_homepage = @game.show_in_homepage
    @game.update_attribute(:show_in_homepage, !in_homepage)
    if !in_homepage
      flash[:success] = t(:'flash.game.add_in_homepage')
    else
      flash[:success] = t(:'flash.game.delete_from_homepage')
    end
    respond_with(resources)
  end
end