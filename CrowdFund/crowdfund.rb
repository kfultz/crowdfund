=begin
Instead of a one-time request for funding, change your app to allow for multiple rounds of funding requests (or at least until your friends start to avoid you because you're asking them for money a little too often).

When the funding rounds are over, print out the number of projects that are fully-funded and under-funded.

Print off a list of projects that still need contributions, sorted by amount outstanding.
=end


require_relative 'project'
require_relative 'fundraising'

project1 = Project.new("ABC", 200, 1500)
project2 = Project.new("XYZ", 450, 1700)
project3 = Project.new("LMN", 530, 1850)

awesome_projects = Fundraising.new("awesome projects")
awesome_projects.add_project(project1)
awesome_projects.add_project(project2)
awesome_projects.add_project(project3)

awesome_projects.beg(10)

awesome_projects.print_stats

