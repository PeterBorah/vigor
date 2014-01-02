class Vigor
  class Stats
    attr_accessor :sets
    include Enumerable

    def initialize(data)
      @sets = data['playerStatSummaries'].map { |set| StatsSet.new(set) }
    end


    def each(&block)
      @sets.each do |set|
        block.call(set)
      end
    end

    def [](key)
      if key.kind_of?(Integer)
        return @sets[key]
      else
        return @sets.find { |set| set.type.casecmp(key) == 0 }
      end
    end
  end

  class StatsSet
    attr_accessor :losses, :modify_date, :wins, :stats, :type

    def initialize(data)
      @losses = data['losses']
      @modify_date = DateTime.strptime((data['modifyDate']/1000).to_s, '%s')
      @wins = data['wins']
      @stats = data['aggregatedStats']
      @type = data['playerStatSummaryType']
    end
  end
end
