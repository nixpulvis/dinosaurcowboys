class SetPartTimeRankForums < ActiveRecord::Migration
  def change
    part_time = Rank.create(name: 'Part Time')
    raider = Rank.find_by_name('Raider')

    Forum.all.each do |forum|
      forum.readable_ranks << part_time if forum.readable_ranks.include?(raider)
      forum.writable_ranks << part_time if forum.writable_ranks.include?(raider)
    end
  end
end
