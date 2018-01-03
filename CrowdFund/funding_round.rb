require_relative 'die'
require_relative 'project'
require_relative 'pledge_pool'

module FundingRound

	def self.take_turn(project)  #module methods must be defined on the module itself, so you must include self. before the method name
		die = Die.new
		number_rolled = die.roll
			if number_rolled %2 == 0 
				project.donate
			else number_rolled %2 != 0 
				project.revoke
			end
		pledge = PledgePool.random
		project.received_pledge(pledge)
		puts project
	end
end