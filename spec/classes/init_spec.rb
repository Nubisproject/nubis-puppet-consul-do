require 'spec_helper'
describe 'consul_do' do

  context 'with defaults for all parameters' do
    it { should contain_class('consul_do') }
  end
end
