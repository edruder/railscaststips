class HomeController < ApplicationController
  def index
    @treasures = [Treasure.most_voted, Treasure.most_tagged, Treasure.most_recent]
  end

  def about
  end

  def tweets
    @tweets = Twitter.search("from:logicalbricks", count: 2, result_type: "recent").results
    render json: @tweets[0..1]
  end
end
