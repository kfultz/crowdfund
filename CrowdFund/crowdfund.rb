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

