class Feed

  attr_accessor :doc

  def initialize
    @doc ||= Nokogiri::HTML(open(link))
  end

  def encoding
    "utf-8"
  end

  def title
    @title ||= @doc.css("title").first.content.strip
  end

  def description
    raise "Not implemented!"
  end

  def link
    raise "Not implemented!"
  end

  def items
    raise "Not implemented!"
  end

  class Item

    attr_accessor :doc_item

    def initialize(doc_item)
      @doc_item ||= doc_item
    end

    def title
      raise "Not implemented!"
    end

    def link
      raise "Not implemented!"
    end

    def description
      raise "Not implemented!"
    end

    def pub_date
      false
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
        parsed_items << ::Item.new(doc_item)
      end
      parsed_items
    end

end
