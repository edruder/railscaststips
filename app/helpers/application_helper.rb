module ApplicationHelper
  def tag_cloud
    tags = Treasure.tag_counts_on(:tags).limit(15)
    content_tag :ul, class: 'tagcloud-list' do
      tags.collect { |tag| concat(content_tag :li, link_for_tag(tag)) }
    end
  end

  def link_for_tag tag
    link_to tag, "/tags/#{tag}"
  end

  def external_url_for_treasure treasure
    File.join(
      'http://',
      request.host_with_port,
      treasure_path(treasure)
    )
  end
  
  def twitter_url_from_treasure treasure
    base_url = 'https://twitter.com/share?'
    params = { url: external_url_for_treasure(treasure), via: 'railscaststips', text: "I've learned new rails tricks from #{external_url_for_treasure(treasure)}" }
    base_url + params.to_query
  end

  def menu_item(text, url_link, css_class=nil)
    css_class ||= css_class_for_url(url_link)
    content_tag :li, class: css_class do
      link_to text, url_link
    end
  end

  def css_class_for_url(url_link)
    url_link == request.fullpath ? 'active' : ''
  end
end
