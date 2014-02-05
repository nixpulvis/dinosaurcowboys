class CreateRecruitmentClasses < ActiveRecord::Migration
  def change
    create_table :recruitment_classes do |t|
      t.string :class_name
      t.text :desires

      t.timestamps
    end
  end
end
