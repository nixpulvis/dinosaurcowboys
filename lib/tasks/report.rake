desc 'Dump out a report for the site.'
task report: :environment do
  puts 'Users'
  puts '-----'
  puts "Total Count: #{User.count}"
  puts "Last 7 Days Count: #{User.where('created_at > ?', 1.week.ago).count}"
  print "\n"

  puts 'Applications'
  puts '------------'
  puts "Total Applications: #{Application.count}"
  puts "Pending Applications: #{Application.pendings.count}"
  puts "Trial Applications: #{Application.trials.count}"
  puts "Accepted Applications: #{Application.accepteds.count}"
  puts "Rejected Applications: #{Application.rejecteds.count}"
  print "\n"

  puts 'Posts'
  puts '-----'
  puts "Total Count: #{Post.count}"
  puts "Last 7 Days Count: #{Post.where('created_at > ?', 1.week.ago).count}"
  Post.group(:postable_type).count.each do |postable_type, count|
    puts "#{postable_type} Posts Count: #{count}"
  end
  print "\n"

  puts 'Uploads'
  puts '-------'
  puts "Count: #{Upload.count}"
  puts "Avatars Count: #{User.pluck(:avatar_id).compact.uniq.size}"
end
