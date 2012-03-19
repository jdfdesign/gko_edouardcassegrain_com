class GameSweeper < Gko::Sweeper

    observe Game

    def after_create(game)
      expire_game_cache(game)
    end

    def after_update(game)
      expire_game_cache(game)
    end

    def after_destroy(game)
      expire_game_cache(game)
    end
    
    protected
    
    def expire_game_cache(game)
      delete_cached_section_page(game.section)
    end

end