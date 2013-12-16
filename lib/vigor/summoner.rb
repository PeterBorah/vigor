class Vigor
  class Summoner
    attr_accessor :id, :name, :profile_icon_id, :level, :revision_date

    def initialize(data)
      @id = data["id"]
      @name = data["name"]
      @profile_icon_id = data["profileIconId"]
      @level = data["summonerLevel"]
      @revision_date = DateTime.strptime(data["revisionDate"].to_s,'%s')
    end

    def mastery_pages
      Client.get("/summoner/" + @id.to_s + "/masteries")["pages"].map {|page| MasteryPage.new(page)}
    end

    def rune_pages
      Client.get("/summoner/" + @id.to_s + "/runes")["pages"].map {|page| RunePage.new(page)}
    end

    def current_mastery_page
      mastery_pages.find {|page| page.current? }
    end

    def current_rune_page
      rune_pages.find {|page| page.current? }
    end
  end
end
