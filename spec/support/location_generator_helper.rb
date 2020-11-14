# frozen_string_literal: true

require 'csv'
module LocationGeneratorHelper
  module_function

  extend ActionDispatch::TestProcess

  def table
    file_path = Rails.root.join('spec', 'factories', 'files', 'locations.csv')
    csv_text = File.read(file_path)
    CSV.parse(csv_text, headers: true)
  end

  def clean_data(row)
    item = row.to_hash
    item['latitude'].to_f
    item['longitude'].to_f
    item
  end

  def random_location
    nb_items = table.length - 1
    index = Random.rand(0..nb_items)
    clean_data(table[index])
  end

  def select_location(index)
    clean_data(table[index])
  end
end
