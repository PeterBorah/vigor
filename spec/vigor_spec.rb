describe Vigor, :vcr do
  it "can find a summoner by name" do
    Vigor.configure(ENV["API_KEY"])
    summoner = Vigor.summoner("semiel")
    summoner.id.should == 23893133
    summoner.name.should == "Semiel"
    summoner.profile_icon_id.should == 518
    summoner.level.should == 30
  end

  it "can find a summoner by id" do
    Vigor.configure(ENV["API_KEY"])
    summoner = Vigor.summoner(23893133)
    summoner.id.should == 23893133
    summoner.name.should == "Semiel"
    summoner.profile_icon_id.should == 518
    summoner.level.should == 30
  end

  it "works on servers other than NA" do
    Vigor.configure(ENV["API_KEY"], "euw")
    summoner = Vigor.summoner("Froggen")
    summoner.id.should == 19531813
    summoner.name.should == "Froggen"
    summoner.level.should == 30
  end

  it "can find summoners whose names have whitespace" do
    Vigor.configure(ENV["API_KEY"])
    summoner = Vigor.summoner("Best Riven NA")
    summoner.id.should == 32400810
    summoner.name.should == "Best Riven NA"
    summoner.level.should == 30
  end

  it "raises an exception when using a bad key" do
    Vigor.configure("bad_key")
    lambda { Vigor.summoner("semiel") }.should raise_error(Vigor::Error::Unauthorized)
  end

  it "raises an exception when no summoner name exists" do
    Vigor.configure(ENV["API_KEY"])
    lambda { Vigor.summoner("invalid1234") }.should raise_error(Vigor::Error::SummonerNotFound)
  end

  it "raises an exception when no summoner id exists" do
    Vigor.configure(ENV["API_KEY"])
    lambda { Vigor.summoner(0)}.should raise_error(Vigor::Error::SummonerNotFound)
  end

  it "raises an exception when the API is down" do
    stub_request(:get, "http://prod.api.pvp.net/api/lol/na/v1.1/summoner/by-name/semiel?api_key=#{ENV["API_KEY"]}").
        to_return(:status => 500, :body => "", :headers => {})
    Vigor.configure(ENV["API_KEY"])
    lambda { Vigor.summoner("semiel") }.should raise_error(Vigor::Error::InternalServerError)
  end

  it "can get all champions" do
    Vigor.configure(ENV["API_KEY"])
    champs = Vigor.all_champions
    champs.length.should == 117
    zyra = champs.last

    zyra.name.should == "Zyra"
    zyra.id.should == 143

    zyra.should be_in_ranked
    zyra.should be_active
    zyra.has_bot?.should be_false
    zyra.has_mm_bot?.should be_true
    zyra.should_not be_free_to_play

    zyra.defense.should == 3
    zyra.attack.should == 4
    zyra.difficulty.should == 7
    zyra.magic.should == 8
  end

  it "can get a champion by name" do
    Vigor.configure(ENV["API_KEY"])
    zyra = Vigor.champion("Zyra")
    zyra.id.should == 143
  end

  it "can get free-to-play champions" do
    Vigor.configure(ENV["API_KEY"])
    free_champs = Vigor.free_to_play
    free_champs.length.should == 10
  end

  it "can get recent games" do
    Vigor.configure(ENV["API_KEY"])
    recent_games = Vigor.summoner("Semiel").recent_games
    recent_games.length.should == 10

    most_recent = recent_games.first
    most_recent.level.should == 30
    most_recent.mode.should == "ARAM"
    most_recent.type.should == "MATCHED_GAME"
    most_recent.should_not be_invalid
    most_recent.map.should == 12
    most_recent.spells.should == [4, 7]

    double_kills = most_recent.stats.find {|stat| stat["id"] == 16 }
    double_kills["value"].should == 1

    players = most_recent.fellow_players
    players.length.should == 9
    players.first.champion_id.should == 33
  end
end
