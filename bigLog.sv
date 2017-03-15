module  bigLog ( input Reset, frame_clk,
					   input [9:0] bigLogXCenter, bigLogYCenter,
                  output [9:0]  bigLogX, bigLogY,
						output moved);
			
    logic [9:0] bigLog_X_Pos;
	
	 logic [21:0] counter;
	 
    //parameter [9:0] Ball_X_Center=448;  // Center position on the X axis
    
	 always_ff @ (posedge Reset or posedge frame_clk )
	 begin: Move_bigLog
	  
	 if (Reset)  // Asynchronous Reset
		 begin 
		    bigLog_X_Pos <= bigLogXCenter;
			 counter <= 0;
			 moved <= 0;
		 end	
	  
	 else if(counter == 1500000)
		 begin 
			 if ((bigLog_X_Pos) > 431)  // bigLog reaches left screen
			 begin		
				  bigLog_X_Pos = 207-64;
			 end
			
			 else
			 begin
				  bigLog_X_Pos = bigLog_X_Pos + 1;
			 end
			 
			 moved = 1;
			 counter = 0;
		 end  
		
	  else
			 begin
				 moved = 0;
				 counter = counter + 1;
			 end
     end
      
		
     assign bigLogX = bigLog_X_Pos;
   
     assign bigLogY = bigLogYCenter;
    
endmodule
