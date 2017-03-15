module hitdetection( input frame_clk, Reset,
                  input [9:0] frogX1, frogY1,
						input [9:0] truckX1, truckY1, truckX2, truckY2, truckX3, truckY3,
						input [9:0] grayCarX1, grayCarY1, grayCarX2, grayCarY2,
						input [9:0] yellowCarX1, yellowCarY1, yellowCarX2, yellowCarY2, yellowCarX3, yellowCarY3, yellowCarX4, yellowCarY4,
						input [9:0] tractorX1, tractorY1, tractorX2, tractorY2, tractorX3, tractorY3, tractorX4, tractorY4, 
						input stage2x, gameoverx, winreset,
						output frogreset,
                  output [3:0] Life,
						input water, winx,
						output safe1, safe2, safe3, safe4, safe5,
						input safe1x, safe2x, safe3x, safe4x, safe5x
						);
						
	   always_ff @ (posedge frame_clk or posedge Reset )
      begin
            if(Reset) 
				begin
						Life <= 3;
						safe1 <= 0;
						safe2 <= 0;
						safe3 <= 0;
						safe4 <= 0;
						safe5 <= 0;
				end
				
				else if(gameoverx == 1)
				begin
				      Life <= 3;
						safe1 <= 0;
						safe2 <= 0;
						safe3 <= 0;
						safe4 <= 0;
						safe5 <= 0;
				end
				
				else if(winx == 1)
				begin
				      Life <= 3;
						safe1 <= 0;
						safe2 <= 0;
						safe3 <= 0;
						safe4 <= 0;
						safe5 <= 0;
				end
				
				else if(winreset == 1)
				begin
						frogreset <= 1;
						safe1 <= 0;
						safe2 <= 0;
						safe3 <= 0;
						safe4 <= 0;
						safe5 <= 0;
				end
				
				else
				begin
			
				   /********** Walls *************/
				   if( (frogX1+2 > 431) )
				   begin
						frogreset <= 1;
						Life <= Life - 1;
			      end
					else if( (frogX1+13 < 207) )
				   begin
						frogreset <= 1;
						Life <= Life - 1;
			      end
					/********************************/
						
						
					/**************** Truck 1 **************/	
					else if( (frogX1+2 >= truckX1+2) && (frogX1+2 <= truckX1+28) && (frogY1+8 >= truckY1+3 ) && (frogY1+8 <= truckY1+12) )
			      begin
						frogreset <= 1;
						Life <= Life - 1;
			      end
					else if( (frogX1+13 >= truckX1+2) && (frogX1+13 <= truckX1+28) && (frogY1+8 >= truckY1+3 ) && (frogY1+8 <= truckY1+12) )
			      begin
						frogreset <= 1;
						Life <= Life - 1;
			      end
	
					else if( (frogX1+2 >= truckX2+2) && (frogX1+2 <= truckX2+28) && (frogY1+8 >= truckY2+3 ) && (frogY1+8 <= truckY2+12) )
			      begin
						frogreset <= 1;
						Life <= Life - 1;
			      end
					else if( (frogX1+13 >= truckX2+2) && (frogX1+13 <= truckX2+28) && (frogY1+8 >= truckY2+3 ) && (frogY1+8 <= truckY2+12) )
			      begin
						frogreset <= 1;
						Life <= Life - 1;
			      end
			
					else if( stage2x == 1 && (frogX1+2 >= truckX3+2) && (frogX1+2 <= truckX3+28) && (frogY1+8 >= truckY3+3 ) && (frogY1+8 <= truckY3+12) )
			      begin
						frogreset <= 1;
						Life <= Life - 1;
			      end
					else if( stage2x == 1 && (frogX1+13 >= truckX3+2) && (frogX1+13 <= truckX3+28) && (frogY1+8 >= truckY3+3 ) && (frogY1+8 <= truckY3+12) )
			      begin
						frogreset <= 1;
						Life <= Life - 1;
			      end
					
					
					/**************** Gray Cars **************/	
					else if( (frogX1+2 >= grayCarX1) && (frogX1+2 <= grayCarX1+15) && (frogY1+8 >= grayCarY1 ) && (frogY1+8 <= grayCarY1+15) )
			      begin
						frogreset <= 1;
						Life <= Life - 1;
			      end
					else if( (frogX1+13 >= grayCarX1) && (frogX1+13 <= grayCarX1+15) && (frogY1+8 >= grayCarY1 ) && (frogY1+8 <= grayCarY1+15) )
			      begin
						frogreset <= 1;
						Life <= Life - 1;
			      end
	
					else if( stage2x == 1 && (frogX1+2 >= grayCarX2) && (frogX1+2 <= grayCarX2+15) && (frogY1+8 >= grayCarY2 ) && (frogY1+8 <= grayCarY2+15) )
			      begin
						frogreset <= 1;
						Life <= Life - 1;
			      end
					else if( stage2x == 1 && (frogX1+13 >= grayCarX2) && (frogX1+13 <= grayCarX2+15) && (frogY1+8 >= grayCarY2 ) && (frogY1+8 <= grayCarY2+15) )
			      begin
						frogreset <= 1;
						Life <= Life - 1;
			      end
					
					/**************** Yellow Cars **************/	
					else if( (frogX1+2 >= yellowCarX1) && (frogX1+2 <= yellowCarX1+15) && (frogY1+8 >= yellowCarY1 ) && (frogY1+8 <= yellowCarY1+15) )
			      begin
						frogreset <= 1;
						Life <= Life - 1;
			      end
					else if( (frogX1+13 >= yellowCarX1) && (frogX1+13 <= yellowCarX1+15) && (frogY1+8 >= yellowCarY1 ) && (frogY1+8 <= yellowCarY1+15) )
			      begin
						frogreset <= 1;
						Life <= Life - 1;
			      end
	
					else if((frogX1+2 >= yellowCarX2) && (frogX1+2 <= yellowCarX2+15) && (frogY1+8 >= yellowCarY2 ) && (frogY1+8 <= yellowCarY2+15) )
			      begin
						frogreset <= 1;
						Life <= Life - 1;
			      end
					else if((frogX1+13 >= yellowCarX2) && (frogX1+13 <= yellowCarX2+15) && (frogY1+8 >= yellowCarY2 ) && (frogY1+8 <= yellowCarY2+15) )
			      begin
						frogreset <= 1;
						Life <= Life - 1;
			      end
					
					else if( (frogX1+2 >= yellowCarX3) && (frogX1+2 <= yellowCarX3+15) && (frogY1+8 >= yellowCarY3 ) && (frogY1+8 <= yellowCarY3+15) )
			      begin
						frogreset <= 1;
						Life <= Life - 1;
			      end
					else if( (frogX1+13 >= yellowCarX3) && (frogX1+13 <= yellowCarX3+15) && (frogY1+8 >= yellowCarY3 ) && (frogY1+8 <= yellowCarY3+15) )
			      begin
						frogreset <= 1;
						Life <= Life - 1;
			      end
	
					else if( stage2x == 1 && (frogX1+2 >= yellowCarX4) && (frogX1+2 <= yellowCarX4+15) && (frogY1+8 >= yellowCarY4 ) && (frogY1+8 <= yellowCarY4+15) )
			      begin
						frogreset <= 1;
						Life <= Life - 1;
			      end
					else if( stage2x == 1 && (frogX1+13 >= yellowCarX4) && (frogX1+13 <= yellowCarX4+15) && (frogY1+8 >= yellowCarY4 ) && (frogY1+8 <= yellowCarY4+15) )
			      begin
						frogreset <= 1;
						Life <= Life - 1;
			      end
					
					/**************** Tractors **************/	
					else if( (frogX1+2 >= tractorX1) && (frogX1+2 <= tractorX1+15) && (frogY1+8 >= tractorY1 ) && (frogY1+8 <= tractorY1+15) )
			      begin
						frogreset <= 1;
						Life <= Life - 1;
			      end
					else if( (frogX1+13 >= tractorX1) && (frogX1+13 <= tractorX1+15) && (frogY1+8 >= tractorY1 ) && (frogY1+8 <= tractorY1+15) )
			      begin
						frogreset <= 1;
						Life <= Life - 1;
			      end
	
					else if((frogX1+2 >= tractorX2) && (frogX1+2 <= tractorX2+15) && (frogY1+8 >= tractorY2 ) && (frogY1+8 <= tractorY2+15) )
			      begin
						frogreset <= 1;
						Life <= Life - 1;
			      end
					else if((frogX1+13 >= tractorX2) && (frogX1+13 <= tractorX2+15) && (frogY1+8 >= tractorY2 ) && (frogY1+8 <= tractorY2+15) )
			      begin
						frogreset <= 1;
						Life <= Life - 1;
			      end
					
					else if( (frogX1+2 >= tractorX3) && (frogX1+2 <= tractorX3+15) && (frogY1+8 >= tractorY3 ) && (frogY1+8 <= tractorY3+15) )
			      begin
						frogreset <= 1;
						Life <= Life - 1;
			      end
					else if( (frogX1+13 >= tractorX3) && (frogX1+13 <= tractorX3+15) && (frogY1+8 >= tractorY3 ) && (frogY1+8 <= tractorY3+15) )
			      begin
						frogreset <= 1;
						Life <= Life - 1;
			      end
	
					else if( stage2x == 1 && (frogX1+2 >= tractorX4) && (frogX1+2 <= tractorX4+15) && (frogY1+8 >= tractorY4 ) && (frogY1+8 <= tractorY4+15) )
			      begin
						frogreset <= 1;
						Life <= Life - 1;
			      end
					else if( stage2x == 1 && (frogX1+13 >= tractorX4) && (frogX1+13 <= tractorX4+15) && (frogY1+8 >= tractorY4 ) && (frogY1+8 <= tractorY4+15) )
			      begin
						frogreset <= 1;
						Life <= Life - 1;
			      end
					
					/************** Win detection **************/
					else if( safe1 == 0 && safe1x == 0 && frogX1+2 >= 215 && frogX1+13 <= 239 && frogY1+8 <= 160)
					begin
						frogreset <= 1;
						safe1 <= 1;
					end
					
					else if( safe2 == 0 && safe2x == 0 && frogX1+2 >= 259 && frogX1+13 <= 283 && frogY1+8 <= 160)
					begin
						frogreset <= 1;
						safe2 <= 1;
					end
					
					else if( safe3 == 0 && safe3x == 0 && frogX1+2 >= 307 && frogX1+13 <= 331 && frogY1+8 <= 160)
					begin
						frogreset <= 1;
						safe3 <= 1;
					end
					
					else if( safe4 == 0 && safe4x == 0 && frogX1+2 >= 355 && frogX1+13 <= 379 && frogY1+8 <= 160)
					begin
						frogreset <= 1;
						safe4 <= 1;
					end
					
					else if( safe5 == 0 && safe5x == 0 && frogX1+2 >= 399 && frogX1+13 <= 423 && frogY1+8 <= 160)
					begin
						frogreset <= 1;
						safe5 <= 1;
					end
					
					/************ water *************/
					else if(water == 1)
					begin
						frogreset <= 1;
						Life <= Life - 1;
					end
					
					else
					begin
						frogreset <= 0;
					end
					
				end
		end 
		
endmodule