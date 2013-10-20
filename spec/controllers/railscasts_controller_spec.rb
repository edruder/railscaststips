require 'spec_helper'

describe RailscastsController do

  let(:valid_attributes) {
    {
      url: "http://railscasts.com/episodes/1-caching-with-instance-variables.html",
      name: "Caching with Instance Variables",
      description: "Learn a quick way to improve performance. Just store the end result of an expensive command in an instance variable!",
      pro: '1',
      revised: '0',
      position: 1,
      duration: '0:14:21',
      permalink: 'caching-with-instance-variables'
    }
  }

  let(:valid_session) { { } }
  describe "GET index" do
    it "assigns all railscasts as @railscasts" do
      railscast = Railscast.create! valid_attributes
      get :index, {}, valid_session
      assigns(:railscasts).should eq([railscast])
    end
  end

  describe "GET show" do
    it "assigns the requested railscast as @railscast" do
      railscast = Railscast.create! valid_attributes
      get :show, {:id => railscast.to_param}, valid_session
      assigns(:railscast).should eq(railscast)
    end
  end

  describe "GET new" do
    it "assigns a new railscast as @railscast" do
      get :new, {}, valid_session
      assigns(:railscast).should be_a_new(Railscast)
    end
  end

  describe "GET edit" do
    it "assigns the requested railscast as @railscast" do
      railscast = Railscast.create! valid_attributes
      get :edit, {:id => railscast.to_param}, valid_session
      assigns(:railscast).should eq(railscast)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Railscast" do
        expect {
          post :create, {:railscast => valid_attributes}, valid_session
        }.to change(Railscast, :count).by(1)
      end

      it "assigns a newly created railscast as @railscast" do
        post :create, {:railscast => valid_attributes}, valid_session
        assigns(:railscast).should be_a(Railscast)
        assigns(:railscast).should be_persisted
      end

      it "redirects to the created railscast" do
        post :create, {:railscast => valid_attributes}, valid_session
        response.should redirect_to(Railscast.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved railscast as @railscast" do
        # Trigger the behavior that occurs when invalid params are submitted
        Railscast.any_instance.stub(:save).and_return(false)
        post :create, {:railscast => { "url" => "invalid value" }}, valid_session
        assigns(:railscast).should be_a_new(Railscast)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Railscast.any_instance.stub(:save).and_return(false)
        post :create, {:railscast => { "url" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested railscast" do
        railscast = Railscast.create! valid_attributes
        # Assuming there are no other railscasts in the database, this
        # specifies that the Railscast created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Railscast.any_instance.should_receive(:update).with({ "url" => "MyString" })
        put :update, {:id => railscast.to_param, :railscast => { "url" => "MyString" }}, valid_session
      end

      it "assigns the requested railscast as @railscast" do
        railscast = Railscast.create! valid_attributes
        put :update, {:id => railscast.to_param, :railscast => valid_attributes}, valid_session
        assigns(:railscast).should eq(railscast)
      end

      it "redirects to the railscast" do
        railscast = Railscast.create! valid_attributes
        put :update, {:id => railscast.to_param, :railscast => valid_attributes}, valid_session
        response.should redirect_to(railscast)
      end
    end

    describe "with invalid params" do
      it "assigns the railscast as @railscast" do
        railscast = Railscast.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Railscast.any_instance.stub(:save).and_return(false)
        put :update, {:id => railscast.to_param, :railscast => { "url" => "invalid value" }}, valid_session
        assigns(:railscast).should eq(railscast)
      end

      it "re-renders the 'edit' template" do
        railscast = Railscast.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Railscast.any_instance.stub(:save).and_return(false)
        put :update, {:id => railscast.to_param, :railscast => { "url" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested railscast" do
      railscast = Railscast.create! valid_attributes
      expect {
        delete :destroy, {:id => railscast.to_param}, valid_session
      }.to change(Railscast, :count).by(-1)
    end

    it "redirects to the railscasts list" do
      railscast = Railscast.create! valid_attributes
      delete :destroy, {:id => railscast.to_param}, valid_session
      response.should redirect_to(railscasts_url)
    end
  end

end
