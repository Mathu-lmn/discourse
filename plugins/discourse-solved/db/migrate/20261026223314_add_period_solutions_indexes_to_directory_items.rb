# frozen_string_literal: true
class AddPeriodSolutionsIndexesToDirectoryItems < ActiveRecord::Migration[8.1]
  disable_ddl_transaction!

  ASC_INDEX_NAME = "index_directory_items_on_period_solutions_asc"
  DESC_INDEX_NAME = "index_directory_items_on_period_solutions_desc"

  # The directory sorts with `solutions <dir>, id ASC`, so each direction needs its own index.
  def up
    remove_index :directory_items, name: ASC_INDEX_NAME, algorithm: :concurrently, if_exists: true
    add_index :directory_items,
              %i[period_type solutions id],
              name: ASC_INDEX_NAME,
              algorithm: :concurrently

    remove_index :directory_items, name: DESC_INDEX_NAME, algorithm: :concurrently, if_exists: true
    add_index :directory_items,
              %i[period_type solutions id],
              order: {
                solutions: :desc,
              },
              name: DESC_INDEX_NAME,
              algorithm: :concurrently
  end

  def down
    remove_index :directory_items, name: ASC_INDEX_NAME, algorithm: :concurrently, if_exists: true
    remove_index :directory_items, name: DESC_INDEX_NAME, algorithm: :concurrently, if_exists: true
  end
end
