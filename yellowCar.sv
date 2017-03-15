module  yellowCar ( input Reset, frame_clk,
					   input [9:0] yellowCarCenter,
						input stage2x,
                  output [9:0]  yellowCarX, yellowCarY);
			
    logic [9:0] yellowCar_X_Pos;
	
	 logic [21:0] counter;
	 
    //parameter [9:0] Ball_X_Center=448;  // Center position on the X axis
    
	 always_ff @ (posedge Reset or posedge frame_clk )
	 begin: Move_yellowCar
	  
	 if (Reset)  // Asynchronous Reset
	 begin 
		 yellowCar_X_Pos <= yellowCarCenter;
		 counter <= 0;
	 end	
	 
	 else if(stage2x == 0)
	 begin 
		 if(counter == 3000000)
		 begin 
			 if ((yellowCar_X_Pos + 32) < 207)  // yellowCar reaches left screen
			 begin		
				  yellowCar_X_Pos = 431;
			 end
			
			 else
			 begin
				  yellowCar_X_Pos = yellowCar_X_Pos - 1;
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
			 if ((yellowCar_X_Pos + 32) < 207)  // yellowCar reaches left screen
			 begin		
				  yellowCar_X_Pos = 431;
			 end
			
			 else
			 begin
				  yellowCar_X_Pos = yellowCar_X_Pos - 1;
			 end
				  
			 counter = 0;
		 end  
		  
		 else
			 begin
				 counter = counter + 1;
			 end
		 end
     end 
	  
     assign yellowCarX = yellowCar_X_Pos;
   
     assign yellowCarY = 298;
    
endmodule
