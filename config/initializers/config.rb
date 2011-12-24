APP_CONFIG = YAML.load_file("config/config.yml")[Rails.env]
#GkoCassegrainCom::Application.config.to_prepare { require_dependency 'game_list' }