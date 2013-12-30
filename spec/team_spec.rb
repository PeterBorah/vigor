describe Vigor::Team, :vcr do
  before(:each) do
    Vigor.configure(ENV["API_KEY"])

    @teams = Vigor.teams(31640242)
  end

  it "can get all teams for a summoner" do
    expect(@teams.size).to eq 4

    karma = @teams[2]
    expect(karma.name).to eq "The Karma Police"
    expect(karma.members.size).to eq 8
    expect(karma.status).to eq "PROVISIONAL"
    expect(karma.tag).to eq "CKPD"
    expect(karma.owner_id).to eq 40790714
    expect(karma.last_join_dates.map(&:to_s)).to eq ["2013-12-12T04:30:21+00:00", "2013-12-06T18:56:16+00:00", "2013-12-06T06:55:21+00:00"]
  end

  it "can get the match history for a team" do
    history = @teams[2].match_history
    expect(history.size).to eq 3
    last_game = history.first
    expect(last_game.assists).to eq 5
    expect(last_game.deaths).to eq 21
    expect(last_game.kills).to eq 9
    expect(last_game.map_id).to eq 1
    expect(last_game.game_id).to eq 1191217681
    expect(last_game.game_mode).to eq "CLASSIC"
    expect(last_game.win?).to be false
    expect(last_game.opposing_team_kills).to eq 21
    expect(last_game.opposing_team_name).to eq "WO CA NY"
  end

  it "can get info on individual members" do
    member = @teams[2].members[1]
    expect(member.invite_date.to_s).to eq "2013-12-05T22:25:04+00:00"
    expect(member.join_date.to_s).to eq "2013-12-06T06:55:21+00:00"
    expect(member.player_id).to eq 43083658
    expect(member.status).to eq "MEMBER"
  end

  it "can get map stats for a team" do
    karma = @teams[2]
    expect(karma.treeline_stats.wins).to eq 0
    expect(karma.treeline_stats.losses).to eq 0
    expect(karma.treeline_stats.average_games_played).to eq 0
    expect(karma.rift_stats.wins).to eq 1
    expect(karma.rift_stats.losses).to eq 2
    expect(karma.rift_stats.average_games_played).to eq 0
  end

end
