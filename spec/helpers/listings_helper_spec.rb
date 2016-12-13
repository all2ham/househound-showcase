require 'rails_helper'

describe ListingsHelper do
  context "tooltip time until expiry" do
    it "should return seconds" do
      expect(helper.expiry_tooltip(Time.now + 2)).to eq("Expires in 1 second(s).")

    end
    it "should return minutes" do
      expect(helper.expiry_tooltip(Time.now + 62)).to eq("Expires in 1 minute(s).")
    end
    it "should return hours and minutes" do
      expect(helper.expiry_tooltip(Time.now + 3602)).to eq("Expires in 1 hour(s) and 0 minute(s).")
    end
    it "should return days" do
      expect(helper.expiry_tooltip(Time.now + 60*60*24+2)).to eq("Expires in 1 day(s).")
    end
    it "should return weeks" do
      expect(helper.expiry_tooltip(Time.now + 60*60*24*7+2)).to eq("Expires in 1 week(s).")
    end
  end

end
