class Ticket
  attr_accessor :baggage
  attr_accessor :refund
  attr_accessor :price

  def initialize(baggage, refund, price)
    @baggage = baggage
    @refund = refund
    @price = price
  end

  def ticket_information
    "Baggage weight: #{@baggage}, refund percent: #{@refund}, ticket price: #{@price}"
  end

end

#Decorator 0
class Decorator
  attr_accessor :ticket

  def initialize(ticket)
    @ticket = ticket
  end

  def ticket_information
    @ticket.ticket_information
  end

  def method_missing(method, *args)
    if @ticket.respond_to?(method)
      @ticket.send(method, *args)
    else
      super
    end
  end

  def respond_to?(method)
    @ticket.respond_to?(method)
  end

end

#Decorator 1
class AdditionalBaggage < Decorator
  def ticket_information
      @ticket.baggage = 2.5*@ticket.baggage
      @ticket.price = 1.5*@ticket.price
      "Additional Baggage. " + @ticket.ticket_information
  end
end

#Decorator 2
class AdditionalPercentRefund < Decorator
  def ticket_information
    if @ticket.refund < 50
      @ticket.refund += 10
      "Additional Refund. " + @ticket.ticket_information
    else
      @ticket.ticket_information
    end
  end

end


def main
  ticket = Ticket.new(10,0,500)

  ticket_with_baggage = AdditionalBaggage.new(ticket)

  ticket_with_baggage_refund = AdditionalPercentRefund.new(ticket_with_baggage)

  puts ticket_with_baggage_refund.ticket_information

end


main