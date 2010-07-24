task :clean do
  %w(.bin .bci .com .ext ~).each do |extension|
    sh "find . -name \"*#{extension}\" -delete"
  end
end

task :release => :clean do
  sh "cd #{File.dirname(__FILE__)}; " + %Q{tar --create --verbose --file ../propagator.tar --directory .. --transform "s/prop/propagator/" --exclude="*.svn*" prop/}
end

def files
  ["scheduler",
   "metadata",
   "merge-effects",
   "cells",
   "propagators",
   "sugar",
   "generic-definitions",
   "expression-language",
   "standard-propagators",
   "compound-data",
   "carrying-cells",
   "physical-closures",

    "intervals",
    "premises",
    "supported-values",
    "truth-maintenance",
    "contradictions",
    "search",
    "amb-utils",

    "example-networks"].map do |base|
  "core/#{base}.scm"
  end
end

task :workbook do
  sh "enscript -M letter -fCourier-Bold12 -o workbook.ps --file-align=2 #{files.join(" ")}"
end
