class Vigor
  class Team
    attr_accessor :create_date, :id, :last_game_date, :last_queued_date, :recent_games,
                  :modify_date, :name, :members, :owner, :status, :tag, :rift_stats, :treeline_stats, :last_join_dates

    def initialize(data)
      @create_date = DateTime.strptime((data["createDate"]/1000).to_s, '%s')
      @id = data["fullId"]
      @last_game_date = DateTime.strptime((data["lastGameDate"]/1000).to_s, '%s') if data.include?("lastGameDate")
      @last_queued_date = DateTime.strptime((data["lastJoinedRankedTeamQueueDate"]/1000).to_s, '%s') # wtf rename this
      @recent_games = data["matchHistory"].map { |match| TeamGame.new(match) } if data.include?("matchHistory")
      @modify_date = DateTime.strptime((data["modifyDate"]/1000).to_s, '%s')
      @name = data["name"]
      @members = data["roster"]["memberList"].map { |member| Summoner.new(member, :team) }
      @owner = Summoner.new(data["roster"]["ownerId"], :id_only)
      @status = data["status"]
      @tag = data["tag"]
      @rift_stats = TeamStat.new(data["teamStatSummary"]["teamStatDetails"].find { |stats| stats["teamStatType"] == "RANKED_TEAM_5x5" })
      @treeline_stats = TeamStat.new(data["teamStatSummary"]["teamStatDetails"].find { |stats| stats["teamStatType"] == "RANKED_TEAM_3x3" })
      @last_join_dates = [data["lastJoinDate"], data["secondLastJoinDate"], data["thirdLastJoinDate"]].map { |date| DateTime.strptime((date/1000).to_s, '%s') }
    end

  end

  class TeamGame
    attr_accessor :assists, :deaths, :id, :game_mode, :kills, :map_id, :opposing_team_kills, :opposing_team_name

    def initialize(data)
      @assists = data["assists"]
      @deaths = data["deaths"]
      @id = data["gameId"]
      @game_mode = data["gameMode"]
      @invalid = data["invalid"]
      @kills = data["kills"]
      @map_id = data["mapId"]
      @opposing_team_kills = data["opposingTeamKills"]
      @opposing_team_name = data["opposingTeamName"]
      @win = data["win"]
    end

    def invalid?
      @invalid
    end

    def win?
      @win
    end

  end

  class TeamStat
    attr_accessor :id, :losses, :average_games_played, :wins

    def initialize(data)
      @id = data["fullId"]
      @losses = data["losses"]
      @average_games_played = data["averageGamesPlayed"] # this seemingly never returns anything but zero
      @wins = data["wins"]
    end

  end

end
