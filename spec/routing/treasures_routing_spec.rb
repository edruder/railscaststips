require "spec_helper"

describe TreasuresController do
  describe "routing" do

    it "routes to #index" do
      get("/tips").should route_to("treasures#index")
    end

    it "routes to #new" do
      get("/tips/new").should route_to("treasures#new")
    end

    it "routes to #show" do
      get("/tips/1").should route_to("treasures#show", :id => "1")
    end

    it "routes to #edit" do
      get("/tips/1/edit").should route_to("treasures#edit", :id => "1")
    end

    it "routes to #create" do
      post("/tips").should route_to("treasures#create")
    end

    it "routes to #update" do
      put("/tips/1").should route_to("treasures#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/tips/1").should route_to("treasures#destroy", :id => "1")
    end

  end
end
