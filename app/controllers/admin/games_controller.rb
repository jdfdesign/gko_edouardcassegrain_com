class Admin::GamesController < Admin::ContentsController
  belongs_to :site
  belongs_to :game_list
end