require "test_helper"

class GenerateCsvJobTest < ActiveJob::TestCase
  # test "the truth" do
  #   assert true
  # end
  #
  def perform(records, index_view)
    csv_data = index_view.generate_csv(records)
    filename = Rails.root.join("tmp", "export_#{index_view.name}_#{Time.now.to_i}.csv")
    File.write(filename, csv_data)
  end
end
