class HomeController < ApplicationController
  def index
  end

  def tweets
    @tweets = Twitter.search("from:logicalbricks", count: 2, result_type: "recent").results
    render json: @tweets[0..1]
  end
end
