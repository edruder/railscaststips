class RailscastsController < ApplicationController
  before_action :set_railscast, only: [:show, :edit, :update, :destroy]

  # GET /railscasts
  # GET /railscasts.json
  def index
    @railscasts = Railscast.all
  end

  # GET /railscasts/1
  # GET /railscasts/1.json
  def show
  end

  # GET /railscasts/new
  def new
    @railscast = Railscast.new
  end

  # GET /railscasts/1/edit
  def edit
  end

  # POST /railscasts
  # POST /railscasts.json
  def create
    @railscast = Railscast.new(railscast_params)

    respond_to do |format|
      if @railscast.save
        format.html { redirect_to @railscast, notice: 'Railscast was successfully created.' }
        format.json { render action: 'show', status: :created, location: @railscast }
      else
        format.html { render action: 'new' }
        format.json { render json: @railscast.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /railscasts/1
  # PATCH/PUT /railscasts/1.json
  def update
    respond_to do |format|
      if @railscast.update(railscast_params)
        format.html { redirect_to @railscast, notice: 'Railscast was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @railscast.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /railscasts/1
  # DELETE /railscasts/1.json
  def destroy
    @railscast.destroy
    respond_to do |format|
      format.html { redirect_to railscasts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_railscast
      @railscast = Railscast.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def railscast_params
      params.require(:railscast).permit(:url, :name, :description, :pro, :revised, :duration, :position, :permalink)
    end
end
