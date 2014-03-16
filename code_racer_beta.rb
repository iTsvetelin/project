red = Array.new()

corect=0
wrong=0
i=0
File.open("mandja.txt").each do |line|
	red << line.gsub(/\n/, "")
end


Shoes.app :width => 1360, :height => 760 do
	background "box_background.jpg"
	@seconds = 60
	@pause = true
	button("Start Timer",:left=> 800,:top=>500)do
		@paused = !@paused
	end
	flow do 
		@dumichka = edit_line(:left=>290,:top=>380,:width=>500,:height=>50,:text_size => 23)
		@para0 =para red[0] ,:left=> 290 ,:top => 50,:size => 23
		@para1 =para red[1] ,:left=> 290 ,:top => 90,:size => 23
		@para2 =para red[2] ,:left=> 290 ,:top => 130,:size => 23
		@para3 =para red[3] ,:left=> 290 ,:top => 170,:size => 23
		@para4 =para red[4] ,:left=> 290 ,:top => 210,:size => 23
		@para5 =para red[5] ,:left=> 290 ,:top => 250,:size => 23
		@para6 =para red[6] ,:left=> 290 ,:top => 290,:size => 23

		button("ready",:left=> 800,:top=>600) do
				alert ("corect : #{corect} \n wrong : #{wrong}")
		end
	end

	def display_time
		@display.clear do
		title "%02d:%02d:%02d" % [
		@seconds / (60*60),
		@seconds / 60 % 60,
		@seconds % 60
      	] ,:left=> 900,:top =>400
		end
	end

	@display = stack
	display_time
	button "Reset", :width => '5%',:left=>800,:top=>550 do
		@seconds = 60
		display_time
	end
	animate(1) do
			@seconds -= 1 unless @seconds==0
			display_time

  	end

	#@push = button "Push Me"
	keypress do |k|
		if(k =="\n")
			input = @dumichka.text
			puts input
			if (red[i] == input)
				corect += 1
			else
				wrong += 1
			end
			puts @dumichka
			@dumichka.text = ''
			i+=1
			if(i%7 ==0)
				@para0.replace(red[i])
				@para1.replace(red[i+1])
				@para2.replace(red[i+2])
				@para3.replace(red[i+3])
				@para4.replace(red[i+4])
				@para5.replace(red[i+5])
				@para6.replace(red[i+6])
			end
		end
	end	
end
