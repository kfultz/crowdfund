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

#displays project info as a string (called with 'puts project')
def to_s
  "Project #{@name} has $#{'%.2f' % @fund} towards a goal of $#{'%.2f' % @target_fund}."
end

#calculates how much funding the project still needs
def still_needed
	@target_fund - @fund
end

#method for when a project receives a donation
def donate
  @fund += 25
  puts "Project #{@name} received a generous donation!"
 end

 #method for when a project's donation is revoked
def revoke
  @fund -= 15
  puts "Project #{@name} pissed someone off, and they revoked their donation."
end

#adds pledge info to the project's pledge hash, calculates total value of pledges received, adds value to total funds received
def received_pledge(pledge)
	@received_pledges[pledge.name] += pledge.value
	puts "#{@name} project received a #{pledge.name} pledge worth $#{pledge.value}!"
	puts "#{@name}'s pledges: #{@received_pledges}"
	@fund += pledge.value
end

#I can't remember what this does :3 I think it totals the values of each of the pledges in the received_pledges hash and assigns them to a single key
def pledges
	@received_pledges.values.reduce(0, :+)   #I'm not sure what the :+ does
end

#this defines a method that iterates over the hash that contains the total value of each pledge and creates a new object (a Struct) with the same name and value as the key-value pairs in the hash
def each_pledge_received
	@received_pledges.each do |name, value|
		yield Pledge.new(name, value)
	end
end

#this defines whether or not a project is successful by comparing the current funding level with the target funding level
def success?
	return true if @fund >= @target_fund
	return false if @fund < @target_fund
end

end