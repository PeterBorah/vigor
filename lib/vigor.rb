require 'httparty'

module Vigor
  class Client
    include HTTParty
    base_uri "http://prod.api.pvp.net/api/lol/na/v1.1"
    # debug_output $stderr

    def initialize(api_key)
      self.class.default_params :api_key => api_key
    end

    def summoner(lookup_value)
      if lookup_value.is_a? String
        return Summoner.new(self.class.get("/summoner/by-name/" + lookup_value))
      end
    end
  end

  class Summoner
    attr_accessor :id, :name, :profile_icon_id, :level, :revision_date

    def initialize(data)
      @id = data["id"]
      @name = data["name"]
      @profile_icon_id = data["profileIconId"]
      @level = data["summonerLevel"]
      @revision_date = DateTime.strptime(data["revisionDate"].to_s,'%s')
    end
  end
end
