namespace :characters do
  desc 'Sync all characters'
  task sync: :environment do
    characters = Character.where(main: true).select do |character|
      character.user.rank.try(:>=, 'Trial')
    end

    characters.each do |character|
      begin
        character.sync
        character.save
        puts "SYNC #{character}"
      rescue
        puts "ERROR #{character}"
      end
    end
  end
end
