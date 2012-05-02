class GameList < Section
  has_many :games, :foreign_key => 'section_id', :dependent => :destroy, :order => 'games.position DESC'
  def content_type
    "Game"
  end
end
