Rank::DEFAULTS.each do |rank|
  Rank.find_or_create_by(name: rank)
end

RecruitmentClass::CLASSES.each do |klass, specs|
  unless RecruitmentClass.exists?(class_name: klass)
    desires = Hash[specs.map { |s| [s, 0] }]
    RecruitmentClass.create(class_name: klass, desires: desires)
  end
end
