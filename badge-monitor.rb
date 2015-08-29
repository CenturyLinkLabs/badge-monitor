#!/usr/bin/env ruby

require 'net/http'
require 'json'
$cache = {}

def notify_hipchat(name)
  http = Net::HTTP.new("api.hipchat.com", 443)
  http.use_ssl = true

  request = Net::HTTP::Post.new("/v1/rooms/message?auth_token=#{ENV["HIPCHAT_API_TOKEN"]}&format=json")
  request.set_form_data(
    "room_id" => ENV["HIPCHAT_ROOM_ID"] || "Hubot Demo",
    "from" => "Badger",
    "message_format" => "text",
    "color" => "yellow",
    "message" => "New badge generated: #{name}"
  )
  res = http.request(request)
end

loop do
  res = Net::HTTP.get(URI.parse(ENV["BADGER_DEBUG_URL"]))
  j = JSON.parse(res)

  j['cache']['Keys'].each do |image|
    next if image.start_with?("centurylink")
    if !$cache.key?(image)
      $cache[image] = true
      notify_hipchat(image) 
    end
  end
  sleep(15)
end
