#!/bin/env ruby
# encoding: utf-8

require 'net/http'
require 'uri'
require 'json'

class HX_Helper
	
	def self.restcall(host, token)  
		url = URI.parse(host)
		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = (url.scheme == 'https')
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE
		req = Net::HTTP::Get.new(url.request_uri)
		req['Authorization'] = token
		response = http.request(req)
		j = JSON[response.body]
		return j
	end  

end

