# make your program below
require "http"
puts "Hello, user. Welcome to reddit it the terminal"
puts "*************************"
puts "Which subreddit would you like to see today?"
sub_reddit = gets.chomp

response = HTTP.get("https://www.reddit.com/r/#{sub_reddit}/.json")

if response.status.success?
  posts = response.parse["data"]["children"].map do |post|
    post["data"]
  end

else
  puts "Not found"
  exit
end
puts posts

puts
puts "******"
puts "Would you like to see comments from a post if so pick a number, if not hit 'n' "
post_index = (gets.chomp.to_i - 1)
selected_post = posts[post_index]
selected_post_id = selected_post["id"]
selected_post_title = selected_post["title"]

response = HTTP.get("https://www.reddit.com/r/#{sub_reddit}/comments/#{selected_post_id}/#{selected_post_title}.json")
comment_hashes = response.parse[1]["data"]["children"]

comments = []
comment_hashes.each do |comment|
  comments << comment["data"]["body"]
end
p comments


# selected_post = posts[post_index]

# new_response = HTTP.get("https://www.reddit.com/r/#{sub_reddit}/comments/#{selected_post['id']}/#{selected_post['title']}/")

# puts