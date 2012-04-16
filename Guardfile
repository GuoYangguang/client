

guard 'process', :name => 'jasmine test', :command =>"jasmine-headless-webkit -c -j spec/js/support/jasmine.yml",
  :stop_signal => "KILL"  do
  watch(%r{^(public|spec)/js/js/(.*)\.coffee$})
end



