module  fishTwo ( input Reset, frame_clk,
					   input [9:0] fishTwoCenter,
                  output [9:0]  fishTwoX, fishTwoY,
						output moved);
			
    logic [9:0] fishTwo_X_Pos;
	
	 logic [21:0] counter;
	 
    //parameter [9:0] Ball_X_Center=448;  // Center position on the X axis
    
	 always_ff @ (posedge Reset or posedge frame_clk )
	 begin: Move_fishTwo
	  
	 if (Reset)  // Asynchronous Reset
		 begin 
		    fishTwo_X_Pos <= fishTwoCenter;
			 counter <= 0;
			 moved <= 0;
		 end	
	  
	 else if(counter == 2500000)
		 begin 
			 if ((fishTwo_X_Pos + 32) < 207)  // fishTwo reaches left screen
			 begin		
				  fishTwo_X_Pos = 431;
			 end
			
			 else
			 begin
				  fishTwo_X_Pos = fishTwo_X_Pos - 1;
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
      
		
     assign fishTwoX = fishTwo_X_Pos;
   
     assign fishTwoY = 182;
    
endmodule
