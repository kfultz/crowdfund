Pledge = Struct.new(:name, :value)

module PledgePool
	PLEDGES = [
		Pledge.new(:gold, 200),
		Pledge.new(:silver, 100),
		Pledge.new(:bronze, 50),
	]
	
	def self.random  #module methods must be defined on self
		PLEDGES.sample
	end
end