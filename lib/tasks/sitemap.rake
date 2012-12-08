require 'net/http'
require 'uri'
require 'open-uri'
require 'timeout'

sitemap = "http://locomo.passionbean.com/sitemap.xml"
engines = {"google" => "http://www.google.com/webmasters/tools/ping?sitemap=#{sitemap}",
           "bing" => "http://www.bing.com/webmaster/ping.aspx?sitemap=#{sitemap}"}

namespace :sitemap do

  task :refresh => ["sitemap:ping_google", "sitemap:ping_bing"]

  desc "ping google"
  task :ping_google do
    print "Starting submit sitemap to Google...."
    begin
      Timeout::timeout(20) {
        open(engines["google"])
      }
      puts "......OK!"
    rescue Timeout::Error, StandardError => e
      puts "......Failed: #{e.inspect} (URL #{engines['google']} )"
    end
  end

  task :ping_bing do
    print "Starting submit sitemap to Bing......"
    begin
      Timeout::timeout(20) {
        open(engines["bing"])
      }
      puts "......OK!"
    rescue Timeout::Error, StandardError => e
      puts "......Failed: #{e.inspect} (URL #{engines['bing']} )"
    end
  end

end
