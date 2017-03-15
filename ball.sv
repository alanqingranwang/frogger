//-------------------------------------------------------------------------
//    Ball.sv                                                            --
//    Viral Mehta                                                        --
//    Spring 2005                                                        --
//                                                                       --
//    Modified by Stephen Kempf 03-01-2006                               --
//                              03-12-2007                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Fall 2014 Distribution                                             --
//                                                                       --
//    For use with ECE 298 Lab 7                                         --
//    UIUC ECE Department                                                --
//-------------------------------------------------------------------------
module  ball ( input Reset, frame_clk,
               output [9:0]  BallX, BallY,
				   input [15:0] keycode,
					input frogreset,
					input stage1x,
					input stage2x,
					input onfish3,
					input onlog,
					input fish3moved,
					input logmoved,
					input onfish2,
					input fish2moved,
					input onbiglog,
					input biglogmoved,
					input[3:0] lives);
    
    logic [9:0] Ball_X_Pos, Ball_X_Motion, Ball_Y_Pos, Ball_Y_Motion;
	 
	 logic hold;
	 
    parameter [9:0] Ball_X_Center=320;  // Center position on the X axis
    parameter [9:0] Ball_Y_Center=335;  // Center position on the Y axis
    parameter [9:0] Ball_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Ball_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Ball_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max=479;     // Bottommost point on the Y axis
    parameter [9:0] Ball_X_Step=12;      // Step size on the X axis
    parameter [9:0] Ball_Y_Step=19;      // Step size on the Y axis
	 parameter [9:0] Ball_Y_StepN=19;
   
    always_ff @ (posedge Reset or posedge frame_clk )
    begin: Move_Ball
        if (Reset)  // Asynchronous Reset
        begin 
            Ball_Y_Motion <= 10'd0; //Ball_Y_Step;
				Ball_X_Motion <= 10'd0; //Ball_X_Step;
				Ball_Y_Pos <= Ball_Y_Center;
				Ball_X_Pos <= Ball_X_Center;
				hold <= 1'b0;
        end
		  
		  else if(frogreset)
		  begin 
            Ball_Y_Motion <= 10'd0; //Ball_Y_Step;
				Ball_X_Motion <= 10'd0; //Ball_X_Step;
				Ball_Y_Pos <= Ball_Y_Center;
				Ball_X_Pos <= Ball_X_Center;
				hold <= 1'b1;
        end
           
        else if(hold == 1'b0 && lives > 0)
        begin 
				
				hold = 1'b1;
			   case(keycode)
				
						16'h0007: // right
						begin
						Ball_Y_Motion = 0;
						Ball_X_Motion = Ball_X_Step;
						end
						
						16'h0004: // left
						begin
						Ball_Y_Motion = 0;
						Ball_X_Motion = (~ (Ball_X_Step) + 1'b1);
						end
						
						16'h0016: // down
						begin
							if( Ball_Y_Pos + Ball_Y_Step > 348) 
								begin
								Ball_X_Motion = 0;
								Ball_Y_Motion = 0;
								end
							
							else
								begin
								Ball_X_Motion = 0;
								Ball_Y_Motion = Ball_Y_Step;
								end
						end
						
						16'h001A: // up
						begin
						   if( Ball_Y_Pos > 256) 
								begin
								Ball_X_Motion = 0;
								Ball_Y_Motion = (~ (Ball_Y_Step) + 1'b1);
								end
							
							else
								begin
								Ball_X_Motion = 0;
								Ball_Y_Motion = (~ (Ball_Y_StepN) + 1'b1);
								end
						end
						
						default:
						begin
						Ball_X_Motion = 0;  
						Ball_Y_Motion = 0;  
						hold = 1'b0;
						end		
						
		   	endcase
						  		
				 if(stage1x == 1)
				 begin
				      Ball_Y_Pos <= (Ball_Y_Pos + Ball_Y_Motion);
						if(onfish3 == 1 && fish3moved)
							Ball_X_Pos <= (Ball_X_Pos + Ball_X_Motion - 1);
						else if(onlog == 1 && logmoved)
							Ball_X_Pos <= (Ball_X_Pos + Ball_X_Motion + 1);
					   else if(onfish2 == 1 && fish2moved)
							Ball_X_Pos <= (Ball_X_Pos + Ball_X_Motion - 1);
						else if(onbiglog == 1 && biglogmoved)
							Ball_X_Pos <= (Ball_X_Pos + Ball_X_Motion + 1);
						else 
						   Ball_X_Pos <= (Ball_X_Pos + Ball_X_Motion);
				 
			    end
				 
				 else if(stage2x == 1)
				 begin
						Ball_Y_Pos = (Ball_Y_Pos + Ball_Y_Motion);
						
						if(onfish3 == 1 && fish3moved == 1)
							Ball_X_Pos = (Ball_X_Pos + Ball_X_Motion - 1);
						else if(onlog == 1 && logmoved == 1)
							Ball_X_Pos = (Ball_X_Pos + Ball_X_Motion + 1);
					   else if(onfish2 == 1 && fish2moved)
							Ball_X_Pos <= (Ball_X_Pos + Ball_X_Motion - 1);
						else if(onbiglog == 1 && biglogmoved)
							Ball_X_Pos <= (Ball_X_Pos + Ball_X_Motion + 1);
						else 
						   Ball_X_Pos = (Ball_X_Pos + Ball_X_Motion);
			    end
				 
				 else 
				 begin
					Ball_Y_Pos = (Ball_Y_Pos );  // Update ball position
					Ball_X_Pos = (Ball_X_Pos );
				 end
		end  
		
		else
		begin
				
				Ball_X_Pos = Ball_X_Pos;
				Ball_Y_Pos = Ball_Y_Pos;
				
				case(keycode)
				
				16'h0000: 
				begin
				hold = 1'b0;
				end
				
				default:
				begin
			   hold = 1'b1;
				end
				
				endcase
		end
		
    end
       
    assign BallX = Ball_X_Pos;
   
    assign BallY = Ball_Y_Pos;
   
endmodule