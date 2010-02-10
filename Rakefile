task :clean do
  %w(.bin .bci .com .ext ~).each do |extension|
    sh "find . -name \"*#{extension}\" -delete"
  end
end

task :release => :clean do
  sh "cd #{File.dirname(__FILE__)}; " + %Q{tar --create --verbose --file ../propagator.tar --directory .. --transform "s/prop/propagator/" --exclude="*.svn*"prop/}
end
