class Region < ActiveRecord::Base
  attr_accessible :name, :parent_id
  has_many :wines
  has_many :producers
  has_many :grape_region_ships
  has_many :grapes, through: :grape_region_ships

  scope :root_only, where('parent_id is null').includes(:children)

  def self.get_all_ids(id)
    self.select("id").find(id).children.pluck("id") << id
  end

  module FindByRegionScope
    def by_region(region_id=nil)
      (region_id.present?)? where( :region_id => Region.get_all_ids(region_id) ) : scoped
    end
  end

end
