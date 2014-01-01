class Vigor
  class Stats
    attr_reader :sets

    def initialize(data)
      @sets = data['playerStatSummaries'].map { |set| StatsSet.new(set) }
    end

  end

  class StatsSet
    attr_reader :losses, :modify_date, :wins, :type, :stats

    def initialize(data)
      @losses = data['losses']
      @modify_date = data['modifyDate']
      @wins = data['wins']
      @type = data['playerStatSummaryType']
      @stats = data['aggregatedStats']
    end

  end
end
