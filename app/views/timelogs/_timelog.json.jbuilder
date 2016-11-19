json.extract! timelog, :id, :created_at, :updated_at
json.url timelog_url(timelog, format: :json)