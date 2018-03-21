require 'json'

json_file_path = './proxies-template.json'
jekyll_out_path = ARGV[0]
json_out_path = ARGV[1]
backend_base_url = ENV['BLOB_CONTENTS_URL']

json_data = open(json_file_path) do |io|
  JSON.load(io)
end

Dir.entries(jekyll_out_path).select do |dir|
  p dir if dir.match(/page([0-9]*)/)
  json_data['proxies']['blog-' + dir] = {'matchCondition' => {'route' => '/' + dir + '/'}, 'backendUri' => backend_base_url + '/' + dir + '/index.html'} if dir.match(/page([0-9]*)/)
end

Dir.mkdir json_out_path if !Dir.exists?(json_out_path)
open(json_out_path + 'proxies.json', 'w') do |io|
  io.puts(JSON.pretty_generate(json_data))
end
