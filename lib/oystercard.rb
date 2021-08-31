class OysterCard
    attr_reader :balance
    attr_accessor :in_journey
    LIMIT = 90

    def initialize()
        @balance = 0
        @in_journey = false
    end

    def add_funds(money)
        raise "Card balance cannot exceed #{LIMIT}" if balance + money > LIMIT
        @balance += money
    end

    def deducts(money)
        @balance -= money
    end

    # def in_journey?
    #   @in_journey = false
    # end

    def touch_in
      @in_journey = true
    end

end