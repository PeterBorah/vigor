describe Vigor::Summoner, :vcr do
  before(:each) do
    Vigor.configure(ENV["API_KEY"])
  end

  it "can fetch masteries" do
    summoner = Vigor.summoner("semiel")
    pages = summoner.mastery_pages
    expect(pages.length).to eq 4

    expect(summoner.current_mastery_page.name).to eq "Mastery Page 2"

    expect(pages.first).to_not be_current

    hardiness = pages.first.find{|t| t.name = "Hardiness"}
    expect(hardiness.id).to eq 4212
  end

  it "can fetch runes" do
    summoner = Vigor.summoner("semiel")
    pages = summoner.rune_pages
    expect(pages.length).to eq 9

    current = summoner.current_rune_page
    expect(current.name).to eq "AD/ArPen/Def (Corki/Kha'Zix)"
    expect(current).to be_current

    slot_1 = current.find{|r| r.slot == 1}
    expect(slot_1.id).to eq 5253
  end

  it "will grab extra information when needed" do
    player = Vigor.recent_games("23893133").first.fellow_players.first
    expect(player.name).to eq "DARKNVADR"
    expect(player.profile_icon_id).to eq 588
    expect(player.team_id).to eq 100
  end
end
