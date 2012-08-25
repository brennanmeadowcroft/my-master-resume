# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

seed_file = File.join(Rails.root, 'db', 'data.yml')
config = YAML::load_file(seed_file)
Activity.create(config["activities"])
Award.create(config["awards"])
Education.create(config["education"])
Experience.create(config["experiences"])
Position.create(config["positions"])
Skill.create(config["resumes"])
Tag.create(config["tags"])

# User.create(email: 'brennan@brennanmeadowcroft.com', first_name: 'Brennan', 
# 			last_name: 'Meadowcroft', address_1: '3250 O\'Neal Circle', address_2: '#24L', 
# 			city: 'Boulder', state: 'CO')
# User.create(email: 'brennan@mymasterresume.com', first_name: 'Master', last_name: 'Resume', 
# 			address_1: '8330 E Quincy Ave.', address_2: 'C308', city: 'Denver', state: 'CO')

# Activity.create(organization: 'Habitat For Humanity', start_date: '5/31/2010', end_date: '8/30/2011', user_id: 1)
# Activity.create(organization: 'DABE', start_date: '01/2006', user_id: 1)
# Activity.create(organization: 'HR Club of America', start_date: '2/28/2007', end_date: '8/30/2010', user_id: 2)
# Activity.create(organization: 'Recruiters Society', start_date: '3/15/2008', end_date: '3/30/2008', user_id: 2)

# Award.create(description: 'Eagle Scout', date: '04/20/2001', user_id: 1)
# Award.create(description: 'Humanitarian of the Year', date: '05/31/2012', user_id: 2)

# Education.create(school: 'CU', city: 'Denver', state: 'CO', degree: 'Bachelors', start_date: '01/15/2004', end_date: '12/15/2006', major: 'Economics, Business', user_id: 1)
# Education.create(school: 'University of Colorado', city: 'Boulder', state: 'CO', degree: 'Bachelors', start_date: '08/31/2001', end_date: '05/31/2002', major: 'Business', user_id: 2)

# Skill.create(description: 'Web Design', user_id: 1)
# Skill.create(description: 'Programming', user_id: 1)
# Skill.create(description: 'Recruiting', user_id: 2)
# Skill.create(description: 'People Person', user_id: 2)

# Position.create(title: 'Founder', company: 'My Master Resume, Inc', city: 'Denver', state: 'CO', start_date: '02/28/2012', end_date: '02/28/2012', user_id: 1)
# Position.create(title: 'Client Analytics', company: 'Datalogix', city: 'Westminster', state: 'CO', start_date: '05/31/2012', end_date: '05/31/2012', user_id: 1)
# Position.create(title: 'HR Consultant', company: 'Deloitte', city: 'Denver', state: 'CO', start_date: '01/03/2003', end_date: '01/03/2007', user_id: 2)
# Position.create(title: 'VP of HR', company: 'Rockin\' House', city: 'Denver', state: 'CO', start_date: '01/31/2007', end_date: '01/31/2007', user_id: 2)

# Experience.create(description: 'Made Money', position_id: 1, user_id: 1)
# Experience.create(description: 'Made Some More Money', position_id: 1, user_id: 1)
# Experience.create(description: 'They Should Pay Me To Do This... Oh Wait...', position_id: 2, user_id: 1)
# Experience.create(description: 'Did some stuff', position_id: 2, user_id: 1)
# Experience.create(description: 'Pure Awesomeness', position_id: 1, user_id: 1)
# Experience.create(description: 'Did other stuff', position_id: 2, user_id: 1)
# Experience.create(description: 'Made People Look Good', position_id: 3, user_id: 2)
# Experience.create(description: 'Got Paid', position_id: 3, user_id: 2)
# Experience.create(description: 'Excelled at being awesome', position_id: 4, user_id: 2)
# Experience.create(description: 'Favorite Employee of all time', position_id: 4, user_id: 2)
# Experience.create(description: 'Walked Places', position_id: 3, user_id: 2)
# Experience.create(description: 'Took care of business', position_id: 4, user_id: 2)

# Resume.create(description: 'Marketing', tag_id: 1, user_id: 1)
# Resume.create(description: 'HR', tag_id: 6, user_id: 2)

# Tag.create(description: 'Marketing', user_id: 1)
# Tag.create(description: 'Product', user_id: 1)
# Tag.create(description: 'Online Marketing', user_id: 1)
# Tag.create(description: 'Sales', user_id: 2)
# Tag.create(description: 'Finance', user_id: 2)
# Tag.create(description: 'HR', user_id: 2)

# # Activity.find(1).tags << Tag.find(1)
# # Activity.find(2).tags << Tag.find(1)
# # Activity.find(3).tags << Tag.find(6)

# # Award.find(1).tags << Tag.find(1)
# # Award.find(2).tags << Tag.find(6)

# # Education.find(1).tags << Tag.find(1)
# # Education.find(2).tags << Tag.find(6)

# Skill.find(1).tags << Tag.find(1)
# Skill.find(2).tags << Tag.find(2)
# Skill.find(2).tags << Tag.find(1)
# Skill.find(3).tags << Tag.find(6)
# Skill.find(4).tags << Tag.find(6)

# Experience.find(1).tags << Tag.find(1)
# Experience.find(2).tags << Tag.find(1)
# Experience.find(3).tags << Tag.find(1)
# Experience.find(4).tags << Tag.find(1)
# Experience.find(5).tags << Tag.find(2)
# Experience.find(6).tags << Tag.find(2)
# Experience.find(7).tags << Tag.find(3)
# Experience.find(8).tags << Tag.find(4)
# Experience.find(9).tags << Tag.find(5)
# Experience.find(10).tags << Tag.find(6)
# Experience.find(11).tags << Tag.find(6)
# Experience.find(12).tags << Tag.find(6)
