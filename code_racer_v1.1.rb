require 'csv'
red = Array.new()
records = Array.new()
x= 290
y= 50
y_1=51
score_1 = 0
score_2 =0
score = 0
corect=0
wrong=0
i=0
c=0
counter=1


File.open("mandja.txt").each do |line|
	red << line.gsub(/\n/, "")
end

File.open("records.txt").each do |line|
	records << line.gsub(/\n/,"")
end


Shoes.app :width => 1360, :height => 760 do
	background "box_background_2.jpg"
	@image = image"strilka.png", :top=> y , :left=> x - 150
	@seconds = 120
	@paused = true	
	def display_time
		@display.clear do
		title "%02d:%02d:%02d" % [
		@seconds / (60*60),
		@seconds / 60 % 60,
		@seconds % 60
      	] ,:left=> 900,:top =>400
		end
	end
	
	flow do 
		@dumichka = edit_line(:left=>280,:top=>405,:width=>520,:height=>50,:text_size => 23)
		@dumichka.change do
			if(@seconds == 120)
				@paused = false
			end
		end
		@para0 =para red[0] ,:left=> x ,:top => y,:size => 23
		@para1 =para red[1] ,:left=> x ,:top => y+40,:size => 23
		@para2 =para red[2] ,:left=> x ,:top => y+80,:size => 23
		@para3 =para red[3] ,:left=> x ,:top => y+120,:size => 23
		@para4 =para red[4] ,:left=> x ,:top => y+160,:size => 23
		@para5 =para red[5] ,:left=> x ,:top => y+200,:size => 23
		@para6 =para red[6] ,:left=> x ,:top => y+240,:size => 23		
	end
	@display = stack
	display_time
	button "Reset", :width => '11%',:left=>650,:top=>480 do
		@dumichka.text = ''
		@seconds = 120
		@paused = true
		display_time
		y_1=50
		image "glupost.png", :top=>y,:left=> x-200
		image"strilka.png", :top=> y,:left=> x-150
		counter = 1
		score_1 = 0
		score_2=0
		score= 0
		corect=0
		wrong=0
		c=0
		i=0
		@para0.replace(red[i]).style(:stroke => black)
		@para1.replace(red[i+1]).style(:stroke => black)
		@para2.replace(red[i+2]).style(:stroke => black)
		@para3.replace(red[i+3]).style(:stroke => black)
		@para4.replace(red[i+4]).style(:stroke => black)
		@para5.replace(red[i+5]).style (:stroke => black)
		@para6.replace(red[i+6]).style(:stroke => black)
	end
	animate(1) do
		if(@paused == false)
			@seconds -= 1
		end
		if(@seconds >= 0)
			display_time
		end
		if(@seconds == 0)
			@seconds -= 1
			image "glupost.png", :top=>y,:left=> x-200
			score_1 *= 9
			score_2 = wrong + 1
			score = score_1 / score_2
			alert ("corect : #{corect} \n wrong : #{wrong} \n score : #{score}")

			5.times do
				if (records[counter].to_i < score)
					records[counter] = score
					records[counter-1] = ask("You have beat the highscores, enter your name or die:")
					break;
				else
					counter +=2
				end
			end
			@para0.replace("           HIGH SCORES    ")
			@para1.replace("  1 . " + records[0]+ "  -  " + records[1].to_s).style(:stroke => black)
			@para2.replace("  2 . " + records[2]+ "  -  " + records[3].to_s).style(:stroke => black)
			@para3.replace("  3 . " + records[4]+ "  -  " + records[5].to_s).style(:stroke => black)
			@para4.replace("  4 . " + records[6]+ "  -  " + records[7].to_s).style(:stroke => black)
			@para5.replace("  5 . " + records[8]+ "  -  " + records[9].to_s).style(:stroke => black)
			@para6.replace("")
			File.delete("records.txt")
			File.open("records.txt","w") do |file|
				records.each do |element|
					file << element.to_s + "\n"
				end
			end
		end
  	end

keypress do |k|
	if(@seconds >=0 && @paused == false)
		if(k =="\n")
			y_1 += 41
			image "glupost.png", :top=>y,:left=> x-200
			image "strilka.png", :top=> y_1 , :left=> x-150
			input = @dumichka.text
			if (red[i] == input)
				score_1 += red[i].length
				corect += 1
				case c
					when 0
					@para0.style(:stroke => darkgreen)
					when 1
					@para1.style(:stroke => darkgreen)
					when 2
					@para2.style(:stroke => darkgreen)
					when 3
					@para3.style(:stroke => darkgreen)
					when 4
					@para4.style(:stroke => darkgreen)
					when 5
					@para5.style(:stroke => darkgreen)
					y_1=10
				end
			else
				wrong += 1
				case c
					when 0
					@para0.style(:stroke => firebrick)
					when 1
					@para1.style(:stroke => firebrick)
					when 2
					@para2.style(:stroke => firebrick)
					when 3
					@para3.style(:stroke => firebrick)
					when 4
					@para4.style(:stroke => firebrick)
					when 5
					@para5.style(:stroke => firebrick)
					y_1=10
				end
			end
			@dumichka.text = ''
			c+=1
			i+=1
			if(i%7 ==0)
				puts i
				@para0.replace(red[i]).style(:stroke => black)
				@para1.replace(red[i+1]).style(:stroke => black)
				@para2.replace(red[i+2]).style(:stroke => black)
				@para3.replace(red[i+3]).style(:stroke => black)
				@para4.replace(red[i+4]).style(:stroke => black)
				@para5.replace(red[i+5]).style(:stroke => black)
				@para6.replace(red[i+6])
				c=0
			end
		end
	end
end
end
