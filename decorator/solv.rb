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

class CurrentTicket < Ticket

	def ticket_information
		"Baggage weight: #{@baggage}, refund percent: #{@refund}, ticket price: #{@price}"
	end
end


#Decorator 0
class Decorator < Ticket
	attr_accessor :ticket

	def initialize(ticket)
		@ticket = ticket
	end

	def ticket_information
		@ticket.ticket_information
	end
end

#Decorator 1
class AdditionalBaggage < Decorator

	def change_data
		@ticket.baggage = 3.0*@ticket.baggage
		@ticket.price = 1.5*@ticket.price
	end

	def ticket_information
		change_data
		"Additional Baggage. " + @ticket.ticket_information
	end
end

#Decorator 2
class AdditionalPercentRefund < Decorator

	def change_data
		@ticket.price = 2.0*@ticket.price
	end

	def ticket_information
		change_data
		"Add Refund. " + @ticket.ticket_information
	end
end

def main
	ticket = CurrentTicket.new(20,0,1500)

	tick_bagg = AdditionalBaggage.new(ticket)

	tick_bagg_next = AdditionalPercentRefund.new(tick_bagg)
	
	puts tick_bagg_next.ticket_information

	
end


main