require 'httparty'

module Vigor
  class Client
    include HTTParty
    # debug_output $stderr

    def initialize(api_key, region = "na")
      self.class.default_params :api_key => api_key
      self.class.base_uri "http://prod.api.pvp.net/api/lol/#{region}/v1.1"
    end

    def summoner(lookup_value)
      if lookup_value.is_a? String
        return Summoner.new(self.class.get("/summoner/by-name/" + lookup_value.gsub(/\s+/, "")))
      else
        return Summoner.new(self.class.get("/summoner/" + lookup_value.to_s))
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

    def mastery_pages (option = nil)
      @mastery_pages ||= Client.get("/summoner/" + @id.to_s + "/masteries")["pages"].map {|page| MasteryPage.new(page)}
      if option == :current
        @mastery_pages.find {|page| page.current? }
      else
        @mastery_pages
      end
    end

    def rune_pages (option = nil)
      @rune_pages ||= Client.get("/summoner/" + @id.to_s + "/runes")["pages"].map {|page| RunePage.new(page)}
      if option == :current
        @rune_pages.find {|page| page.current? }
      else
        @rune_pages
      end
    end
  end

  class Page
    attr_accessor :name

    def initialize(data)
      @name = data["name"]
      @current = data["current"]
    end

    def current?
      @current
    end
  end

  class MasteryPage < Page
    attr_accessor :talents

    def initialize(data)
      super

      return if data["talents"].nil?
      @talents = data["talents"].map {|talent| Talent.new(talent)}
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

  class RunePage < Page
    attr_accessor :runes, :id

    def initialize(data)
      super
      @id = data["id"]

      return if data["slots"].nil?
      @runes = data["slots"].map {|slot| Rune.new(slot)}
    end
  end

  class Rune
    attr_accessor :slotId, :runeId, :description, :name, :tier

    def initialize(data)
      rune = data["rune"]

      @slotId = data["runeSlotId"]
      @runeId = rune["id"]
      @description = rune["description"]
      @name = rune["name"]
      @tier = rune["tier"]
    end
  end
end
