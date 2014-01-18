describe Vigor::League, :vcr do
  before (:each) do
    Vigor.configure(ENV["API_KEY"])
  end

  it "can look up League information" do
    leagues = Vigor.leagues(31640242)

    solo = leagues.first
    expect(solo.name).to eq "Rumble's Spellslingers"
    expect(solo.queue).to eq "RANKED_SOLO_5x5"
    expect(solo.tier).to eq "GOLD"
    expect(solo.id).to eq "31640242"
    expect(solo.members.size).to eq 124

    member = solo.members.find { |member| member.in_series? }
    expect(member.name).to eq "xSlim Shady"
    expect(member.fresh_blood?).to be false
    expect(member.hot_streak?).to be false
    expect(member.inactive?).to be false
    expect(member.veteran?).to be true
    expect(member.last_played).to eq 0
    expect(member.id).to eq "41955027"
    expect(member.rank).to eq "V"
    expect(member.tier).to eq "GOLD"
    expect(member.wins).to eq 672
    expect(member.queue_type).to eq "RANKED_SOLO_5x5"
    expect(member.series.losses).to eq 1
    expect(member.series.wins).to eq 0
    expect(member.series.progress).to eq "LNN"
    expect(member.series.target).to eq 2
    expect(member.series.time_left).to eq 0

    team = leagues.last
    expect(team.name).to eq "Jax's Crushers"
    expect(team.queue).to eq "RANKED_TEAM_3x3"
    expect(team.tier).to eq "GOLD"
    expect(team.id).to eq "TEAM-bf6bb970-f4cc-11e2-946c-782bcb4d1861"
    expect(team.members.first.to_summoner).to be nil
  end

  it "can look up Leagues from a Summoner" do
    summoner = Vigor.summoner("idea")
    leagues = summoner.leagues
    expect(leagues.first.queue).to eq "RANKED_SOLO_5x5"
  end

  it "can create a Summoner from a LeagueItem" do
    leagues = Vigor.leagues(31640242)
    member = leagues.first.members.first
    expect(member.to_summoner.level).to eq 30
  end

end
