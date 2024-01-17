class BasketHandler
  class << self
    def scan(product_code)
      puts "Scanning product with code #{product_code}"
    end

    def compute_total
      puts "Computing total"
    end

    def clear
      puts "Clearing basket"
    end

    def show
      puts "Showing basket"
    end
  end
end
