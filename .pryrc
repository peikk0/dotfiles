# -*- mode: ruby -*- vim:set ft=ruby:

# courtesy of tpope (http://github.com/tpope/tpope/blob/master/.pryrc)

ENV['HOME'] ||= ENV['USERPROFILE'] || File.dirname(__FILE__)

Pry.editor = ENV['VISUAL']
Pry.config.history.file = File.expand_path('~/.history.rb')
begin
  if defined?(Bundler)
    FileUtils.mkdir_p('.bundle')
    Pry.config.history.file = Bundler.root.join('.bundle/history.rb')
  end
rescue
end
Pry.config.history.should_load = true
Pry.config.history.should_save = true

# gem install pry-theme
Pry.config.theme = "solarized"

Pry.config.print = proc do |output, value|
  output.puts "\001\e[1;32m\002◀\001\e[0m\002 #{value.inspect}"
end
Pry.config.exception_handler = proc do |output, exception, _|
  output.puts "\001\e[1;31m\002◀\001\e[0m\002 #{exception.class}: #{exception.message}"
  output.puts "from #{exception.backtrace.first}"
end
Pry.prompt = [
  proc do |target_self, nest_level, pry|
    "\001\e[1;34m\002#{'▶' * (nest_level + 1)}\001\e[0m\002 "
  end,
  proc do |target_self, nest_level, pry|
    "#{' ' * nest_level}\001\e[1;30m\002┇\001\e[0m\002 "
  end
]

$LOAD_PATH.unshift(File.expand_path('~/.ruby/lib'), File.expand_path('~/.ruby'))
$LOAD_PATH.uniq!

%w(pry-editline).each do |lib|
  begin
    require lib
  rescue LoadError
  end
end
