require 'spec_helper'

describe docker_image('gliderlabs/registrator:latest') do
  it { should exist }
end

describe docker_container('registrator') do
  it { should be_running }
end

