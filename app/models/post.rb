class Post < ActiveRecord::Base
	geocoded_by :address
	after_validation :geocode, :if => :address_changed?
	acts_as_gmappable :process_geocoding => false
end
