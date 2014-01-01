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
      when :team
        add_team_data(data)
      when :name_and_id
        @id = data["id"]
        @fields[:name] = data["name"]
      when :id_only
        @id = data
      end
    end

    def add_summoner_data(data)
      @id = data["id"]
      @fields[:name] = data["name"]
      @fields[:profile_icon_id] = data["profileIconId"]
      @fields[:level] = data["summonerLevel"]
      @fields[:revision_date] = DateTime.strptime((data["revisionDate"]/1000).to_s,'%s')
    end

    def add_game_data(data)
      @id = data["summonerId"]
      @fields[:champion_id] = data["championId"]
      @fields[:champion] = champion(@fields[:champion_id])
      @fields[:team_id] = data["teamId"]
    end

    def add_team_data(data)
      @id = data["playerId"]
      @fields[:invite_date] = DateTime.strptime((data["inviteDate"]/1000).to_s, "%s")
      @fields[:join_date] = DateTime.strptime((data["joinDate"]/1000).to_s, "%s")
      @fields[:status] = data["status"]
    end

    def mastery_pages
      Vigor.mastery_pages(@id)
    end

    def rune_pages
      Vigor.rune_pages(@id)
    end

    def teams
      Vigor.teams(@id)
    end

    def stats(season = nil)
      Vigor.stats(@id, season)
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

    def respond_to_missing?(meth, *)
      (Available_fields + @fields.keys).include?(meth) || super
    end

    private
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
      add_summoner_data(Client.get("/v1.2/summoner/" + @id.to_s)) unless @fields[field]
      @fields[field]
    end

    def champion(id)
      Vigor.champion(id)
    end
  end
end
