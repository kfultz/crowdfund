require_relative 'project'
require_relative 'pledge_pool'

describe Project do
	
	before do
		@target_fund = 400
		@fund = 150
		@project = Project.new("Awesome", @fund, @target_fund)
	end
	
	it "has a target funding amount" do
		@project.target_fund.should == 400
	end
	
	it "has a string representation" do
		@project.to_s.should == "Project Awesome has $150.00 towards a goal of $400.00."
	end
	
	it "computes the total funding outstanding as the target funding minus the funding amount" do
		@project.still_needed.should == 400- 150
	end
	
	it "increases funds by 25 when funds are added" do
		@project.donate 
		@project.fund.should == @fund + 25
	end
	
	it "decreases funds by 15 when funds are removed" do
		@project.revoke
		@project.fund.should == @fund - 15
	end
	
	it "computes project pledges as the sum of all pledges received" do
		@project.pledges.should == 0
		
		@project.received_pledge(Pledge.new(:gold, 200))
		@project.pledges.should == 200
		
		@project.received_pledge(Pledge.new(:silver, 100))
		@project.pledges.should == 300
		
		@project.received_pledge(Pledge.new(:bronze, 50))
		@project.pledges.should == 350
	end
	
	context "created with a default funding amount" do
		before do
			@project = Project.new("Awesome")
		end
		
		it "has a default funding amount of 0" do
			@project.fund.should == 0
		end
	end
	
	context "with a funding level equal to its target level" do
		before do
			@project = Project.new("Success", 400, 400)
		end
		
		it "is a successful project" do
			@project.should be_success
		end
	end
	
	context "with a funding level lower than its target level" do
		before do
			@project = Project.new("Flop", 100, 400)
		end
		
		it "is a flop" do
			@project.should_not be_success
		end
	end
end