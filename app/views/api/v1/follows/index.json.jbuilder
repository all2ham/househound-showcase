json.listings do
  json.partial! 'api/v1/listings/listing', collection: @listings, as: :listing
end
