class GamesController < ContentsController
  respond_to :html, :js
  belongs_to :game_list
end