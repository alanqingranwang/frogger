module  grayCar ( input Reset, frame_clk,
					   input [9:0] grayCarCenter,
						input stage2x,
                  output [9:0]  grayCarX, grayCarY);
			
    logic [9:0] grayCar_X_Pos;
	
	 logic [21:0] counter;
	 
    //parameter [9:0] Ball_X_Center=448;  // Center position on the X axis
    
	 always_ff @ (posedge Reset or posedge frame_clk )
	 begin: Move_grayCar
	  
	 if (Reset)  // Asynchronous Reset
	 begin 
		 grayCar_X_Pos <= grayCarCenter;
		 counter <= 0;
	 end	
	  
	 else if (stage2x == 0) 
	 begin
		 if(counter == 1000000)
		 begin 
			 if ((grayCar_X_Pos) > 431)  // grayCar reaches right screen
			 begin		
				  grayCar_X_Pos = 207-16;
			 end
			
			 else
			 begin
				  grayCar_X_Pos = grayCar_X_Pos + 1;
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
		 if(counter == 250000)
		 begin 
			 if ((grayCar_X_Pos) > 431)  // grayCar reaches right screen
			 begin		
				  grayCar_X_Pos = 207-16;
			 end
			
			 else
			 begin
				  grayCar_X_Pos = grayCar_X_Pos + 1;
			 end
				  
			 counter = 0;
		 end  
			
		 else
		 begin
			 counter = counter + 1;
		 end
	  end

      end
		
     assign grayCarX = grayCar_X_Pos;
   
     assign grayCarY = 278;
    
endmodule
