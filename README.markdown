Rails Debug Bar
===============

Bar of diagnostic info for Rails.  Inspired by
http://rob.cogit8.org/blog/2008/Sep/19/introducing-django-debug-toolbar/

Expect this to need extending to be useful for you.  Patches accepted,
forking encouraged.

Usage
=======

    class ApplicationController < ActionController::Base
      after_filter RailsDebugBar unless Rails.env.production?
    end
    
Copy CSS to /stylsheets/rails_debug_bar.css (Generator coming)

ul#rails_debug_bar {
	list-style-type: none;
	margin-bottom: 0;
	margin-top: 1em;
	padding-left: 0
}
ul#rails_debug_bar li {
	display: inline-block;
	padding: 0.2em;
	border: 1px solid black;
	background-color: #fda;
	color: black;
}
ul#rails_debug_bar li ul {
	display: none;
	padding-left: 0px;
}
ul#rails_debug_bar li:hover ul {
	display: block;
	position: absolute;
	z-index: 2;
}
ul#rails_debug_bar li ul li {
	display: block;
}
    

Copyright (c) 2008 Bryce Kerley, released under the MIT license.
My version: http://github.com/bkerley/railsdebugbar/tree/master
