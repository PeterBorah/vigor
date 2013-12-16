class Vigor
  class Champion
    attr_accessor :attack, :defense, :difficulty, :id, :magic, :name

    def initialize(data)
      @active = data["active"]
      @attack = data["attackRank"]
      @has_bot = data["botEnabled"]
      @has_mm_bot = data["botMmEnabled"]
      @defense = data["defenseRank"]
      @difficulty = data["difficultyRank"]
      @free_to_play = data["freeToPlay"]
      @id = data["id"]
      @magic = data["magicRank"]
      @name = data["name"]
      @in_ranked = data["rankedPlayEnabled"]
    end

    def active?
      @active
    end

    def has_bot?
      @has_bot
    end

    def has_mm_bot?
      @has_mm_bot
    end

    def free_to_play?
      @free_to_play
    end

    def in_ranked?
      @in_ranked
    end
  end
end
