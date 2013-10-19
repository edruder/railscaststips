class HomeController < ApplicationController
  def index
    @treasures = [Treasure.all.sample, Treasure.all.sample, Treasure.all.sample]
  end
end
