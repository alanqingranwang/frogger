module  truck ( input Reset, frame_clk,
					 input [9:0] truckCenter,
					 input stage2x,
               output [9:0]  truckX, truckY);
			
    logic [9:0] truck_X_Pos;
	
	 logic [20:0] counter;
	 
    //parameter [9:0] Ball_X_Center=448;  // Center position on the X axis
    
	 always_ff @ (posedge Reset or posedge frame_clk )
	 begin: Move_truck
	  
	 if (Reset)  // Asynchronous Reset
		 begin 
		    truck_X_Pos <= truckCenter;
			 counter <= 0;
		 end	
	  
	  else if(stage2x == 0)
	  begin
	    if(counter == 1500000)
		 begin 
			 if ((truck_X_Pos + 32) < 207)  // truck reaches left screen
			 begin		
				  truck_X_Pos = 431;
			 end
			
			 else
			 begin
				  truck_X_Pos = truck_X_Pos - 1;
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
	    if(counter == 500000)
		 begin 
			 if ((truck_X_Pos + 32) < 207)  // truck reaches left screen
			 begin		
				  truck_X_Pos = 431;
			 end
			
			 else
			 begin
				  truck_X_Pos = truck_X_Pos - 1;
			 end
				  
			 counter = 0;
		 end  
		 else
			 begin
				 counter = counter + 1;
			 end
	  end
	end
		
     assign truckX = truck_X_Pos;
   
     assign truckY = 258;
    
endmodule
