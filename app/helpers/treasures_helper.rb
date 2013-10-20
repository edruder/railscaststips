module TreasuresHelper
  def available_tags
    ActsAsTaggableOn::Tag.all.map { |t| t.name }
  end

  def tags_for_treasure treasure = @treasure
    content_tag :ul, class: 'tagcloud-list' do
      treasure.tag_list.collect { |tag| concat(content_tag :li, link_for_tag(tag)) }
    end
  end

  def found_at time
    time.strftime "%M:%S"
  end

  def railscast_display_name railscast
    "#{railscast.position} - #{railscast.name}"
  end

  def get_message_for_search search
    text = case search.type
           when :search_all
             nil
           when :by_query
             warning_for "Showing results for query #{bold(search.search_term)}"
           when :by_tag
             warning_for "Showing results for tag #{bold(search.search_term)}"
           when :suggested
             error_for("Sorry! We can not find results for your search '#{bold(search.failed_search_term)}'.") +
             warning_for("Please " + link_to_new_tip + " or try with a different search, for example, these are the results for '#{bold(search.search_term)}'")
           else
             waring_for "Showing results for '#{search.search_term}'"
           end
    text
  end

  def bold text
    content_tag(:b, text).html_safe
  end

  def warning_for(text)
    content_tag :div, text.html_safe, class: 'bs-callout bs-callout-warning'
  end

  def error_for(text)
    content_tag :div, text.html_safe, class: 'alert alert-danger'
  end

  def link_to_new_tip
    link_to('add a New Tip', new_treasure_path)
  end
end
