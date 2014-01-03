describe Vigor::ChampionStats, :vcr do
  before (:each) do
    Vigor.configure(ENV["API_KEY"])
  end

  it "can get champion stats" do
    stats = Vigor.champion_stats(31640242)
    taric = stats["taric"]
    expect(taric["totalSessionsPlayed"]).to eq 4
    expect(taric["totalAssists"]).to eq 51
    expect(taric["totalSessionsLost"]).to eq 3
  end

  it "can get stats from a summoner" do
    idea = Vigor.summoner("idea")
    stats = idea.champion_stats
    expect(stats.modify_date.to_s).to eq "2013-12-30T00:18:50+00:00"
  end

  it "can get stats for a specific season" do
    stats = Vigor.champion_stats(31640242, "SEASON3")
    amumu = stats["amumu"]
    expect(amumu["totalSessionsPlayed"]).to eq 4
    expect(amumu["totalChampionKills"]).to eq 10
    expect(amumu["totalMinionKills"]).to eq 163
  end

  it "can get combined stats" do
    combined = Vigor.champion_stats(31640242, "SEASON3").combined
    expect(combined["totalSessionsWon"]).to eq 94
    expect(combined["maxChampionsKilled"]).to eq 20
    expect(combined["totalDoubleKills"]).to eq 64
    expect(combined["totalDamageDealt"]).to eq 11525920
  end
end
