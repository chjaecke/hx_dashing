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
  
  json_response = HX_Helper.restcall("#{server}/coreapi/v1/clusters/#{cuuid}/status", auth_token)
  health = json_response["resiliencyStatus"]
  
  case health
  when "HEALTHY"
  status="true"
  when "UNHEALTHY"
  status="false"
  else
  status="null"
  end
  
  send_event('health', {value:health, status: status})
end