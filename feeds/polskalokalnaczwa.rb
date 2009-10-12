class Polskalokalnaczwa < Feed

  def encoding
    @encoding ||= @doc.css("meta [http-equiv='Content-Type']").first[:content].split("charset=")[1]
  end

  def description
    @description ||= @doc.css("meta [name='Description']").first[:content]
  end

  def link
    "http://polskalokalna.pl/wiadomosci/slaskie/czestochowa"
    # "czestochowa.html"
  end

  def items
    @items ||= parse_items(@doc.css("#mainContent li.lead"))
  end

  class Item < Feed::Item
    def title
      @title ||= @doc_item.css("strong").first.content
    end

    def link
      @link ||= File.join("http://polskalokalna.pl", @doc_item.css("a").first[:href])
    end

    def description
      @description ||= @doc_item.css("span.lead").first.content
    end

    def guid
      link
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
