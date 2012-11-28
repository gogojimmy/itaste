class WineCell < Cell::Rails

  def recent_feeds
    @feeds = Wine.where(complete: true).last(8)
    render
  end

  def wine_vertical_componet(wine)
    @vertical_component = wine
    render
  end

  def wine_horizontal_component(wine)
    @horizontal_component = wine
    render
  end

  def horizontal_collection(collection, title)
    @horizontal_collection = collection
    @horizontal_collection_title = title
    render
  end

  def vertical_collection(collection, title)
    @vertical_collection = collection
    @vertical_collection_title = title
    render
  end

end
