Rank::DEFAULTS.each do |rank|
  Rank.find_or_create_by(name: rank)
end

RecruitmentClass::DEFAULTS.each do |klass, specs|
  unless RecruitmentClass.exists?(class_name: klass)
    desires = Hash[specs.map { |s| [s, ""] }]
    RecruitmentClass.create(class_name: klass, desires: desires)
  end
end

Feature.find_or_create_by(title: 'Welcome to Party Shark', body: <<-EOF)
We are a 2 day a week 25 man raiding guild.
EOF