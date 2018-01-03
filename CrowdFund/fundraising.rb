require_relative 'project'
require_relative 'die'
require_relative 'funding_round'
require_relative 'pledge_pool'

class Fundraising

	def initialize(category)
		@category = category.capitalize
		@projects = []
	end

	def add_project(a_project)
		@projects << a_project
	end

	def beg(rounds)
		
		puts "There are #{@projects.size} projects in #{@category}:"
		@projects.each do |project|
			puts project
		end
		
		pledges = PledgePool::PLEDGES
		puts "\nThere are #{pledges.size} pledge options for especially generous donors:"
		pledges.each do |pledge|
			puts "A #{pledge.name} pledge is worth $#{pledge.value}."
		end
		
		1.upto(rounds) do |round|
			puts "\nRound #{round}:"
			@projects.each do |project|
				FundingRound.take_turn(project)
			end
		end
		
		puts "\nTo summarize, the projects in #{@category} and their funding requirements are:"
		
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
		
		puts "\nThe following projects have successfully met their funding goal:"
		projects_success.each do |project|
			puts "#{project.name}: $#{project.fund}"
		end
		
		puts "\nThe following projects did not meet their funding goal:"
		projects_flop.each do |project|
			puts "#{project.name} was $#{project.still_needed} short."
		end
		
		sorted_projects = @projects.sort {|a, b| a.still_needed <=> b.still_needed}
		puts "\nThe projects ranked by level of funding success are:"
		sorted_projects.each do |project|
		formatted_name = project.name.ljust(20, ".")
			puts "#{formatted_name} $#{project.fund} of $#{project.target_fund}"
		end
	end
end 

