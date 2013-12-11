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

    def mastery_pages
      mastery_hash = Client.get("/summoner/" + @id.to_s + "/masteries")
      return mastery_hash["pages"].map {|page| MasteryPage.new(page)}
    end
  end

  class MasteryPage
    attr_accessor :talents, :name

    def initialize(data)
      @talents = data["talents"].map {|talent| Talent.new(talent)}
      @name = data["name"]
      @current = data["current"]
    end

    def current?
      @current
    end
  end

  class Talent
    attr_accessor :id, :rank, :name

    def initialize(data)
      @id = data["id"]
      @rank = data["rank"]
      @name = data["name"]
    end
  end
end
