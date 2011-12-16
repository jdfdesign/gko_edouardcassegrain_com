Site.class_eval do
  has_many :game_lists
  has_many :games, :through => :game_lists
end
