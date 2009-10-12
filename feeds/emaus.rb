class Emaus < Feed

  def title
    super.gsub("Strona główna - ", "")
  end

  def description
    "Personalna Parafia Akademicka Pw. Św. Ireneusza BM"
  end

  def link
    "http://www.emaus.czest.pl/"
    # "index.html"
  end

  def items
    @items ||= parse_items(@doc.css("#newsItem"))
  end

  class Item < Feed::Item
    def title
      @title ||= @doc_item.css("h3").first.content
    end

    def link
      "http://www.emaus.czest.pl/"
    end

    def description
      @description ||= @doc_item.css("div.contenttxt").first.content.strip
    end

    def pub_date
      false
    end

    def guid
      ["http://www.emaus.czest.pl/#", @doc_item.css("a.likebutton").first[:id]].join
    end

  end

  private
    # TODO. Refactor to one line ;)
    def parse_items(doc_items)
      parsed_items = []
      doc_items.each do |doc_item|
        parsed_items << Item.new(doc_item)
      end
      parsed_items
    end

end
