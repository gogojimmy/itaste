class SitemapController < ApplicationController
  layout nil

  def index
    headers['Content-Type'] = 'application/xml'
    latest = Wine.last
    @wines = Wine.sitemap
    if stale?(:etag => latest, :last_modified => latest.updated_at.utc)
      respond_to do |format|
        format.xml { @wines }
      end
    end
  end
end
