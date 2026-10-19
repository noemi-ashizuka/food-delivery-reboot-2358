require "csv"

class CustomerRepository
  def initialize(filepath)
    @filepath = filepath
    @customers = []
    @next_id = 1
    load_csv if File.exist?(@filepath)
  end

  def all
    @customers
  end

  def create(customer)
    customer.id = @next_id
    @customers << customer
    @next_id += 1
    save_csv
  end

  private

  def load_csv
    CSV.foreach(@filepath, headers: :first_row, header_converters: :symbol) do |row|
      row[:id] = row[:id].to_i
      customer = Customer.new(row)
      @customers << customer
    end
    @next_id = @customers.last.id + 1 unless @customers.empty? 
  end

  def save_csv
    CSV.open(@filepath, "wb") do |csv|
      csv << ["id", "name", "address"]
      @customers.each do |customer|
        csv << [customer.id, customer.name, customer.address]
      end
    end
  end
end
