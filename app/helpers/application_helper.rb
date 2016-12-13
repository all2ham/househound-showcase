module ApplicationHelper
	def active_link(ctrl, act, text, method=nil)
	   link = ""
	   if (ctrl == params[:controller] and act == params[:action])
	     link = raw("<li class=active>")
	   else
	     link = raw("<li>")
	   end
	   link += (link_to(
	       text,
	       {
	         :controller => "/" + ctrl,
	         :action => act
	       },
	       :method => method
	     ) +
	     raw("</li>"))
	end

	def datehelper(qdate)
		qdate.strftime("%a %d %b %y") if qdate
	end

	def open_house_date(date)
		date.strftime("%H:%M %a %d %b")
	end

	def resource_name
	 :user
	end

	def resource
	  @resource ||= User.new
	end

	def devise_mapping
	  @devise_mapping ||= Devise.mappings[:user]
	end

	def address(address)
		string = address.line_1
		string << "<br>"
		unless address.line_2.blank?
			string << address.line_2
			string << "<br>"
		end
		string << address.city
		string << "<br>"
		string << address.state_province
		string << "<br>"
		string << address.zip_postcode
		return string.html_safe
	end

	# Pass in options[:show_tag] as predicate to showing the tag
	# Pass in options[:tag] as sym
	def conditional_tag(options = {}, &block)
		if options.delete(:show_tag)
			concat content_tag(options.delete(:tag), capture(&block), options)
		else
			concat capture(&block)
		end
	end
end
