module  log ( input Reset, frame_clk,
					   input [9:0] logXCenter, logYCenter,
                  output [9:0]  logX, logY,
						output moved);
			
    logic [9:0] log_X_Pos;
	
	 logic [23:0] counter;
	 
    //parameter [9:0] Ball_X_Center=448;  // Center position on the X axis
    
	 always_ff @ (posedge Reset or posedge frame_clk )
	 begin: Move_log
	  
	 if (Reset)  // Asynchronous Reset
		 begin 
		    log_X_Pos <= logXCenter;
			 counter <= 0;
			 moved <= 0;
		 end	
	  
	 else if(counter == 5000000)
		 begin 
			 if ((log_X_Pos) > 431)  // log reaches left screen
			 begin		
				  log_X_Pos = 207-48;
			 end
			
			 else
			 begin
				  log_X_Pos = log_X_Pos + 1;
			 end
				  
			 moved = 1;  
			 counter = 0;
		 end  
		
	  else
			 begin
				 counter = counter + 1;
				 moved = 0;
			 end
     end
      
		
     assign logX = log_X_Pos;
   
     assign logY = logYCenter;
    
endmodule
