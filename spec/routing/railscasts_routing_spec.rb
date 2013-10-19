require "spec_helper"

describe RailscastsController do
  describe "routing" do

    it "routes to #index" do
      get("/railscasts").should route_to("railscasts#index")
    end

    it "routes to #new" do
      get("/railscasts/new").should route_to("railscasts#new")
    end

    it "routes to #show" do
      get("/railscasts/1").should route_to("railscasts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/railscasts/1/edit").should route_to("railscasts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/railscasts").should route_to("railscasts#create")
    end

    it "routes to #update" do
      put("/railscasts/1").should route_to("railscasts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/railscasts/1").should route_to("railscasts#destroy", :id => "1")
    end

  end
end
