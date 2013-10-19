class HomeController < ApplicationController
  def index
    @treasures = [Treasure.all.sample, Treasure.all.sample, Treasure.all.sample]
  end

  def tweets
    @tweets = Twitter.search("from:logicalbricks", count: 2, result_type: "recent").results
    render json: @tweets[0..1]
  end
end
