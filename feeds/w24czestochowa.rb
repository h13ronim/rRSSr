class W24czestochowa < Feed

  def encoding
    @encoding ||= @doc.css("meta [http-equiv='Content-Type']").first[:content].split("charset=")[1]
  end

  def title
    super.gsub("Tag: ", "")
  end

  def description
    @description ||= @doc.css("meta [name='Description']").first[:content]
  end

  def link
    "http://www.wiadomosci24.pl/tag/Czestochowa-czzat_d-1.html"
    # "Czestochowa-czzat_d-1.html"
  end

  def items
    @items ||= parse_items(@doc.css("#kontent #kontent-glowny #k1 .zajawka"))
  end

  class Item < Feed::Item
    def title
      @title ||= @doc_item.css("h2.artTytul a").first.content.strip
    end

    def link
      @link ||= File.join("http://www.wiadomosci24.pl", @doc_item.css("h2.artTytul a").first[:href].split("?")[0])
    end

    def description
      # TODO Problem with encoding.
      # @description ||= [
      #   @doc_item.css("a img"),
      #   @doc_item.css("p").first.content.strip
      # ].join
      @description ||= @doc_item.css("p").first.content.strip
    end

    def pub_date
      @pub_date ||= Time.parse(@doc_item.css("span.data").first.content.split("aktualizacja: ")[1])
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
