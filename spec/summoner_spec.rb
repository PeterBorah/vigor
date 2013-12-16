describe Vigor::Summoner, :vcr do
  it "can fetch masteries" do
    Vigor.configure(ENV["API_KEY"])
    summoner = Vigor.summoner("semiel")
    pages = summoner.mastery_pages
    pages.length.should == 4

    summoner.current_mastery_page.name.should == "AP"

    first_page = pages.find{|p| p.name = "Mastery Page 1"}
    first_page.should_not be_current

    hardiness = first_page.find{|t| t.name = "Hardiness"}
    hardiness.id.should == 4233
  end

  it "can fetch runes" do
    Vigor.configure(ENV["API_KEY"])
    summoner = Vigor.summoner("semiel")
    pages = summoner.rune_pages
    pages.length.should == 9

    current = summoner.current_rune_page
    current.name.should == "AP/MPen/Def (AP Carry)"
    current.should be_current

    slot_1 = current.find{|r| r.slot == 1}
    slot_1.id.should == 5273
  end
end
