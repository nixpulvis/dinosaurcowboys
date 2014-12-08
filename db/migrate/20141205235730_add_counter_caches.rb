class AddCounterCaches < ActiveRecord::Migration
  def change
    add_count_cache Application, :posts
    add_count_cache Raid,        :posts
    add_count_cache Boss,        :posts
    add_count_cache Topic,       :posts
  end

  private

  def add_count_cache(klass, association)
    add_column klass.table_name, "#{association}_count", :integer, default: 0
    klass.reset_column_information
    klass.all.each { |i| klass.reset_counters(i.id, association) }
  end
end
