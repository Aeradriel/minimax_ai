task default: :concat

task :concat do
  files = %w[class.rb player.rb map.rb main_loop.rb]
  content = ''
  files.each do |f|
    content << "# #{f}\n"
    content << File.read(f)
    content << "\n\n"
  end
  File.open('all.rb', 'w+') do |f|
    f << content
  end
  puts content
end