require 'spec_helper'

describe TreasuresController do

  # This should return the minimal set of attributes required to create a valid
  # Treasure. As you add validations to Treasure, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "description" => "MyText", "time" => Time.now } }
  

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TreasuresController. Be sure to keep this updated too.
  let(:valid_session) { {} }

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
        # Trigger the behavior that occurs when invalid params are submitted
        Treasure.any_instance.stub(:save).and_return(false)
        post :create, {:treasure => { "description" => "invalid value" }}, valid_session
        assigns(:treasure).should be_a_new(Treasure)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
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
        # Assuming there are no other treasures in the database, this
        # specifies that the Treasure created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
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
        # Trigger the behavior that occurs when invalid params are submitted
        Treasure.any_instance.stub(:save).and_return(false)
        put :update, {:id => treasure.to_param, :treasure => { "description" => "invalid value" }}, valid_session
        assigns(:treasure).should eq(treasure)
      end

      it "re-renders the 'edit' template" do
        treasure = Treasure.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
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
