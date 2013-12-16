require 'vigor/summoner'
require 'vigor/client'
require 'vigor/page'
require 'vigor/mastery_page'
require 'vigor/talent'
require 'vigor/rune_page'
require 'vigor/rune'
require 'vigor/error'

class Vigor

  def self.configure(api_key, region = "na")
    Client.default_params :api_key => api_key
    Client.base_uri "http://prod.api.pvp.net/api/lol/#{region}/v1.1"
  end

  def self.summoner(lookup_value)
    if lookup_value.is_a? String
      return Summoner.new(Client.get("/summoner/by-name/" + lookup_value.gsub(/\s+/, "")))
    else
      return Summoner.new(Client.get("/summoner/" + lookup_value.to_s))
    end
  end
end
