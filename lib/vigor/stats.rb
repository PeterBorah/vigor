class Vigor
  class Stats
    attr_accessor :sets

    def initialize(data)
      @sets = data['playerStatSummaries'].map { |set| StatsSet.new(set) }
    end

  end

  class StatsSet
    attr_accessor :losses, :modify_date, :wins, :type, :stats

    def initialize(data)
      @losses = data['losses']
      @modify_date = DateTime.strptime((data['modifyDate']/1000).to_s, '%s')
      @wins = data['wins']
      @type = data['playerStatSummaryType']
      @stats = data['aggregatedStats']
    end

  end
end
