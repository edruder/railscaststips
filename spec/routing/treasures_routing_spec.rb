require "spec_helper"

describe TreasuresController do
  describe "routing" do

    it "routes to #index" do
      get("/treasures").should route_to("treasures#index")
    end

    it "routes to #new" do
      get("/treasures/new").should route_to("treasures#new")
    end

    it "routes to #show" do
      get("/treasures/1").should route_to("treasures#show", :id => "1")
    end

    it "routes to #edit" do
      get("/treasures/1/edit").should route_to("treasures#edit", :id => "1")
    end

    it "routes to #create" do
      post("/treasures").should route_to("treasures#create")
    end

    it "routes to #update" do
      put("/treasures/1").should route_to("treasures#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/treasures/1").should route_to("treasures#destroy", :id => "1")
    end

  end
end
