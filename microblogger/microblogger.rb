require 'jumpstart_auth'
require 'bitly'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE # Necessary to get this thing connecting on Windows, at least for me.

class MicroBlogger
  attr_reader :client

  def initialize
    puts "Initializing MicroBlogger..."
    @client = JumpstartAuth.twitter
  end

  def run
    puts "Welcome to the JSL Twitter Client!"
    command = ""
    while command != "q"
      print "Enter command: "
      input = gets.chomp.split(" ")
      command = input[0]
      case command
        when "q" then puts "Goodbye!"
        when "t" then tweet(input[1..-1])
        when "@" then tweet_to(input[1], input[2..-1].join(" "))
        when "dm" then dm(input[1], input[2..-1].join(" "))
        when "spam" then spam_my_followers(input[1..-1])
        when "elt" then everyones_last_tweet
        when "s" then shorten(input[1..-1])
        when "turl" then tweet("#{input[1..-2].join(" ")} #{shorten(input[-1])}")
        else
          puts "Sorry, I don't know how to #{command}."
      end
    end
  end

  def tweet(message)
    if message.length <= 140
      @client.update(message)
    else
      puts "Tweet longer than 140 characters. Not posted."
    end
  end

  def tweet_to(target, message)
    target_tweet = "@#{target} #{message}"
    tweet(target_tweet)
  end

  def dm(target, message)
    puts "Trying to send #{target} this direct message:"
    puts message
    screen_names = followers_list
    if screen_names.include?(target)
      message = "d @#{target} #{message}"
      tweet(message)
    else
      puts "Sorry! You can't DM people who don't follow you."
    end
  end

  def followers_list
    @client.followers.collect { |follower| @client.user(follower).screen_name }
  end

  def spam_my_followers(message)
    screen_names = followers_list
    screen_names.each { |follower| dm(follower, message) }
  end

  def everyones_last_tweet
    friends = @client.friends.sort_by { |friend| @client.user(friend).screen_name.downcase }
    friends.each do |friend|
      timestamp = @client.user(friend).status.created_at
      timestamp.strftime("%A, %b %d")
      puts "#{@client.user(friend).screen_name} said on #{timestamp.strftime("%A, %b %d")}..."
      puts @client.user(friend).status.text
      puts "" # A blank line to separate people.
    end
  end

  def shorten(original_url)
    Bitly.use_api_version_3
    bitly = Bitly.new('hungryacademy', 'R_430e9f62250186d2612cca76eee2dbc6')
    shortened_url = bitly.shorten(original_url).short_url
    puts "Shortening this URL: #{shortened_url}"
    return shortened_url
  end
end

blogger = MicroBlogger.new
blogger.run
