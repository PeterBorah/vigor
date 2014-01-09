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
end

#todo - split this into LeagueSummoner and LeagueTeam - then add to_team and to_summoner

class LeagueItem
  attr_accessor :promo_series, :last_played

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

end

class PromoSeries

  def initialize(data)
    @losses = data['losses']
    @progress = data['progress']
    @target = data['target']
    @timeLeft = data['timeLeftToPlayMillis']
  end

end
