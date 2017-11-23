##
# This file is part of WhatWeb and may be subject to
# redistribution and commercial restrictions. Please see the WhatWeb
# web site for more information on licensing and terms of use.
# http://www.morningstarsecurity.com/research/whatweb
##
Plugin.define do
name "ApPHP-Calendar"
author "Brendan Coles <bcoles@gmail.com>" # 2011-03-20
version "0.1"
description "The ApPHP Calendar (ApPHP CAL) is a powerful PHP calendar script that may be easily integrated and used with various PHP projects, such as schedulers, event processors etc. The calendar is very simple to install, implement and use."
website "http://www.apphp.com/php-calendar/"

# Google results as at 2011-03-20 #
# 29 for Sunday Monday Tuesday Wednesday Thursday Friday +Satarday inurl:action inurl:view_type

# Dorks #
dorks [
'Sunday Monday Tuesday Wednesday Thursday Friday "Satarday" inurl:action inurl:view_type'
]



# Matches #
matches [

# Version Detection # HTML Comment # This script was generated by
{ :version=>/<!-- This script was generated by ApPHP Calendar v\.([\d\.]+) \(http:\/\/www\.apphp\.com\) -->/ },

# Table column headings # How do I spell Saturday?
{ :text=>"<tr class='tr_days'><td class='th'>Sunday</td><td class='th'>Monday</td><td class='th'>Tuesday</td><td class='th'>Wednesday</td><td class='th'>Thursday</td><td class='th'>Friday</td><td class='th'>Satarday</td></tr>" },

]

# Aggressive #
aggressive do
	m=[]

	# Local File Path Detection # Confirm match # Find application base path
	if @body =~ /<!-- This script was generated by ApPHP Calendar v\.([\d\.]+) \(http:\/\/www\.apphp\.com\) -->/ and @base_uri.path =~ /\.php/

		# Open application base url + "?view_type[]"
		target_url = @base_uri.to_s.scan(/^([^\n]*\.php)/).to_s+"?view_type[]"
		status,url,ip,body,headers=open_target(target_url)

		# Extract local file path # PHP error
		m << { :filepath=>body.scan(/: The first argument should be either a string or an integer in (<b>)?([^\n^<]+)(<\/b>)? on line (<b>)?[\d]+(<\/b>)?/)[0][1] } if body =~ /: The first argument should be either a string or an integer in (<b>)?([^\n^<]+)(<\/b>)? on line (<b>)?[\d]+(<\/b>)?/

	end

	# Return aggressive matches
	m
end

end

