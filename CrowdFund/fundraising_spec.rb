require_relative 'fundraising'

describe Fundraising do

	before do
		@category = Fundraising.new("Awesome projects")
		
		@fund = 100
		@target_fund = 400
		@project = Project.new("Greatness", @fund, @target_fund)
		
		@category.add_project(@project)
	end
	
	it "donates money when an even number is rolled" do
		Die.any_instance.stub(:roll).and_return(4)
		@category.beg(2)
		@project.fund.should == @fund + (25*2)
	end
	
	it "revokes funding from a project when an odd number is rolled" do
		Die.any_instance.stub(:roll).and_return(3)
		@category.beg(2)
		@project.fund.should == @fund - (15*2)
	end
	
	it "gives a pledge during each fundraising round" do
		category = Fundraising.new("awesome projects")
		project = Project.new("greatness")
		
		category.add_project(project)
		
		category.beg(1)
		
		category.pledges.should_not be_zero
	end
	
end