require_relative 'vigor/summoner'
require_relative 'vigor/client'
require_relative 'vigor/page'
require_relative 'vigor/mastery_page'
require_relative 'vigor/talent'
require_relative 'vigor/rune_page'
require_relative 'vigor/rune'
require_relative 'vigor/error'
require_relative 'vigor/champion'
require_relative 'vigor/game'

class Vigor

  def self.configure(api_key, region = "na")
    Client.default_params :api_key => api_key
    Client.base_uri "http://prod.api.pvp.net/api/lol/#{region}/v1.1"
    self
  end

  def self.summoner(lookup_value)
    if lookup_value.is_a? String
      return Summoner.new(Client.get("/summoner/by-name/" + lookup_value.gsub(/\s+/, "")))
    else
      return Summoner.new(Client.get("/summoner/" + lookup_value.to_s))
    end
  end

  def self.mastery_pages(id)
    Client.get("/summoner/#{id.to_s}/masteries")["pages"].map {|page| MasteryPage.new(page)}
  end

  def self.rune_pages(id)
    Client.get("/summoner/#{id.to_s}/runes")["pages"].map {|page| RunePage.new(page)}
  end

  def self.all_champions
    Client.get("/champion")["champions"].map {|champ| Champion.new(champ)}
  end

  def self.free_to_play
    Client.get("/champion/", query: {"freeToPlay" => true})["champions"].map {|champ| Champion.new(champ)}
  end

  def self.champion(name)
    self.all_champions.find {|champ| champ.name == name}
  end

  def self.recent_games(id)
    Client.get("/game/by-summoner/#{id.to_s}/recent")["games"].map {|game| Game.new(game)}
  end
end
