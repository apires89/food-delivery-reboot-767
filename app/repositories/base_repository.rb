require 'csv'
class BaseRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @elements = []
    @next_id = 1
    load_csv if File.exist?(@csv_file)
  end

  def all
    @elements
  end

  def create(element)
    element.id = @next_id
    @elements << element
    @next_id += 1
    save_csv
  end



  private

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      #convert some rows to integer
      #create new element with row with updated values and push it to array
      @elements << convert_row(row)
    end
    @next_id = @elements.last.id + 1
  end

  def save_csv
    csv_options = {col_sep: ',', force_quotes: true, quote_char: '"'}
    CSV.open(@csv_file, "wb", csv_options) do |csv|
      csv << headers
      @elements.each do |element|
        csv << save_row(element)
      end
    end

  end



end
