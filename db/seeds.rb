Rank::DEFAULTS.each do |rank|
  Rank.find_or_create_by(:name => rank)
end
