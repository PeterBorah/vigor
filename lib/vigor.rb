require 'uri/common'

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
require_relative 'vigor/team'
require_relative 'vigor/stats'
require_relative 'vigor/champion_stats'

class Vigor
  class << self
    @@regions = ['na', 'euw', 'eune', 'br', 'tr']

    def configure(api_key, region = "na")
      region.downcase!
      raise Vigor::Error::InvalidRegion, "Invalid Region Configuration" unless @@regions.include?(region)
      Client.default_params :api_key => api_key
      Client.base_uri "http://prod.api.pvp.net/api/lol/#{region}"
      self
    end

    def summoner(lookup_value)
      if lookup_value.is_a? String
        return Summoner.new(Client.get("/v1.2/summoner/by-name/" + lookup_value.gsub(/\s+/, "")))
      else
        return Summoner.new(Client.get("/v1.2/summoner/" + lookup_value.to_s))
      end
    end

    def summoners(ids)
      response = Client.get("/v1.2/summoner/#{URI.encode(ids.join(", "))}/name")
      response["summoners"].map { |summoner| Summoner.new(summoner, :name_and_id) }
    end

    def mastery_pages(id)
      Client.get("/v1.2/summoner/#{id.to_s}/masteries")["pages"].map {|page| MasteryPage.new(page)}
    end

    def rune_pages(id)
      Client.get("/v1.2/summoner/#{id.to_s}/runes")["pages"].map {|page| RunePage.new(page)}
    end

    def all_champions
      @@champions ||= Client.get("/v1.1/champion")["champions"].map {|champ| Champion.new(champ)}
    end

    def free_to_play
      Client.get("/v1.1/champion/", query: {"freeToPlay" => true})["champions"].map {|champ| Champion.new(champ)}
    end

    def champion(lookup_value)
      if lookup_value.is_a? String
        self.all_champions.find {|champ| champ.name == lookup_value}
      else
        self.all_champions.find {|champ| champ.id == lookup_value}
      end
    end

    def recent_games(id)
      games = Client.get("/v1.2/game/by-summoner/#{id.to_s}/recent")["games"].map {|game| Game.new(game)}
      games.sort { |x, y| y.created_at <=> x.created_at }
    end

    def teams(id)
      Client.get("/v2.2/team/by-summoner/#{id.to_s}").map {|team| Team.new(team)}
    end

    # returns summary stats for each queue type
    def stats(id, season = nil)
      Stats.new(Client.get("/v1.2/stats/by-summoner/#{id}/summary", query: {"season" => season.to_s}))
    end

    # returns detailed ranked stats for each champion (combines rift and treeline stats)
    def champion_stats(id, season = nil)
      ChampionStats.new(Client.get("/v1.2/stats/by-summoner/#{id}/ranked", query: {"season" => season.to_s}))
    end
  end
end
