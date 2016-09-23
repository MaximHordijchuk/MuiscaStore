json.extract! product, :id, :article, :name, :price, :category_id, :created_at, :updated_at
json.url product_url(product, format: :json)