class Vigor
  class ChampionStats
    attr_accessor :champions, :modify_date
    include Enumerable

    def initialize(data)
      @champions = data['champions'].map { |champion| ChampionSet.new(champion) }
      @modify_date = DateTime.strptime((data['modifyDate']/1000).to_s, '%s')
    end

    def combined
      @champions.last.stats
    end

    def each(&block)
      @champions.each do |champion|
        block.call(champion)
      end
    end

    def [](key)
      if key.kind_of?(Integer)
        return @champions[key]
      else
        champ = @champions.find { |champ| champ.name.casecmp(key) == 0 }
        return champ.nil? ? {} : champ.stats
      end
    end
  end

  class ChampionSet
    attr_accessor :stats, :name, :id

    def initialize(data)
      @stats = data['stats']
      @id = data['id']
      @name = data['name']
    end
  end
end
