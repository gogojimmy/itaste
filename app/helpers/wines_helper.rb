#encoding: utf-8
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

  def set_feature_link(photo)
    content_tag(:span, class: 'pull-left', id: "set-feature-#{photo.id}") do
      link_to "設定為特色圖片", photo_set_feature_path(photo), method: :put, remote: true
    end
  end

end
