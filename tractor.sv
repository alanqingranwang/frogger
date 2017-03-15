module  tractor ( input Reset, frame_clk,
					   input [9:0] tractorCenter,
						input stage2x,
                  output [9:0]  tractorX, tractorY);
			
    logic [9:0] tractor_X_Pos;
	
	 logic [21:0] counter;
	 
    //parameter [9:0] Ball_X_Center=448;  // Center position on the X axis
    
	 always_ff @ (posedge Reset or posedge frame_clk )
	 begin: Move_tractor
	  
	 if (Reset)  // Asynchronous Reset
	 begin 
		 tractor_X_Pos <= tractorCenter;
		 counter <= 0;
	 end	
	  
	 else if(stage2x == 0)
	 begin 
		 if(counter == 3000000)
		 begin 
			 if ((tractor_X_Pos) > 431)  // tractor reaches left screen
			 begin		
				  tractor_X_Pos = 207-16;
			 end
			
			 else
			 begin
				  tractor_X_Pos = tractor_X_Pos + 1;
			 end
				  
			 counter = 0;
		 end  
			
		 else
		 begin
			 counter = counter + 1;
		 end
    end 
	  
	  else
	  begin 
		 if(counter == 1000000)
			 begin 
				 if ((tractor_X_Pos) > 431)  // tractor reaches left screen
				 begin		
					  tractor_X_Pos = 207-16;
				 end
				
				 else
				 begin
					  tractor_X_Pos = tractor_X_Pos + 1;
				 end
					  
				 counter = 0;
			 end  
			
		  else
				 begin
					 counter = counter + 1;
				 end
		  end
     end 
	  
     assign tractorX = tractor_X_Pos;
   
     assign tractorY = 318;
    
endmodule
