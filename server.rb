#!/usr/bin/env ruby
require 'webrick'

port = (ARGV[0] || 3000).to_i
root = File.expand_path(Dir.pwd)

server = WEBrick::HTTPServer.new(
  Port: port,
  BindAddress: '0.0.0.0',
  DocumentRoot: root,
  AccessLog: [],
  Logger: WEBrick::Log.new($stderr, WEBrick::Log::INFO)
)

server.mount_proc '/' do |req, res|
  file_handler = WEBrick::HTTPServlet::FileHandler.new(server, root)
  file_handler.do_GET(req, res)

  res['Cache-Control'] = 'no-cache, no-store, must-revalidate'
  res['Pragma'] = 'no-cache'
  res['Expires'] = '0'
  res['Access-Control-Allow-Origin'] = '*'
end

puts "========================================================"
puts "  RC-99 Web Platform Running via WEBrick Standard Server"
puts "  Local Mac:   http://localhost:#{port}"
puts "  Mobile/WiFi: http://192.168.31.164:#{port}"
puts "========================================================"

trap('INT') { server.shutdown }
trap('TERM') { server.shutdown }

server.start
