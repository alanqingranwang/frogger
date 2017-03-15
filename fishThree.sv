module  fishThree ( input Reset, frame_clk,
					     input  [9:0] fishThreeCenter,
                    output [9:0]  fishThreeX, fishThreeY,
						  input stage2x,
						  output moved,
						  output [21:0] counterx);
			
    logic [9:0] fishThree_X_Pos;
	
	 logic [21:0] counter;
	 
    //parameter [9:0] Ball_X_Center=448;  // Center position on the X axis
    
	 always_ff @ (posedge Reset or posedge frame_clk )
	 begin: Move_fishThree
	  
	 if (Reset)  // Asynchronous Reset
	 begin 
		 fishThree_X_Pos <= fishThreeCenter;
		 counter <= 0;
		 moved <= 0;
	 end	
	  
	 else if(stage2x == 0)
	 begin 
		 if(counter == 1000000)
		 begin 
			 if ((fishThree_X_Pos + 48) < 207)  // fishThree reaches left screen
			 begin		
				  fishThree_X_Pos = 431;
			 end
			
			 else
			 begin
				  fishThree_X_Pos = fishThree_X_Pos - 1;
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
	  
	 else
	 begin
		  if(counter == 700000)
			 begin 
				 if ((fishThree_X_Pos + 48) < 207)  // fishThree reaches left screen
				 begin		
					  fishThree_X_Pos = 431;
				 end
				
				 else
				 begin
					  fishThree_X_Pos = fishThree_X_Pos - 1;
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
  end
      
	  assign counterx = counter;	
     assign fishThreeX = fishThree_X_Pos;
   
     assign fishThreeY = 222;
    
endmodule
