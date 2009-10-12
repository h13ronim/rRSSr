xml.instruct! :xml, :version => '1.0', :encoding => @feed.encoding
xml.rss :version => "2.0" do
  xml.channel do
    xml.title @feed.title
    xml.description @feed.description
    xml.link @feed.link
    @feed.items.each do |item|
      xml.item do
        xml.title item.title
        xml.link item.link
        xml.description item.description
        xml.pubDate Time.parse(item.pub_date.to_s).rfc822() if item.pub_date
        xml.guid item.guid
      end
    end
  end
end
