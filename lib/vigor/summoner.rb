class Vigor
  class Summoner
    attr_accessor :id
    Available_fields = [:name, :profile_icon_id, :level, :revision_date]

    def initialize(data, source = :summoner)
      @fields = {}
      case source
      when :summoner
        add_summoner_data(data)
      when :game
        add_game_data(data)
      end
    end

    def add_summoner_data(data)
      @id = data["id"]
      @fields[:name] = data["name"]
      @fields[:profile_icon_id] = data["profileIconId"]
      @fields[:level] = data["summonerLevel"]
      @fields[:revision_date] = DateTime.strptime(data["revisionDate"].to_s,'%s')
    end

    def add_game_data(data)
      @id = data["summonerId"]
      @fields[:champion_id] = data["championId"]
      @fields[:team_id] = data["teamId"]
    end

    def mastery_pages
      Vigor.mastery_pages(@id)
    end

    def rune_pages
      Vigor.rune_pages(@id)
    end

    def current_mastery_page
      mastery_pages.find {|page| page.current? }
    end

    def current_rune_page
      rune_pages.find {|page| page.current? }
    end

    def recent_games
      Vigor.recent_games(@id)
    end

    def method_missing(meth)
      if Available_fields.include? meth
        return get_or_fetch_field(meth)
      elsif @fields[meth]
        return @fields[meth]
      else
        super
      end
    end

    def get_or_fetch_field(field)
      add_summoner_data(Client.get("/summoner/" + @id.to_s)) unless @fields[field]
      @fields[field]
    end

    def respond_to_missing?(meth, *)
      (Available_fields + @fields.keys).include?(meth) || super
    end
  end
end
