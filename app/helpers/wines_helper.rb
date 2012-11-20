module WinesHelper

  def collection_for_suggested_glass
    Wine::GLASS_TYPE.map { |value|
      [t(value, scope: 'activerecord.options.suggested_glasses'), value]
    }
  end

  def collection_for_wine_type
    Wine::WINE_TYPE.map { |value|
      [t(value, scope: 'activerecord.options.wine_types'), value]
    }
  end

end
