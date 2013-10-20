require 'spec_helper'

describe TreasuresController do

  let(:railscast) { FactoryGirl.create :railscast }
  let(:valid_attributes) { { railscast_id: railscast.id, description: "MyText", time: '00:2:31' } }

  let(:valid_session) { { user_id: FactoryGirl.create(:user, guest: true)} }

  describe "GET index" do
    it "assigns all treasures as @treasures" do
      treasure = Treasure.create! valid_attributes
      get :index, {}, valid_session
      assigns(:treasures).should eq([treasure])
    end

    context 'with tag param' do
      before :each do
        @treasure_with_tag1 = FactoryGirl.create :treasure, tag_list: "tag1"
        FactoryGirl.create_list :treasure, 2, tag_list: "tag2, tag3"
        FactoryGirl.create_list :treasure, 2, tag_list: "tag3, tag4"
      end

      it 'should return treasures tagged as tag1' do
        get :index, { tag: "tag1"}, valid_session
        assigns(:treasures).should eq([@treasure_with_tag1])
      end
    end

    context 'with query param' do
      before :each do
        railscast = FactoryGirl.create :railscast, name: 'Some name', description: 'Some text'
        other_railscast = FactoryGirl.create :railscast
        FactoryGirl.create :treasure,
          description: "How to use => to preserve context in coffeescript function",
          tag_list: "coffeescript, javascript, rails",
          railscast: other_railscast
        FactoryGirl.create :treasure,
          description: "An awesome tip hidden inside railscast #343, it shows how to use full text search with text parameter",
          tag_list: "full text search, rails, postgresql",
          railscast: other_railscast
        FactoryGirl.create :treasure,
          description: "Railscast #371 has an interesting note about how to disable parameters in minute 03:45.",
          tag_list: "strong parameters, rails 4, ruby",
          railscast: railscast
        FactoryGirl.create :treasure,
          description: "Some weird description",
          tag_list: "tag1, tag2, 4",
          railscast: railscast
      end

      it 'should show 3 result for "rails"' do
        get :index, { query: "rails"}, valid_session
        assigns(:treasures).should have(3).items
      end

      it 'should show 4 result for "javascript"' do
        get :index, { query: "javascript"}, valid_session
        assigns(:treasures).should have(1).items
      end

      it 'should show 3 result for "how to use"' do
        get :index, { query: "how to use"}, valid_session
        assigns(:treasures).should have(2).items
      end

      it 'should show 1 result for "coffeescript"' do
        get :index, { query: "coffeescript"}, valid_session
        assigns(:treasures).should have(1).items
      end

      it 'should show 2 result for "parameters"' do
        get :index, { query: "parameters"}, valid_session
        assigns(:treasures).should have(2).items
      end

      it 'should show 2 result for "Fixture"' do
        get :index, { query: "Fixture"}, valid_session
        assigns(:treasures).should have(2).items
      end

      it 'should show 2 result for "description"' do
        get :index, { query: "description"}, valid_session
        assigns(:treasures).should have(3).items
      end

    end
  end

  describe 'POST vote' do
    before :each do
      @user = FactoryGirl.create :user
      railscast = FactoryGirl.create :railscast
      @treasure = FactoryGirl.create :treasure, railscast: railscast
      TreasuresController.any_instance.stub(:current_user).and_return(@user)
      # set for redirect_to :return
      request.env["HTTP_REFERER"] = treasure_path(@treasure)
    end

    it 'increments number of votes by one' do
      post :vote, value: 1, id: @treasure.id
      @treasure.reload.votes.should == 1
    end

    it 'decrements number of votes by one' do
      post :vote, value: -1, id: @treasure.id
      @treasure.votes.should == -1
    end
  end

  describe "GET show" do
    it "assigns the requested treasure as @treasure" do
      treasure = Treasure.create! valid_attributes
      get :show, {:id => treasure.to_param}, valid_session
      assigns(:treasure).should eq(treasure)
    end
  end

  describe "GET new" do
    it "assigns a new treasure as @treasure" do
      get :new, {}, valid_session
      assigns(:treasure).should be_a_new(Treasure)
    end
  end

  describe "GET edit" do
    it "assigns the requested treasure as @treasure" do
      treasure = Treasure.create! valid_attributes
      get :edit, {:id => treasure.to_param}, valid_session
      assigns(:treasure).should eq(treasure)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Treasure" do
        expect {
          post :create, {:treasure => valid_attributes}, valid_session
        }.to change(Treasure, :count).by(1)
      end

      it "assigns a newly created treasure as @treasure" do
        post :create, {:treasure => valid_attributes}, valid_session
        assigns(:treasure).should be_a(Treasure)
        assigns(:treasure).should be_persisted
      end

      it "redirects to the created treasure" do
        post :create, {:treasure => valid_attributes}, valid_session
        response.should redirect_to(Treasure.last)
      end

      context 'with tags' do
        it "creates a new Treasure with tags tag1, tag2, tag3" do
          post :create, { treasure: valid_attributes.merge( { tag_list: "tag1, tag2, tag3" } ) }, valid_session
          assigns(:treasure).should be_persisted
          assigns(:treasure).tag_list.should eq(["tag1", "tag2", "tag3"])
        end
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved treasure as @treasure" do
        Treasure.any_instance.stub(:save).and_return(false)
        post :create, {:treasure => { "description" => "invalid value" }}, valid_session
        assigns(:treasure).should be_a_new(Treasure)
      end

      it "re-renders the 'new' template" do
        Treasure.any_instance.stub(:save).and_return(false)
        post :create, {:treasure => { "description" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested treasure" do
        treasure = Treasure.create! valid_attributes
        Treasure.any_instance.should_receive(:update).with({ "description" => "MyText" })
        put :update, {:id => treasure.to_param, :treasure => { "description" => "MyText" }}, valid_session
      end

      it "assigns the requested treasure as @treasure" do
        treasure = Treasure.create! valid_attributes
        put :update, {:id => treasure.to_param, :treasure => valid_attributes}, valid_session
        assigns(:treasure).should eq(treasure)
      end

      it "redirects to the treasure" do
        treasure = Treasure.create! valid_attributes
        put :update, {:id => treasure.to_param, :treasure => valid_attributes}, valid_session
        response.should redirect_to(treasure)
      end
    end

    describe "with invalid params" do
      it "assigns the treasure as @treasure" do
        treasure = Treasure.create! valid_attributes
        Treasure.any_instance.stub(:save).and_return(false)
        put :update, {:id => treasure.to_param, :treasure => { "description" => "invalid value" }}, valid_session
        assigns(:treasure).should eq(treasure)
      end

      it "re-renders the 'edit' template" do
        treasure = Treasure.create! valid_attributes
        Treasure.any_instance.stub(:save).and_return(false)
        put :update, {:id => treasure.to_param, :treasure => { "description" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested treasure" do
      treasure = Treasure.create! valid_attributes
      expect {
        delete :destroy, {:id => treasure.to_param}, valid_session
      }.to change(Treasure, :count).by(-1)
    end

    it "redirects to the treasures list" do
      treasure = Treasure.create! valid_attributes
      delete :destroy, {:id => treasure.to_param}, valid_session
      response.should redirect_to(treasures_url)
    end
  end

end
