require_relative 'project'
require_relative 'fundraising'


awesome_projects = Fundraising.new("Crowd Fund Initiatives")
awesome_projects.load_projects(ARGV.shift || "projects.csv")

=begin
project1 = Project.new("ABC", 200, 1500)
project2 = Project.new("XYZ", 450, 1700)
project3 = Project.new("LMN", 530, 1850)

awesome_projects.add_project(project1)
awesome_projects.add_project(project2)
awesome_projects.add_project(project3)
=end

loop do
	puts "How many times should we beg your friends for money? Please enter an integer. (Type 'quit' to exit)"
	answer = gets.chomp.downcase
	case answer
		when /^\d+$/
			awesome_projects.beg(answer.to_i)
		when "quit", "exit", "stop"
			awesome_projects.print_stats
			break
		else 
			puts "I don't understand. Please enter a number or 'quit'."
	end
end
	



