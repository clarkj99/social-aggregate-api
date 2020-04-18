# Import Sample data from CSVs
require "csv"

# ------------------------------------

User.destroy_all
puts "Importing Users data ..."
csv_text = File.path(Rails.root.join("db/csv", "users.csv"))

count = 1
CSV.foreach(csv_text) do |row|
  # Skip the header row
  # Use userid from data instead of generated one
  User.create({ email: row[1], name: row[2], github_username: row[3], registered_at: row[4] }) { |user| user.id = row[0] } if count > 1
  count += 1
  if (count % 100) == 0
    puts count
  end
end
puts "Imported #{count} Users"

# ------------------------------------

Post.destroy_all
puts "Importing Posts data ..."
csv_text = File.path(Rails.root.join("db/csv", "posts.csv"))

count = 1
CSV.foreach(csv_text, liberal_parsing: true) do |row|
  # Skip the header row
  Post.create({ title: row[1], body: row[2], user_id: row[3], posted_at: row[4] }) if count > 1
  count += 1
  if (count % 100) == 0
    puts count
  end
end
puts "Imported #{count} Posts"

# ------------------------------------

Comment.destroy_all
puts "Importing Comments data ..."
csv_text = File.path(Rails.root.join("db/csv", "comments.csv"))

count = 1
CSV.foreach(csv_text, liberal_parsing: true) do |row|
  # Skip the header row
  Comment.create({ user_id: row[1], post_id: row[2], message: row[3], commented_at: row[4] }) if count > 1
  count += 1
  if (count % 100) == 0
    puts count
  end
end
puts "Imported #{count} Comments"

# ------------------------------------

Rating.destroy_all
puts "Importing Ratings data ..."
csv_text = File.path(Rails.root.join("db/csv", "ratings.csv"))

count = 1
CSV.foreach(csv_text, liberal_parsing: true) do |row|
  # Skip the header row
  Rating.create({ user_id: row[1], rater_id: row[2], rating: row[3], rated_at: row[4] }) if count > 1
  count += 1
  if (count % 100) == 0
    puts count
  end
end
puts "Imported #{count} Ratings"
