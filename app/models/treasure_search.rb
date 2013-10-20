class TreasureSearch
  attr_reader :result, :type, :search_term, :failed_search_term 

  def initialize(params)
    @result = load_treasures params
  end

  #########
  private
  ########

  def load_treasures params
    if params[:query]
      search_by_query_or_return_suggested params[:query]
    elsif params[:tag]
      @type = :by_tag
      search_by_tag params[:tag]
    else
      @type = :search_all
      Treasure.all
    end
  end

  def search_by_query_or_return_suggested query
    if query.blank? or ( result = Treasure.search(query) ).blank?
      @failed_search_term = query
      return suggested_treasures
    else
      @type = :by_query
      @search_term = query
      return result
    end
  end

  def search_by_tag tag
    @search_term = tag
    Treasure.tagged_with tag
  end

  def suggested_treasures
    tags = ActsAsTaggableOn::Tag
    random_tag = tags.offset(rand(tags.count)).first
    @type = :suggested
    search_by_tag random_tag
  end

end
