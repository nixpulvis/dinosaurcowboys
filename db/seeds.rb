[
  "Guild Master",
  "Officer",
  "Loot Council",
  "Raider",
  "Trial",
  "Friend"
].each do |rank|
  Rank.find_or_create_by(:name => rank)
end
