describe Vigor, :vcr do
  before(:each) do
    Vigor.configure(ENV["API_KEY"])
  end

  it "can get a summoner by name" do
    summoner = Vigor.summoner("semiel")
    summoner.id.should == 23893133
    summoner.name.should == "Semiel"
    summoner.profile_icon_id.should == 518
    summoner.level.should == 30
  end

  it "can get a summoner by id" do
    summoner = Vigor.summoner(23893133)
    summoner.id.should == 23893133
    summoner.name.should == "Semiel"
    summoner.profile_icon_id.should == 518
    summoner.level.should == 30
  end

  it "can get summoners whose names have whitespace" do
    summoner = Vigor.summoner("Best Riven NA")
    summoner.id.should == 32400810
    summoner.name.should == "Best Riven NA"
    summoner.level.should == 30
  end

  it "can get all champions" do
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
    zyra = Vigor.champion("Zyra")
    zyra.id.should == 143
  end

  it "can get free-to-play champions" do
    free_champs = Vigor.free_to_play
    free_champs.length.should == 10
  end

  it "can get recent games" do
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

describe Vigor, :vcr do
  before(:each) do
    Vigor.configure(ENV["API_KEY"], "euw")
  end

  it "works on servers other than NA" do
    summoner = Vigor.summoner("Froggen")
    summoner.id.should == 19531813
    summoner.name.should == "Froggen"
    summoner.level.should == 30
  end
end
