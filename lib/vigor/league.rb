class Vigor
  class League
    attr_accessor :members, :name, :queue, :tier, :id

    def initialize(data, id)
      @members = data['entries'].map { |entry| LeagueMember.new(entry) }
      @name = data['name']
      @queue = data['queue']
      @tier = data['tier']
      @id = id
    end

  end

  class LeagueMember
    attr_accessor :series, :last_played, :name, :id, :rank, :tier, :wins, :queue_type

    def initialize(data)
      @fresh_blood = data['isFreshBlood']
      @hot_streak = data['isHotStreak']
      @inactive = data['isInactive']
      @veteran = data['isVeteran']
      @last_played = data['lastPlayed']
      @series = Series.new(data['miniSeries']) unless !data.include?('miniSeries')
      @id = data['playerOrTeamId']
      @name = data['playerOrTeamName']
      @rank = data['rank']
      @tier = data['tier']
      @wins = data['wins']
      @queue_type = data['queueType']
    end

    def fresh_blood?
      @fresh_blood
    end

    def hot_streak?
      @hot_streak
    end

    def inactive?
      @inactive
    end

    def veteran?
      @veteran
    end

    def in_series?
      !@series.nil?
    end

    def to_summoner
      @queue_type == "RANKED_SOLO_5x5" ? Summoner.new({"id" => @id, "name" => @name}, :name_and_id) : nil
    end

  end

  class Series
    attr_accessor :losses, :progress, :target, :time_left, :wins

    def initialize(data)
      @losses = data['losses']
      @wins = data['wins']
      @progress = data['progress']
      @target = data['target']
      @time_left = data['timeLeftToPlayMillis']
    end

  end
end
