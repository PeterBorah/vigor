describe Vigor::Stats, :vcr do
  before(:each) do
    Vigor.configure(ENV["API_KEY"])
  end

  it "can get stats by summoner id" do
    ai_stats = Vigor.stats(48686086)["CoopVsAi"]
    expect(ai_stats.wins).to eq 1
    expect(ai_stats.losses).to eq 0
    expect(ai_stats.stats["totalNeutralMinionsKilled"]).to eq 8
    expect(ai_stats.stats["totalAssists"]).to eq 10
    expect(ai_stats.stats["totalChampionKills"]).to eq 4
  end

  it "can get stats from a summoner" do
    summoner = Vigor.summoner("Notable Penguin")
    stats = summoner.stats
    expect(stats.sets.size).to eq 4
  end

  it "can get stats for a specific season" do
    stats = Vigor.stats(31640242, "SEASON3")
    solo_queue = stats["RankedSolo5x5"]
    expect(solo_queue.wins).to eq 87
    expect(solo_queue.stats["totalMinionKills"]).to eq 9847
  end
end
