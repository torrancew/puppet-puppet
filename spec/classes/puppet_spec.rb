require 'spec_helper'

describe 'puppet', :type => 'class' do
  it do
    should contain_class 'puppet::install'
    should contain_class 'puppet::configure'
    should contain_class 'puppet::service'
  end
end

