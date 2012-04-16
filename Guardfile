

guard 'process', :name => 'run jasmine test', :command => './run_tests', :env => {"ENV1" => "value 1", "ENV2" => "value 2"}, :stop_signal => "KILL"  do
  watch(%r{^(public|spec)/js/js/(.*)\.coffee$})
end



