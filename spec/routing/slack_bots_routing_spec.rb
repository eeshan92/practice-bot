require "rails_helper"

RSpec.describe SlackBotsController, type: :routing do
  describe "routing" do

    it "routes to #callback" do
      expect(:get => "/slack_bots/callback").to route_to("slack_bots#callback")
    end

    it "routes to #new" do
      expect(:get => "/slack_bots/authorize").to route_to("slack_bots#authorize")
    end
  end
end
