#I got a lot of piece of code from Devin. Before i copy to my project I analize and i build test for.

#!/usr/bin/env ruby
require 'httparty'
require 'dotenv'
require 'table_print'
require_relative "workspace"

Dotenv.load

def main
  workspace = WorkSpace.new 
  puts "\n"
  puts "Welcome to the Ada Accountability Group 6 Slack CLI! This Slack workspace currently has #{workspace.users.count} users and #{workspace.channels.count} channels."

  user_input = prompt_for_input

  until user_input == "quit" || user_input == "exit"
    
    case user_input
    when "list users"
      tp workspace.users, "slack_id", "name", "real_name" 
      puts "\n"
      
    when "list channels"
      tp workspace.channels, "name", "topic", "member_count", "slack_id"
      puts "\n"
      
    when "select user"
      print "Please enter the user name or ID: "
      search_term = gets.chomp.downcase
      puts workspace.select_user(search_term)
      puts "\n"
      
    when "select channel"
      print "Please enter the channel name or ID: "
      search_term = gets.chomp.downcase
      puts workspace.select_channel(search_term)
      puts "\n"
      
    when "details"
      if workspace.selected == nil
        puts "Please select a user or channel."
        puts "\n"
      else
        workspace.show_details
        user_input = nil
        puts "\n"
      end 
    when "send message"
      if workspace.selected == nil
        puts "Please select a user or channel."
        puts "\n"
      else
        print "Please enter your message: "
        msg = gets.chomp
        workspace.send_message(msg)
        puts "\n"
      end
    else
      puts "Sorry, I didn't understand your request. Please try again."
      puts "\n"
    end

    user_input = prompt_for_input
  end 
  puts "Thank you for using the Ada Accountability Group 6 Slack CLI!"
  puts "\n"
end

def prompt_for_input
  print "Please choose an option:  \n1)list users,\n2)list channels,\n3)select user,\n4)select channel,\n5)details,\n6)send message,\n7)quit:"
  return gets.chomp.downcase
end

main if __FILE__ == $PROGRAM_NAME
