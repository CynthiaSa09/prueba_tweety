json.extract! tweet, :id, :content, :image, :likes, :created_at, :updated_at
json.url tweet_url(tweet, format: :json)
