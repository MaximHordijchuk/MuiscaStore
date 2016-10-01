json.extract! order, :id, :name, :surname, :address, :phone, :card_no, :card_type, :expire_month, :expire_year, :user_id, :created_at, :updated_at
json.url order_url(order, format: :json)