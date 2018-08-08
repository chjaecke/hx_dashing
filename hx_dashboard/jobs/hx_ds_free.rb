#!/bin/env ruby
# encoding: utf-8

require 'net/http'
require 'uri'
require 'json'
require __dir__ + '/hx_helper'

server = ENV["HX_URL"]
auth_token = ENV["HX_TOKEN"]

SCHEDULER.every '5s', :first_in => 0 do |job|

  json_response = HX_Helper.restcall("#{server}/coreapi/v1/clusters/", auth_token)
  cuuid = json_response[0]["uuid"]
  
  json_response = HX_Helper.restcall("#{server}/coreapi/v1/clusters/#{cuuid}/datastores", auth_token)
  
  ds = Hash.new({ value: 0 })
  
  json_response.each do |child|
	ds_name = child['dsconfig']['name']
	ds_capacity = child['freeCapacityInBytes'] * 0.000000000931
	ds_capacity = ds_capacity.round
    ds[ds_name] = { label: ds_name, value: ds_capacity}
  end
  
  send_event('ds_free', { items: ds.values })
  
end