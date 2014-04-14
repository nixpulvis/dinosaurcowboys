namespace :characters do
  desc 'Sync all characters'
  task sync: :environment do
    Character.all.each do |character|
      begin
        character.sync!
        puts "SYNC #{character}"
      rescue
        puts "ERROR #{character}"
      end
    end
  end
end
