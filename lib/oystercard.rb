class OysterCard
    attr_reader :balance, :stations
    attr_accessor :in_journey
    LIMIT = 90
    MINIMUM_CHARGE = 1

    def initialize()
        @balance = 0
        @in_journey = false
    
    end

    def add_funds(money)
        raise "Card balance cannot exceed #{LIMIT}" if balance + money > LIMIT
        @balance += money
    end

    def touch_in(station)
        raise "Balance must be greater than 1" if balance < MINIMUM_CHARGE
        @stations = station
        @in_journey = true
    end

    def touch_out
      deducts(MINIMUM_CHARGE)
      @in_journey = false
      @stations = nil
    end

    def in_journey?
      !!stations
    end

    private 
    
    def deducts(money)
      @balance -= money
    end

end