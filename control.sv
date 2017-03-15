module control(	
						input Clk, Reset,
						input [3:0] Life1,
						input [3:0] Life2,
						input frogwins,
						input [15:0] keycode,
						
						output startx, winx, gameoverx,
						output stage1x, stage2x,
						output player2, winreset,
						output holdx
						);
						
	enum logic [9:0] {start, stage1single, holdsingle, stage2single, gameover, win,
									 stage1multi, holdmulti, stage2multi} state, next_state;
	
	
	logic [20:0] counter1, counter2;
	always_ff @ (posedge Clk or posedge Reset )
    begin
        if (Reset) 
		  begin
            state <= start;
				counter1 <= 0;
				counter2 <= 0;
	     end
				
        else
		  begin
            state <= next_state;	
				if (state == holdsingle)
					counter1 <= counter1 + 1;
					
				if (state == holdmulti)
					counter2 <= counter2 + 1;
					
		  end
	 end
	 
	 
	always_comb
	begin 
	    next_state  = state;
	 
	    case (state)
	    	start:
			begin
	    		if(keycode == 16'h001e)
	    			next_state = stage1single;
					
				else if(keycode == 16'h001f)
				   next_state = stage1multi;
					
				else if(keycode == 16'h0012)
				   next_state = stage2single;
					
				else if(keycode == 16'h0013)
				   next_state = stage2multi;
					
	    		else
	    			next_state = start;
			end
					
			stage1single:
			begin
				if(Life1 == 0)
					next_state = gameover;
				else if(frogwins == 1)
				   next_state = holdsingle;
					
				else if(keycode == 16'h001d)
					next_state = start;
				else 
					next_state = stage1single;
			end
		 
		   holdsingle:
			begin
				if(keycode == 16'h0028)
					next_state = stage2single;
				else 
					next_state = holdsingle;
			end
		 
			stage2single:
			begin
				if(Life1 == 0)
					next_state = gameover;
				else if(frogwins == 1)
					next_state = win;
			   else if(keycode == 16'h001d)
					next_state = start;
				else 
					next_state = stage2single;
			end
				
			stage1multi:
			begin
				if(Life1 == 0 && Life2 == 0)
					next_state = gameover;
				else if(frogwins == 1)
				   next_state = holdmulti;
				else if(keycode == 16'h001d)
					next_state = start;
				else 
					next_state = stage1multi;
			end
		 
		   holdmulti:
			begin
				if(keycode == 16'h0028)
					next_state = stage2multi;
				else 
					next_state = holdmulti;
			end
		 
			stage2multi:
			begin
				if(Life1 == 0 && Life2 == 0)
					next_state = gameover;
				else if(frogwins == 1)
					next_state = win;
				else if(keycode == 16'h001d)
					next_state = start;
				else 
					next_state = stage2multi;
			end
			
			win:
			begin
				if(keycode == 16'h0028)
	    			next_state = start;
	    		else
	    			next_state = win;
			end
			
			gameover:
			begin
				if(keycode == 16'h0028)
	    			next_state = start;
	    		else
	    			next_state = gameover;
			end
			
		endcase
	end
	
	always_comb
	begin
		startx = 0;
		gameoverx = 0;
		winx = 0;
		stage1x = 0;
		stage2x = 0;
		player2 = 0;
		winreset = 0;
		holdx = 0;
		
		case (state) 
			start:
			begin
				startx = 1;
			end
			
			stage1single:
			begin
				stage1x = 1;
			end
			
			holdsingle:
			begin
				stage2x = 1;
				winreset = 1;
				holdx = 1;
			end
			
			stage2single:
			begin
				stage2x = 1;
			end
			
			stage1multi:
			begin
				stage1x = 1;
				player2 = 1;
			end
			
			holdmulti:
			begin
				stage2x = 1;
				player2 = 1;
				winreset = 1;
				holdx = 1;
			end
			
			stage2multi:
			begin
				stage2x = 1;
				player2 = 1;
			end
			
			win:
			begin
				winx = 1;
			end
			
			gameover:
			begin
				gameoverx = 1;
			end
			
		endcase
	end						
						
endmodule