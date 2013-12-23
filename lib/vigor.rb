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

  @@regions = ['na', 'euw', 'eune', 'br', 'tr']

  def self.configure(api_key, region = "na")
    region.downcase!
    raise Vigor::Error::InvalidRegion, "Invalid Region Configuration" unless @@regions.include?(region)
    Client.default_params :api_key => api_key
    Client.base_uri "http://prod.api.pvp.net/api/lol/#{region}"
    self
  end

  def self.summoner(lookup_value)
    if lookup_value.is_a? String
      return Summoner.new(Client.get("/v1.2/summoner/by-name/" + lookup_value.gsub(/\s+/, "")))
    else
      return Summoner.new(Client.get("/v1.2/summoner/" + lookup_value.to_s))
    end
  end

  def self.mastery_pages(id)
    Client.get("/v1.2/summoner/#{id.to_s}/masteries")["pages"].map {|page| MasteryPage.new(page)}
  end

  def self.rune_pages(id)
    Client.get("/v1.2/summoner/#{id.to_s}/runes")["pages"].map {|page| RunePage.new(page)}
  end

  def self.all_champions
    @@champions ||= Client.get("/v1.1/champion")["champions"].map {|champ| Champion.new(champ)}
  end

  def self.free_to_play
    Client.get("/v1.1/champion/", query: {"freeToPlay" => true})["champions"].map {|champ| Champion.new(champ)}
  end

  def self.champion(lookup_value)
    if lookup_value.is_a? String
      self.all_champions.find {|champ| champ.name == lookup_value}
    else
      self.all_champions.find {|champ| champ.id == lookup_value}
    end
  end

  def self.recent_games(id)
    Client.get("/v1.2/game/by-summoner/#{id.to_s}/recent")["games"].map {|game| Game.new(game)}
  end
end
