require 'spec_helper'

describe 'hosts' do

  let(:title) { 'hosts' }
  let(:node) { 'rspec.example42.com' }
  let(:facts) { {
      :ipaddress => '10.42.42.42',
      :osfamily  => 'RedHat',
      :operatingsystem => 'CentOS'
  } }

  describe 'Test minimal installation' do
    it { should contain_file('hosts.conf').with_ensure('present') }
  end

  describe 'Test installation of a specific version' do
    let(:params) { {:version => '1.0.42' } }
  end

  describe 'Test customizations - template' do
    let(:params) { {
        :template => 'hosts/spec.erb',
        :content => '',
    } }
    it 'should generate a valid template' do
      should contain_file('hosts.conf').with_content(/fqdn: rspec.example42.com/)
      #content = catalogue.resource('file', 'hosts.conf').send(:parameters)[:content]
      #content.should match "fqdn: rspec.example42.com"
    end
  end

  describe 'Test customizations - source' do
    let(:params) { {:source => "puppet:///modules/hosts/spec"} }
    it { should contain_file('hosts.conf').with_source('puppet:///modules/hosts/spec') }
  end

  describe 'Test Dynamic mode class' do
    let(:params) { {:dynamic_mode => "true" } }
    it { should contain_class('hosts::dynamic') }
  end

end
