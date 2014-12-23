json.array!(@developments) do |development|
  json.extract! development, :id, :level, :bonus, :point, :diamond, :sapphire, :emerald, :ruby, :onyx
  json.url development_url(development, format: :json)
end
