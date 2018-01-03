require_relative 'pledge_pool'

describe Pledge do
	before do
		@pledge = Pledge.new(:gold, 200)
	end
	
	it "has a name attribute" do
		@pledge.name.should == :gold
	end
	
	it "has a value attribute" do
		@pledge.value.should == 200
	end
end

describe PledgePool do
	it "has 3 pledge levels" do
		PledgePool::PLEDGES.size.should == 3
	end
	
	it "has a gold level worth $200" do
		PledgePool::PLEDGES[0].should == Pledge.new(:gold, 200)
	end
	
	it "has a silver level worth $100" do
		PledgePool::PLEDGES[1].should == Pledge.new(:silver, 100)
	end
	
	it "has a bronze level worth $50" do
		PledgePool::PLEDGES[2].should == Pledge.new(:bronze, 50)
	end
	
	it "returns a random pledge" do
		pledge = PledgePool.random
		PledgePool::PLEDGES.should include(pledge)
	end
end