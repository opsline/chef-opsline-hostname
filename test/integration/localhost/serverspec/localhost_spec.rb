require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  c.before :all do
    c.path = '/sbin:/usr/sbin'
  end
end

describe command("grep example.com /etc/hosts") do
  it { should return_stdout /127\.0\.0\.1\s+.+\.example\.com/}
end
