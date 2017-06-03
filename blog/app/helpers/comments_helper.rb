module CommentsHelper

  def calculate_time_from_created_at created_at
  	
  	diff_in_sec = Time.now.to_i - Time.at(created_at.to_i).to_i
  	
  	if diff_in_sec > 60
  		minutes = diff_in_sec/60

  		if minutes > 60
  			
  			hours = minutes/60

  			if hours > 24
  				days = hours/24

  				return days==1 ? "#{days} day ago" : "#{days} days ago"
  			end

  			return hours==1 ?  "#{hours} hr ago" :  "#{hours} hrs ago"
  		end

  		return "#{minutes} mins ago" #return min ago

  	else
  		return "#{diff_in_sec} sec ago"
  	end
  end


end
