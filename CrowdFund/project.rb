require_relative 'pledge_pool'

class Project

attr_reader :fund, :target_fund
attr_accessor :name

def initialize(name, fund=0, target_fund=400)
  @name = name.capitalize
  @fund = fund
  @target_fund = target_fund
  @received_pledges = Hash.new(0)
end

def to_s
  "Project #{@name} has $#{'%.2f' % @fund} towards a goal of $#{'%.2f' % @target_fund}."
end

def still_needed
	@target_fund - @fund
end

def donate
  @fund += 25
  puts "Project #{@name} received a generous donation!"
 end

def revoke
  @fund -= 15
  puts "Project #{@name} pissed someone off, and they revoked their donation."
end

def received_pledge(pledge)
	@received_pledges[pledge.name] += pledge.value
	puts "#{@name} project received a #{pledge.name} pledge worth $#{pledge.value}!"
	puts "#{@name}'s pledges: #{@received_pledges}"
	@fund += pledge.value
end

def pledges
	@received_pledges.values.reduce(0, :+)   #I'm not sure what the :+ does
end

def success?
	return true if @fund >= @target_fund
	return false if @fund < @target_fund
end

end