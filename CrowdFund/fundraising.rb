require_relative 'project'
require_relative 'die'
require_relative 'funding_round'
require_relative 'pledge_pool'

class Fundraising

	def initialize(category)
		@category = category.capitalize
		@projects = []
	end

	#adds project to an array called @projects
	def add_project(a_project)
		@projects << a_project
	end

	#this method is what runs each project thru a fundraising cycle (begs for money). it takes a parameter equal to the number of rounds set in the crowdfund code
	def beg(rounds)
		
		#displays info from the projects array
		puts "There are #{@projects.size} projects in #{@category}:"
		@projects.each do |project|
			puts project
		end
		
		#displays info from the pledges array (about possible pledges to find)
		pledges = PledgePool::PLEDGES
		puts "\nThere are #{pledges.size} pledge options for especially generous donors:"
		pledges.each do |pledge|
			puts "A #{pledge.name} pledge is worth $#{pledge.value}."
		end
		
		#runs through at least one fundraising cycle, up to the number of rounds determined, calls the take_turn method from the funding round module, which in turn rolls the die
		1.upto(rounds) do |round|
			puts "\nRound #{round}:"
			@projects.each do |project|
				FundingRound.take_turn(project)
			end
		end
		
		puts "\nTo summarize, the projects in #{@category} and their funding requirements are:"
		
		#iterates over each project, calls still_needed method from project class, and prints info for the amount of funding still needed
		@projects.each do |project|
			project.still_needed
			puts "#{project.name}: $#{project.still_needed}"
		end
		
	end
	
	def print_stats
		projects_success = @projects.select {|project| project.success? } 
		projects_flop = @projects.reject {|project| project.success? }
		#the projects are already contained in an array defined in the 
		#initialize method at the top of this code. you can call the 
		#.select method on that array and ask it to choose the projects 
		#based on the .success? method defined in the project class code
		
		#iterates over the array of projects determined to be successful (from project class) and prints info on each project
		puts "\nThe following projects have successfully met their funding goal:"
		projects_success.each do |project|
			puts "#{project.name}: $#{project.fund}"
		end
		
		#iterates over the array of projects determined to be flops, and puts info about each unsuccessful project
		puts "\nThe following projects did not meet their funding goal:"
		projects_flop.each do |project|
			puts "#{project.name} was $#{project.still_needed} short."
		end
		
		#iterates over the pledges received for each project and prints their info-- showing off how many fancy pledges they got
		@projects.each do |project|
			puts "\n#{project.name} received the following generous pledges:"
			project.each_pledge_received do |pledge|
			puts "$#{pledge.value} total from #{pledge.name} pledges"
			end
		end
		
		#projects sorted by their relative success (how close they are to being funded)
		sorted_projects = @projects.sort {|a, b| a.still_needed <=> b.still_needed}
		puts "\nThe projects ranked by level of funding success are:"
		sorted_projects.each do |project|
		formatted_name = project.name.ljust(20, ".")
			puts "#{formatted_name} $#{project.fund} of $#{project.target_fund}"
		end
	end
end 

