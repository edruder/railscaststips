class TreasuresController < ApplicationController
  before_filter :logged_user, only: [:create, :update, :new, :edit]
  before_action :set_treasure, only: [:show, :edit, :update, :destroy]
  before_action :load_railscasts, only: [:new, :create, :edit, :update]

  # GET /treasures
  # GET /treasures.json
  def index
    @treasures = load_treasures
  end

  # POST /treasures/1/vote
  def vote
    vote = current_user.treasure_votes.new(value: params[:value], treasure_id: params[:id])
    if vote.save
      redirect_to :back, notice: "Your vote was registered successfully."
    else
      redirect_to :back, alert: "Could not save your vote, maybe you already voted."
    end
  end

  # GET /treasures/1
  # GET /treasures/1.json
  def show
  end

  # GET /treasures/new
  def new
    @treasure = Treasure.new
    @treasure.railscast = Railscast.find_by_id(params[:railscast_id]) if params[:railscast_id]
  end

  # GET /treasures/1/edit
  def edit
  end

  # POST /treasures
  # POST /treasures.json
  def create
    @treasure = Treasure.new(treasure_params)

    respond_to do |format|
      if @treasure.save
        format.html { redirect_to @treasure, notice: 'Treasure was successfully created.' }
        format.json { render action: 'show', status: :created, location: @treasure }
      else
        format.html { render action: 'new' }
        format.json { render json: @treasure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /treasures/1
  # PATCH/PUT /treasures/1.json
  def update
    respond_to do |format|
      if @treasure.update(treasure_params)
        format.html { redirect_to @treasure, notice: 'Treasure was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @treasure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /treasures/1
  # DELETE /treasures/1.json
  def destroy
    @treasure.destroy
    respond_to do |format|
      format.html { redirect_to treasures_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_treasure
      @treasure = Treasure.find(params[:id])
    end

    def load_railscasts
      @railscasts = Railscast.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def treasure_params
      params.require(:treasure).permit(:description, :railscast_id, :time, :tag_list)
    end

    def suggested_treasures
      Treasure.all
    end

    def load_treasures
      if params[:query]
        Treasure.search params[:query]
      elsif params[:tag]
        Treasure.tagged_with params[:tag]
      else
        suggested_treasures
      end
    end
end
