task :clean do
  %w(bin bci com ext).each do |extension|
    sh "find . -name \"*.#{extension}\" -delete"
  end
end
