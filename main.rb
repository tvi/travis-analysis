#!/usr/bin/env ruby
require 'optparse'
require "net/http"
require 'uri'
require "json"

puts 'travis-analysis is starting....'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: main.rb [options]"

  opts.on('-a', '--all', 'Download all possible jobs') { |v| options[:all] = v }
  # opts.on('-h', '--sourcehost HOST', 'Source host') { |v| options[:source_host] = v }
  # opts.on('-p', '--sourceport PORT', 'Source port') { |v| options[:source_port] = v }
  puts opts

end.parse!
puts options

def not_implemented()
  raise 'Not implemented yet.'
end

def get_jobs()
  def get_upper_boundary()
    jobs = 'https://api.travis-ci.org/jobs'
    url = URI.parse(jobs)

    response = Net::HTTP.start(url.host, use_ssl: true, verify_mode: OpenSSL::SSL::VERIFY_NONE) do |http|
      http.get url.request_uri
    end

    case response
      when Net::HTTPRedirection
          # repeat the request using response['Location']
      when Net::HTTPSuccess
        outputDataJson = JSON.parse response.body
        outputData = response.body
         # outputData
      else
          # response code isn't a 200; raise an exception
        pp response.error!
      end
    return outputDataJson[0]["id"]

    # http = Net::HTTP.new(uri.host, uri.port)
    # request = Net::HTTP::Get.new(uri.request_uri)
    # response = http.request(request)
    # print response.body
    # Net::HTTP.get(URI.parse(jobs))
  end
  # puts get_upper_boundary()
  upper = get_upper_boundary()
  # ids = (1000000..get_upper_boundary()).to_a
  # ids = ((upper-10)..upper).to_a

  current_job = 'https://api.travis-ci.org/jobs/%d' % upper
  puts current_job
  url = URI.parse(current_job)

  response = Net::HTTP.start(url.host, use_ssl: true, verify_mode: OpenSSL::SSL::VERIFY_NONE) do |http|
    http.get url.request_uri
  end

  case response
    when Net::HTTPSuccess
      outputDataJson = JSON.parse response.body
      outputData = response.body
    else
      pp response.error!
    end

  puts outputData

end
# https://github.com/rails/rails/compare/1e9522cb257f...3e6485993858.diff
# https://api.travis-ci.org/jobs/1000000
if options[:all]
  p 'doing all'
  get_jobs()
else
  get_jobs()
  # not_implemented()
end