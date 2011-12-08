config = begin
  YAML.load_file(File.join(::Rails.root.to_s, "/config/config.yml"))[::Rails.env]
rescue Errno::ENOENT
  raise "Configuration file config/config.yml not found. Please set it up."
end

config.each_pair do |key, value|
  Mong::Application.config.send("#{key}=", value)
end
