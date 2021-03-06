describe Vigor, :vcr do
  before(:each) do
    Vigor.configure(ENV["API_KEY"])
  end

  it "can get a summoner by name" do
    summoner = Vigor.summoner("semiel")
    expect(summoner.id).to eq 23893133
    expect(summoner.name).to eq "Semiel"
    expect(summoner.profile_icon_id).to eq 562
    expect(summoner.level).to eq 30
  end

  it "can get a summoner by id" do
    summoner = Vigor.summoner(23893133)
    expect(summoner.id).to eq 23893133
    expect(summoner.name).to eq "Semiel"
    expect(summoner.profile_icon_id).to eq 562
    expect(summoner.level).to eq 30
  end

  it "can get multiple summoners by id" do
    summoners = Vigor.summoners([31640242, 23893133])
    expect(summoners.map(&:name)).to eq ["Idea", "Semiel"]
  end

  it "can get summoners whose names have whitespace" do
    summoner = Vigor.summoner("Best Riven NA")
    expect(summoner.id).to eq 32400810
    expect(summoner.name).to eq "Best Riven NA"
    expect(summoner.level).to eq 30
  end

  it "can get all champions" do
    champs = Vigor.all_champions
    expect(champs.length).to eq 117
    zyra = champs.last

    expect(zyra.name).to eq "Zyra"
    expect(zyra.id).to eq 143

    expect(zyra).to be_in_ranked
    expect(zyra).to be_active
    expect(zyra.has_bot?).to be false
    expect(zyra.has_mm_bot?).to be true
    expect(zyra).not_to be_free_to_play

    expect(zyra.defense).to eq 3
    expect(zyra.attack).to eq 4
    expect(zyra.difficulty).to eq 7
    expect(zyra.magic).to eq 8
  end

  it "can get a champion by name" do
    zyra = Vigor.champion("Zyra")
    expect(zyra.id).to eq 143
  end

  it "can get a champion by id" do
    zyra = Vigor.champion(143)
    expect(zyra.name).to eq "Zyra"
  end

  it "can get free-to-play champions" do
    free_champs = Vigor.free_to_play
    expect(free_champs.length).to eq 10
  end

  it "can get recent games" do
    recent_games = Vigor.summoner("Semiel").recent_games
    expect(recent_games.length).to eq 10

    most_recent = recent_games.first
    expect(most_recent.level).to eq 30
    expect(most_recent.mode).to eq "FIRSTBLOOD"
    expect(most_recent.type).to eq "MATCHED_GAME"
    expect(most_recent).to_not be_invalid
    expect(most_recent.map).to eq 12
    expect(most_recent.spells).to eq [4, 21]
    expect(most_recent.created_at.year).to eq 2013
    expect(most_recent.created_at.day).to eq 20

    true_damage_taken = most_recent.stats.find {|stat| stat["id"] == 104 }
    expect(true_damage_taken["value"]).to eq 136

    players = most_recent.fellow_players
    expect(players.length).to eq 1
    expect(players.first.champion_id).to eq 17
    expect(players.first.champion.name).to eq "Teemo"
  end

  it "sorts recent games by most recent" do
    recent_games = Vigor.recent_games(48686086)
    expect(recent_games.each_cons(2).all? { |x, y| x.created_at > y.created_at }).to be true
  end

  it "can get game data for games with a single player" do
    recent_games = Vigor.summoner("idea").recent_games
    custom_game = recent_games[8]
    expect(custom_game.champion_id).to eq 92
    expect(custom_game.type).to eq "CUSTOM_GAME"
    expect(custom_game.fellow_players.empty?).to be true
  end
end
