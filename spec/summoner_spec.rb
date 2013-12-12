describe Vigor::Summoner, :vcr do
  it "can fetch masteries" do
    vigor = Vigor::Client.new(ENV["API_KEY"])
    summoner = vigor.summoner("semiel")
    pages = summoner.mastery_pages
    pages.length.should == 4

    summoner.current_mastery_page.name.should == "AP"

    first_page = pages.select{|p| p.name = "Mastery Page 1"}.first
    first_page.should_not be_current

    hardiness = first_page.talents.select{|t| t.name = "Hardiness"}.first
    hardiness.id.should == 4233
  end

  it "can fetch runes" do
    vigor = Vigor::Client.new(ENV["API_KEY"])
    summoner = vigor.summoner("semiel")
    pages = summoner.rune_pages
    pages.length.should == 9

    current = summoner.current_rune_page
    current.name.should == "AP/MPen/Def (AP Carry)"
    current.should be_current

    slot_1 = current.runes.select{|r| r.slot == 1}.first
    slot_1.id.should == 5273
  end
end
