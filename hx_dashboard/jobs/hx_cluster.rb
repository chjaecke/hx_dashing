#!/bin/env ruby
# encoding: utf-8

require 'net/http'
require 'uri'
require 'json'
require __dir__ + '/hx_helper'

server = ENV["HX_URL"]
auth_token = ENV["HX_TOKEN"]

SCHEDULER.every '5s', :first_in => 0 do |job|

  json_response = HX_Helper.restcall("#{server}/coreapi/v1/clusters", auth_token)
  cluster_name = json_response[0]["name"]

  send_event("cluster", {text: cluster_name})
  
end