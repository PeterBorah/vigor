class Vigor
  class League
    attr_accessor :entries, :name, :queue, :tier, :id

    def initialize(data, id)
      @entries = data['entries'].map { |entry| LeagueItem.new(entry) }
      @name = data['name']
      @queue = data['queue']
      @tier = data['tier']
      @id = id
    end

  end

  class LeagueItem
    attr_accessor :promo_series, :last_played, :name, :id, :rank, :tier, :wins, :queue_type

    def initialize(data)
      @is_fresh_blood = data['isFreshBlood']
      @is_hot_streak = data['isHotStreak']
      @is_inactive = data['isInactive']
      @is_veteran = data['isVeteran']
      @last_played = data['lastPlayed']
      @promo_series = PromoSeries.new(data['miniseries']) unless !data.include?('miniseries')
      @id = data['playerOrTeamId']
      @name = data['playerOrTeamName']
      @rank = data['rank']
      @tier = data['tier']
      @wins = data['wins']
      @queue_type = data['queueType']
    end

    def is_fresh_blood?
      @is_fresh_blood
    end

    def is_hot_streak?
      @is_hot_streak
    end

    def is_inactive?
      @is_inactive
    end

    def is_veteran?
      @is_vetaran
    end

    def in_series?
      !@promo_series.nil?
    end

    def to_summoner
      return nil unless @queue_type == "RANKED_SOLO_5x5"
      return Summoner.new({"id" => @id, "name" => @name}, :name_and_id)
    end

  end

  class PromoSeries
    attr_accessor :losses, :progress, :target, :time_left

    def initialize(data)
      @losses = data['losses']
      @progress = data['progress']
      @target = data['target']
      @time_left = data['timeLeftToPlayMillis']
    end

  end
end
