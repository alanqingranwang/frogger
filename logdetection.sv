module logdetection( input frame_clk, Reset,
                  input [9:0] frogX1, frogY1,
					   input [9:0] fishThreeX1, fishThreeY1,
						input [9:0] fishThreeX2, fishThreeY2,
						input [9:0] fishThreeX3, fishThreeY3,
						input [9:0] logX1, logY1,
						input [9:0] logX2, logY2,
						input [9:0] logX3, logY3,
						input [9:0] fishTwoX1, fishTwoY1,
						input [9:0] fishTwoX2, fishTwoY2,
						input [9:0] fishTwoX3, fishTwoY3,
						input [9:0] fishTwoX4, fishTwoY4,
						input [9:0] fishTwoX5, fishTwoY5,
						input [9:0] bigLogX1, bigLogY1,
						input [9:0] bigLogX2, bigLogY2,
						input [9:0] bigLogX3, bigLogY3,
						input stage2x,
						output onfish3, onlog, onfish2, onbiglog, water);
						
	   always_ff @ (posedge frame_clk or posedge Reset )
      begin
               if(Reset)
					begin
						onfish3 <= 0;
						onlog <= 0;
						onfish2 <= 0;
						onbiglog <= 0;
						water <= 0;
					end
					
			      else if(frogY1 >= 230)
					begin
						onfish3 <= 0;
						onlog <= 0;
						onfish2 <= 0;
						onbiglog <= 0;
						water <= 0;
					end
				   
					/**************** FishThree 1 **************/	
					else if( (frogX1+2 >= fishThreeX1+1) && (frogX1+2 <= fishThreeX1+44) && (frogY1+8 >= fishThreeY1 ) && (frogY1+8 <= fishThreeY1+15) )
			      begin
						onfish3 <= 1;
						onlog <= 0;
						onfish2 <= 0;
						onbiglog <= 0;
						water <= 0;
			      end
					else if( (frogX1+13 >= fishThreeX1+1) && (frogX1+13 <= fishThreeX1+44) && (frogY1+8 >= fishThreeY1 ) && (frogY1+8 <= fishThreeY1+15) )
			      begin
						onfish3 <= 1;
						onlog <= 0;
						onfish2 <= 0;
						onbiglog <= 0;
						water <= 0;
			      end
					
					/**************** FishThree 2 **************/	
					else if( (frogX1+2 >= fishThreeX2+1) && (frogX1+2 <= fishThreeX2+44) && (frogY1+8 >= fishThreeY2 ) && (frogY1+8 <= fishThreeY2+15) )
			      begin
						onfish3 <= 1;
						onlog <= 0;
						onfish2 <= 0;
						onbiglog <= 0;
						water <= 0;
			      end
					else if( (frogX1+13 >= fishThreeX2+1) && (frogX1+13 <= fishThreeX2+44) && (frogY1+8 >= fishThreeY2 ) && (frogY1+8 <= fishThreeY2+15) )
			      begin
						onfish3 <= 1;
						onlog <= 0;
						onfish2 <= 0;
						onbiglog <= 0;
						water <= 0;
			      end
					
					/**************** FishThree 3 **************/	
					else if( (frogX1+2 >= fishThreeX3+1) && (frogX1+2 <= fishThreeX3+44) && (frogY1+8 >= fishThreeY3 ) && (frogY1+8 <= fishThreeY3+15) )
			      begin
						onfish3 <= 1;
						onlog <= 0;
						onfish2 <= 0;
						onbiglog <= 0;
						water <= 0;
			      end
					else if( (frogX1+13 >= fishThreeX3+1) && (frogX1+13 <= fishThreeX3+44) && (frogY1+8 >= fishThreeY3 ) && (frogY1+8 <= fishThreeY3+15) )
			      begin
						onfish3 <= 1;
						onlog <= 0;
						onfish2 <= 0;
						onbiglog <= 0;
						water <= 0;
			      end
	
					/**************** Log 1 **************/	
					else if( (frogX1+2 >= logX1+4) && (frogX1+2 <= logX1+43) && (frogY1+8 >= logY1 ) && (frogY1+8 <= logY1+15) )
			      begin
						onlog <= 1;
						onfish3 <= 0;
						onfish2 <= 0;
						onbiglog <= 0;
						water <= 0;
			      end
					else if( (frogX1+13 >= logX1+4) && (frogX1+13 <= logX1+43) && (frogY1+8 >= logY1 ) && (frogY1+8 <= logY1+15) )
			      begin
						onlog <= 1;
						onfish3 <= 0;
						onfish2 <= 0;
						onbiglog <= 0;
						water <= 0;
			      end
					
					/**************** Log 2 **************/	
					else if( (frogX1+2 >= logX2+4) && (frogX1+2 <= logX2+43) && (frogY1+8 >= logY2 ) && (frogY1+8 <= logY2+15) )
			      begin
						onlog <= 1;
						onfish3 <= 0;
						onfish2 <= 0;
						onbiglog <= 0;
						water <= 0;
			      end
					else if( (frogX1+13 >= logX2+4) && (frogX1+13 <= logX2+43) && (frogY1+8 >= logY2 ) && (frogY1+8 <= logY2+15) )
			      begin
						onlog <= 1;
						onfish3 <= 0;
						onfish2 <= 0;
						onbiglog <= 0;
						water <= 0;
			      end
					
					/**************** Log 3 **************/	
					else if( (frogX1+2 >= logX3+4) && (frogX1+2 <= logX3+43) && (frogY1+8 >= logY3 ) && (frogY1+8 <= logY3+15) )
			      begin
						onlog <= 1;
						onfish3 <= 0;
						onfish2 <= 0;
						onbiglog <= 0;
						water <= 0;
			      end
					else if( (frogX1+13 >= logX3+4) && (frogX1+13 <= logX3+43) && (frogY1+8 >= logY3 ) && (frogY1+8 <= logY3+15) )
			      begin
						onlog <= 1;
						onfish3 <= 0;
						onfish2 <= 0;
						onbiglog <= 0;
						water <= 0;
			      end
					
					/**************** FishTwo 1 **************/	
					else if( (frogX1+2 >= fishTwoX1+1) && (frogX1+2 <= fishTwoX1+28) && (frogY1+8 >= fishTwoY1 ) && (frogY1+8 <= fishTwoY1+15) )
			      begin
						onfish2 <= 1;
						onlog <= 0;
						onfish3 <= 0;
						onbiglog <= 0;
						water <= 0;
			      end
					else if( (frogX1+13 >= fishTwoX1+1) && (frogX1+13 <= fishTwoX1+28) && (frogY1+8 >= fishTwoY1 ) && (frogY1+8 <= fishTwoY1+15) )
			      begin
						onfish2 <= 1;
						onlog <= 0;
						onfish3 <= 0;
						onbiglog <= 0;
						water <= 0;
			      end
					
					/**************** FishTwo 2 **************/	
					else if( (frogX1+2 >= fishTwoX2+1) && (frogX1+2 <= fishTwoX2+28) && (frogY1+8 >= fishTwoY2 ) && (frogY1+8 <= fishTwoY2+15) )
			      begin
						onfish2 <= 1;
						onlog <= 0;
						onfish3 <= 0;
						onbiglog <= 0;
						water <= 0;
			      end
					else if( (frogX1+13 >= fishTwoX2+1) && (frogX1+13 <= fishTwoX2+28) && (frogY1+8 >= fishTwoY2 ) && (frogY1+8 <= fishTwoY2+15) )
			      begin
						onfish2 <= 1;
						onlog <= 0;
						onfish3 <= 0;
						onbiglog <= 0;
						water <= 0;
			      end
					
					/**************** FishTwo 3 **************/	
					else if( (frogX1+2 >= fishTwoX3+1) && (frogX1+2 <= fishTwoX3+28) && (frogY1+8 >= fishTwoY3 ) && (frogY1+8 <= fishTwoY3+15) )
			      begin
						onfish2 <= 1;
						onlog <= 0;
						onfish3 <= 0;
						onbiglog <= 0;
						water <= 0;
			      end
					else if( (frogX1+13 >= fishTwoX3+1) && (frogX1+13 <= fishTwoX3+28) && (frogY1+8 >= fishTwoY3 ) && (frogY1+8 <= fishTwoY3+15) )
			      begin
						onfish2 <= 1;
						onlog <= 0;
						onfish3 <= 0;
						onbiglog <= 0;
						water <= 0;
			      end
					
					/**************** FishTwo 4 **************/	
					else if( (frogX1+2 >= fishTwoX4+1) && (frogX1+2 <= fishTwoX4+28) && (frogY1+8 >= fishTwoY4 ) && (frogY1+8 <= fishTwoY4+15) )
			      begin
						onfish2 <= 1;
						onlog <= 0;
						onfish3 <= 0;
						onbiglog <= 0;
						water <= 0;
			      end
					else if( (frogX1+13 >= fishTwoX4+1) && (frogX1+13 <= fishTwoX4+28) && (frogY1+8 >= fishTwoY4 ) && (frogY1+8 <= fishTwoY4+15) )
			      begin
						onfish2 <= 1;
						onlog <= 0;
						onfish3 <= 0;
						onbiglog <= 0;
						water <= 0;
			      end
					
					/**************** FishTwo 5 **************/	
					else if( (frogX1+2 >= fishTwoX5+1) && (frogX1+2 <= fishTwoX5+28) && (frogY1+8 >= fishTwoY5 ) && (frogY1+8 <= fishTwoY5+15) )
			      begin
						onfish2 <= 1;
						onlog <= 0;
						onfish3 <= 0;
						onbiglog <= 0;
						water <= 0;
			      end
					else if( (frogX1+13 >= fishTwoX5+1) && (frogX1+13 <= fishTwoX5+28) && (frogY1+8 >= fishTwoY5 ) && (frogY1+8 <= fishTwoY5+15) )
			      begin
						onfish2 <= 1;
						onlog <= 0;
						onfish3 <= 0;
						onbiglog <= 0;
						water <= 0;
			      end
					
					/**************** Big Log 1 **************/	
					else if( (frogX1+2 >= bigLogX1+4) && (frogX1+2 <= bigLogX1+59) && (frogY1+8 >= bigLogY1 ) && (frogY1+8 <= bigLogY1+15) )
			      begin
						onlog <= 0;
						onfish3 <= 0;
						onfish2 <= 0;
						onbiglog <= 1;
						water <= 0;
			      end
					else if( (frogX1+13 >= bigLogX1+4) && (frogX1+13 <= bigLogX1+59) && (frogY1+8 >= bigLogY1 ) && (frogY1+8 <= bigLogY1+15) )
			      begin
						onlog <= 0;
						onfish3 <= 0;
						onfish2 <= 0;
						onbiglog <= 1;
						water <= 0;
			      end
					
					/**************** Big Log 2 **************/	
					else if( (frogX1+2 >= bigLogX2+4) && (frogX1+2 <= bigLogX2+59) && (frogY1+8 >= bigLogY2 ) && (frogY1+8 <= bigLogY2+15) )
			      begin
						onlog <= 0;
						onfish3 <= 0;
						onfish2 <= 0;
						onbiglog <= 1;
						water <= 0;
			      end
					else if( (frogX1+13 >= bigLogX2+4) && (frogX1+13 <= bigLogX2+59) && (frogY1+8 >= bigLogY2 ) && (frogY1+8 <= bigLogY2+15) )
			      begin
						onlog <= 0;
						onfish3 <= 0;
						onfish2 <= 0;
						onbiglog <= 1;
						water <= 0;
			      end
					
					/**************** Big Log 3 **************/	
					else if( (frogX1+2 >= bigLogX3+4) && (frogX1+2 <= bigLogX3+59) && (frogY1+8 >= bigLogY3 ) && (frogY1+8 <= bigLogY3+15) )
			      begin
						onlog <= 0;
						onfish3 <= 0;
						onfish2 <= 0;
						onbiglog <= 1;
						water <= 0;
			      end
					else if( (frogX1+13 >= bigLogX3+4) && (frogX1+13 <= bigLogX3+59) && (frogY1+8 >= bigLogY3 ) && (frogY1+8 <= bigLogY3+15) )
			      begin
						onlog <= 0;
						onfish3 <= 0;
						onfish2 <= 0;
						onbiglog <= 1;
						water <= 0;
			      end
					
					else
					begin
					   onlog <= 0;
						onfish3 <= 0;
						onfish2 <= 0;
						onbiglog <= 0;
						water <= 1;
					end
				
		end 
		
endmodule