Rank::DEFAULTS.each do |rank|
  Rank.find_or_create_by(name: rank)
end

RecruitmentClass::DEFAULTS.each do |klass, specs|
  unless RecruitmentClass.exists?(class_name: klass)
    desires = Hash[specs.map { |s| [s, ""] }]
    RecruitmentClass.create(class_name: klass, desires: desires)
  end
end
