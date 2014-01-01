class Vigor
  class ChampionStats
    attr_accessor :champions, :modify_date

    def initialize(data)
      @champions = data['champions'].map { |champion| ChampionAggregate.new(champion) }
      @modify_date = DateTime.strptime((data['modifyDate']/1000).to_s, '%s')
    end

  end

  class ChampionAggregate # rename this, tired atm ><
    attr_accessor :stats, :name, :id

    def initialize(data)
      @stats = data['stats']
      @id = data['id']
      @name = data['name']
    end

  end
end
