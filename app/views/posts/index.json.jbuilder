json.array!(@posts) do |post|
  json.extract! post, :id, :description, :address, :latitude, :longitude
  json.url post_url(post, format: :json)
end
