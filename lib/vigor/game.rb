class Vigor
  class Game
    attr_accessor :champion_id, :created_at, :fellow_players, :id, :mode, :type, :level, :map, :spells, :stats, :sub_type, :team_id

    def initialize(data)
      @champion_id = data["championId"]
      @created_at = DateTime.strptime((data["createDate"]/1000).to_s,'%s')
      @fellow_players = Array(data["fellowPlayers"]).map { |player| Summoner.new(player, :game) }
      @id = data["gameId"]
      @mode = data["gameMode"]
      @type = data["gameType"]
      @invalid = data["invalid"]
      @level = data["level"]
      @map = data["mapId"]
      @spells = [data["spell1"], data["spell2"]]
      @stats = data["statistics"] # Already a reasonable and simple list of hashes
      @sub_type = data["subType"]
      @team_id = data["teamId"]
    end

    def champion
      Vigor.champion(@champion_id)
    end

    def invalid?
      @invalid
    end
  end
end
