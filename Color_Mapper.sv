// Collor mapper for sending RGB values to the VGA


//Inputs should be obvious or explained elsewhere
module  color_mapper ( 	
						input Clk,
						input startx, winx, gameoverx, holdx,
	               input stage1x, stage2x, winreset,
						input p2,
						input safe1, safe2, safe3, safe4, safe5,
						input safe1x, safe2x, safe3x, safe4x, safe5x,
						input[3:0] Life1,
						input[3:0] Life2,
						input        [9:0] Ball1X, Ball1Y, Ball2X, Ball2Y, DrawX, DrawY,
						input        [9:0] TruckX1, TruckY1, TruckX2, TruckY2, TruckX3, TruckY3,
						input        [9:0] TractorX1, TractorY1, TractorX2, TractorY2, TractorX3, TractorY3, TractorX4, TractorY4, 
						input        [9:0] YellowCarX1, YellowCarY1, YellowCarX2, YellowCarY2, YellowCarX3, YellowCarY3, YellowCarX4, YellowCarY4, 
						input        [9:0] GrayCarX1, GrayCarY1, GrayCarX2, GrayCarY2,
						input        [9:0] FishThreeX1, FishThreeY1, FishThreeX2, FishThreeY2, FishThreeX3, FishThreeY3,
						input        [9:0] LogX1, LogY1, LogX2, LogY2, LogX3, LogY3,
						input        [9:0] FishTwoX1, FishTwoY1, FishTwoX2, FishTwoY2, FishTwoX3, FishTwoY3, FishTwoX4, FishTwoY4, FishTwoX5, FishTwoY5,
						input        [9:0] BigLogX1, BigLogY1, BigLogX2, BigLogY2, BigLogX3, BigLogY3,
						input [0:15][0:15][0:1]  FrogSprite,
						input [0:15][0:31][0:1]  TruckSprite,						
						input [0:15][0:15][0:1]  TractorSprite,
						input [0:15][0:15][0:1]  YellowCarSprite,						
						input [0:15][0:15][0:1]  GrayCarSprite,		
						input [0:15][0:47][0:1]  FishThreeSprite,
						input [0:15][0:47][0:1]  LogSprite,
						input [0:15][0:31][0:1]  FishTwoSprite,
						input [0:15][0:63][0:1]  BigLogSprite,
						input [0:17][0:17][0:1]  SafeFrogSprite,
						input [0:16][0:111][0:1] TitleSprite,
						input [0:9][0:103][0:1]  Player1Sprite,
						input [0:9][0:103][0:1]  Player2Sprite,
						input [0:15][0:15][0:1]  DeathSprite,
						input [0:9][0:55][0:1]   WinSprite,
						input [0:9][0:71][0:1]   GameOverSprite,
						input [0:9][0:87][0:1]   PressEnterSprite,
                  output logic [7:0]  Red, Green, Blue );
    
	logic [3:0] disp;               // holds the value to decode for sending out RGB signals. Ex: 0=background, 1=white, 2=blue, 3=red...
	logic [31:0] counter; 			// counter
	logic [9:0] StingX, StingY;     //used to offset the StingX1 signals because I forgot to adjust them to the center of the bee butt
	//assign StingX = StingX1+10;		//offsets
	//assign StingY = StingY1 + 15;
	 
	// Counter updates
	always_ff @ (posedge Clk )
	begin
		counter = counter+1;
	end
	
	 logic [9:0] TitleX = 271;
	 logic [9:0] TitleY = 180;
	 logic [9:0] Player1X = 273;
    logic [9:0] Player1Y = 256;
	 logic [9:0] Player2X = 273;
	 logic [9:0] Player2Y = 296;
	 logic [9:0] WinX = 296;
	 logic [9:0] WinY = 256;
	 logic [9:0] GameOverX = 281;
	 logic [9:0] GameOverY = 256;
	 logic [9:0] PressEnterX = 281;
	 logic [9:0] PressEnterY = 243;
	 
	 logic [9:0] SafeFrog1X = 219;
	 logic [9:0] SafeFrog2X = 263;
	 logic [9:0] SafeFrog3X = 311;
	 logic [9:0] SafeFrog4X = 359;
    logic [9:0] SafeFrog5X = 403;
 	 logic [9:0] SafeFrogY = 140;
	 
	 
	/// borders of the playing field
	 logic[10:0] x1 = 207;
	 logic[10:0] x2 = 431;
	 logic[10:0] y1 = 112;
	 logic[10:0] y2 = 368;
	
	 logic[10:0] purpley1 = 240;
	 logic[10:0] purpley2 = 256;
	 
	 logic[10:0] purpley3 = 336;
	 logic[10:0] purpley4 = 352;
	
	 logic[10:0] greeny1 = 128;
	 logic[10:0] greeny2 = 160;
	 
	 logic[10:0] bluetop = 136;
	 
	 logic[10:0] bluex1 = 215;
	 logic[10:0] bluex2 = 239;
	 
	 logic[10:0] bluex3 = 259;
	 logic[10:0] bluex4 = 283;
	 
	 logic[10:0] bluex5 = 307;
	 logic[10:0] bluex6 = 331;
	 
	 logic[10:0] bluex7 = 355;
	 logic[10:0] bluex8 = 379;
	 
	 logic[10:0] bluex9 = 399;
	 logic[10:0] bluex10 = 423;
	 
	 logic [4:0] sprite_addr;
	 logic [15:0] sprite_data;
	 font_rom (.addr(sprite_addr), .data(sprite_data));		
	 
	 /*************** Title *****************/	 
	 logic title;
    always_comb
		 begin
		 if((DrawX >= TitleX) && (DrawX <= TitleX + 112) && (DrawY >= TitleY) && (DrawY <= TitleY + 17) && TitleSprite[DrawY-TitleY][DrawX-TitleX]!= 0)  
			  title = 1;
		 else
			  title = 0;
	 end
	 
	 /*************** Win *****************/	 
	 logic win;
    always_comb
		 begin
		 if((DrawX >= WinX) && (DrawX <= WinX + 56) && (DrawY >= WinY) && (DrawY <= WinY + 10) && WinSprite[DrawY-WinY][DrawX-WinX]!= 0)  
			  win = 1;
		 else
			  win = 0;
	 end
	 
	 /*************** Game Over *****************/	 
	 logic gameover;
    always_comb
		 begin
		 if((DrawX >= GameOverX) && (DrawX <= GameOverX + 71) && (DrawY >= GameOverY) && (DrawY <= GameOverY + 10) && GameOverSprite[DrawY-GameOverY][DrawX-GameOverX]!= 0)  
			  gameover = 1;
		 else
			  gameover = 0;
	 end
	 
	 /*************** Press Enter *****************/	 
	 logic pressenter;
    always_comb
		 begin
		 if((DrawX >= PressEnterX) && (DrawX <= PressEnterX + 87) && (DrawY >= PressEnterY) && (DrawY <= PressEnterY + 10) && PressEnterSprite[DrawY-PressEnterY][DrawX-PressEnterX]!= 0)  
			  pressenter = 1;
		 else
			  pressenter = 0;
	 end
	 
	 /*************** Player 1/2 *****************/
	 logic player1;
    always_comb
		 begin
		 if((DrawX >= Player1X) && (DrawX <= Player1X + 104) && (DrawY >= Player1Y) && (DrawY <= Player1Y + 10) && Player1Sprite[DrawY-Player1Y][DrawX-Player1X]!= 0)  
			  player1 = 1;
		 else
			  player1 = 0;
	 end
	 
	 logic player2;
    always_comb
		 begin
		 if((DrawX >= Player2X) && (DrawX <= Player2X + 104) && (DrawY >= Player2Y) && (DrawY <= Player2Y + 10) && Player2Sprite[DrawY-Player2Y][DrawX-Player2X]!= 0)  
			  player2 = 1;
		 else
			  player2 = 0;
	 end
	 
	 
	 /*************** Frogger *****************/	 
	 logic frog;
    always_comb
		 begin:frog_x
	 
		 if((DrawX >= Ball1X) && (DrawX <= Ball1X + 16) && (DrawY >= Ball1Y) && (DrawY <= Ball1Y + 16) && FrogSprite[DrawY-Ball1Y][DrawX-Ball1X]!= 0)  
			  frog = 1;
		 else
			  frog = 0;
	 end
	 
	 logic frog2;
    always_comb
		 begin
	 
		 if((p2 == 1) && (DrawX >= Ball2X) && (DrawX <= Ball2X + 16) && (DrawY >= Ball2Y) && (DrawY <= Ball2Y + 16) && FrogSprite[DrawY-Ball2Y][DrawX-Ball2X]!= 0)  
			  frog2 = 1;
		 else
			  frog2 = 0;
	 end

	 /*************** Trucks *****************/	 
	 logic truck1;
	 always_comb
	 begin
			if ((DrawX >= TruckX1) && (DrawX <= TruckX1 + 32) && (DrawY >= TruckY1) && (DrawY <= TruckY1 + 16) && TruckSprite[DrawY-TruckY1][DrawX-TruckX1]!= 0)
				truck1 = 1'b1;				
			else
				truck1 = 1'b0;
	 end
	  
	 logic truck2;
	 always_comb
	 begin
			if ((DrawX >= TruckX2) && (DrawX <= TruckX2 + 32) && (DrawY >= TruckY2) && (DrawY <= TruckY2 + 16) && TruckSprite[DrawY-TruckY2][DrawX-TruckX2]!= 0)
				truck2 = 1'b1;				
			else
				truck2 = 1'b0;
	 end 
		 
	 logic truck3;
	 always_comb
	 begin
			if ((stage2x == 1) && (DrawX >= TruckX3) && (DrawX <= TruckX3 + 32) && (DrawY >= TruckY3) && (DrawY <= TruckY3 + 16) && TruckSprite[DrawY-TruckY3][DrawX-TruckX3]!= 0)
				truck3 = 1'b1;				
			else
				truck3 = 1'b0;
	 end 

	 /*************** Tractors *****************/		 
	 logic tractor1;
	 always_comb
	 begin
			if ((DrawX >= TractorX1) && (DrawX <= TractorX1 + 16) && (DrawY >= TractorY1) && (DrawY <= TractorY1 + 16) && TractorSprite[DrawY-TractorY1][DrawX-TractorX1]!= 0)
				tractor1 = 1'b1;				
			else
				tractor1 = 1'b0;
	 end 
	 
	 logic tractor2;
	 always_comb
	 begin
			if ((DrawX >= TractorX2) && (DrawX <= TractorX2 + 16) && (DrawY >= TractorY2) && (DrawY <= TractorY2 + 16) && TractorSprite[DrawY-TractorY2][DrawX-TractorX2]!= 0)
				tractor2 = 1'b1;				
			else
				tractor2 = 1'b0;
	 end 
	 
	 logic tractor3;
	 always_comb
	 begin
			if ((DrawX >= TractorX3) && (DrawX <= TractorX3 + 16) && (DrawY >= TractorY3) && (DrawY <= TractorY3 + 16) && TractorSprite[DrawY-TractorY3][DrawX-TractorX3]!= 0)
				tractor3 = 1'b1;				
			else
				tractor3 = 1'b0;
	 end 
	 
	 logic tractor4;
	 always_comb
	 begin
			if (stage2x == 1 && (DrawX >= TractorX4) && (DrawX <= TractorX4 + 16) && (DrawY >= TractorY4) && (DrawY <= TractorY4 + 16) && TractorSprite[DrawY-TractorY4][DrawX-TractorX4]!= 0)
				tractor4 = 1'b1;				
			else
				tractor4 = 1'b0;
	 end 

	 /*************** Yellow Cars *****************/	 
    logic yellowCar1;
	 always_comb
	 begin
			if ((DrawX >= YellowCarX1) && (DrawX <= YellowCarX1 + 16) && (DrawY >= YellowCarY1) && (DrawY <= YellowCarY1 + 16) && YellowCarSprite[DrawY-YellowCarY1][DrawX-YellowCarX1]!= 0)
				yellowCar1 = 1'b1;				
			else
				yellowCar1 = 1'b0;
	 end 
	
	 logic yellowCar2;
	 always_comb
	 begin
			if ((DrawX >= YellowCarX2) && (DrawX <= YellowCarX2 + 16) && (DrawY >= YellowCarY2) && (DrawY <= YellowCarY2 + 16) && YellowCarSprite[DrawY-YellowCarY2][DrawX-YellowCarX2]!= 0)
				yellowCar2 = 1'b1;				
			else
				yellowCar2 = 1'b0;
	 end 
		 
	 logic yellowCar3;
	 always_comb
	 begin
			if ((DrawX >= YellowCarX3) && (DrawX <= YellowCarX3 + 16) && (DrawY >= YellowCarY3) && (DrawY <= YellowCarY3 + 16) && YellowCarSprite[DrawY-YellowCarY3][DrawX-YellowCarX3]!= 0)
				yellowCar3 = 1'b1;				
			else
				yellowCar3 = 1'b0;
	 end 
	 
	 logic yellowCar4;
	 always_comb
	 begin
			if (stage2x == 1 && (DrawX >= YellowCarX4) && (DrawX <= YellowCarX4 + 16) && (DrawY >= YellowCarY4) && (DrawY <= YellowCarY4 + 16) && YellowCarSprite[DrawY-YellowCarY4][DrawX-YellowCarX4]!= 0)
				yellowCar4 = 1'b1;				
			else
				yellowCar4 = 1'b0;
	 end 

	 /*************** GrayCars *****************/		 
    logic grayCar1;
	 always_comb
	 begin
			if ((DrawX >= GrayCarX1) && (DrawX <= GrayCarX1 + 16) && (DrawY >= GrayCarY1) && (DrawY <= GrayCarY1 + 16) && GrayCarSprite[DrawY-GrayCarY1][DrawX-GrayCarX1]!= 0)
				grayCar1 = 1'b1;				
			else
				grayCar1 = 1'b0;
	 end 

	 logic grayCar2;
	 always_comb
	 begin
			if (stage2x == 1 && (DrawX >= GrayCarX2) && (DrawX <= GrayCarX2 + 16) && (DrawY >= GrayCarY2) && (DrawY <= GrayCarY2 + 16) && GrayCarSprite[DrawY-GrayCarY2][DrawX-GrayCarX2]!= 0)
				grayCar2 = 1'b1;				
			else
				grayCar2 = 1'b0;
	 end 
		 
	 /*************** FishThree *****************/		 
	 logic fishThree1;
	 always_comb
	 begin
			if ((DrawX >= FishThreeX1) && (DrawX <= FishThreeX1 + 48) && (DrawY >= FishThreeY1) && (DrawY <= FishThreeY1 + 16) && FishThreeSprite[DrawY-FishThreeY1][DrawX-FishThreeX1]!= 0)
				fishThree1 = 1'b1;				
			else
				fishThree1 = 1'b0;
	 end 

	 logic fishThree2;
	 always_comb
	 begin
			if ((DrawX >= FishThreeX2) && (DrawX <= FishThreeX2 + 48) && (DrawY >= FishThreeY2) && (DrawY <= FishThreeY2 + 16) && FishThreeSprite[DrawY-FishThreeY2][DrawX-FishThreeX2]!= 0)
				fishThree2 = 1'b1;				
			else
				fishThree2 = 1'b0;
	 end 
		 
	 logic fishThree3;
	 always_comb
	 begin
			if ((DrawX >= FishThreeX3) && (DrawX <= FishThreeX3 + 48) && (DrawY >= FishThreeY3) && (DrawY <= FishThreeY3 + 16) && FishThreeSprite[DrawY-FishThreeY3][DrawX-FishThreeX3]!= 0)
				fishThree3 = 1'b1;				
			else
				fishThree3 = 1'b0;
	 end 
		 
	 /*************** Logs *****************/	 
	 logic log1;
	 always_comb
	 begin
			if ((DrawX >= LogX1) && (DrawX <= LogX1 + 48) && (DrawY >= LogY1) && (DrawY <= LogY1 + 16) && LogSprite[DrawY-LogY1][DrawX-LogX1]!= 0)
				log1 = 1'b1;				
			else
				log1 = 1'b0;
	 end
		 
	 logic log2;
	 always_comb
	 begin
			if ((DrawX >= LogX2) && (DrawX <= LogX2 + 48) && (DrawY >= LogY2) && (DrawY <= LogY2 + 16) && LogSprite[DrawY-LogY2][DrawX-LogX2]!= 0)
				log2 = 1'b1;				
			else
				log2 = 1'b0;
	 end
	
    logic log3;
	 always_comb
	 begin
			if ((DrawX >= LogX3) && (DrawX <= LogX3 + 48) && (DrawY >= LogY3) && (DrawY <= LogY3 + 16) && LogSprite[DrawY-LogY3][DrawX-LogX3]!= 0)
				log3 = 1'b1;				
			else
				log3 = 1'b0;
	 end
		 
	 /*************** FishTwo *****************/		 
	 logic fishTwo1;
	 always_comb
	 begin
			if ((DrawX >= FishTwoX1) && (DrawX <= FishTwoX1 + 32) && (DrawY >= FishTwoY1) && (DrawY <= FishTwoY1 + 16) && FishTwoSprite[DrawY-FishTwoY1][DrawX-FishTwoX1]!= 0)
				fishTwo1 = 1'b1;				
			else
				fishTwo1 = 1'b0;
	 end 

	 logic fishTwo2;
	 always_comb
	 begin
			if ((DrawX >= FishTwoX2) && (DrawX <= FishTwoX2 + 32) && (DrawY >= FishTwoY2) && (DrawY <= FishTwoY2 + 16) && FishTwoSprite[DrawY-FishTwoY2][DrawX-FishTwoX2]!= 0)
				fishTwo2 = 1'b1;				
			else
				fishTwo2 = 1'b0;
	 end 
		 
	 logic fishTwo3;
	 always_comb
	 begin
			if ((DrawX >= FishTwoX3) && (DrawX <= FishTwoX3 + 32) && (DrawY >= FishTwoY3) && (DrawY <= FishTwoY3 + 16) && FishTwoSprite[DrawY-FishTwoY3][DrawX-FishTwoX3]!= 0)
				fishTwo3 = 1'b1;				
			else
				fishTwo3 = 1'b0;
	 end 
	 
	 logic fishTwo4;
	 always_comb
	 begin
			if ((DrawX >= FishTwoX4) && (DrawX <= FishTwoX4 + 32) && (DrawY >= FishTwoY4) && (DrawY <= FishTwoY4 + 16) && FishTwoSprite[DrawY-FishTwoY4][DrawX-FishTwoX4]!= 0)
				fishTwo4 = 1'b1;				
			else
				fishTwo4 = 1'b0;
	 end 
	 
	 logic fishTwo5;
	 always_comb
	 begin
			if ((DrawX >= FishTwoX5) && (DrawX <= FishTwoX5 + 32) && (DrawY >= FishTwoY5) && (DrawY <= FishTwoY5 + 16) && FishTwoSprite[DrawY-FishTwoY5][DrawX-FishTwoX5]!= 0)
				fishTwo5 = 1'b1;				
			else
				fishTwo5 = 1'b0;
	 end 
		 
		 
	 /*************** Big Logs *****************/	 
	 logic bigLog1;
	 always_comb
	 begin
			if ((DrawX >= BigLogX1) && (DrawX <= BigLogX1 + 64) && (DrawY >= BigLogY1) && (DrawY <= BigLogY1 + 16) && BigLogSprite[DrawY-BigLogY1][DrawX-BigLogX1]!= 0)
				bigLog1 = 1'b1;				
			else
				bigLog1 = 1'b0;
	 end
		 
	 logic bigLog2;
	 always_comb
	 begin
			if ((DrawX >= BigLogX2) && (DrawX <= BigLogX2 + 64) && (DrawY >= BigLogY2) && (DrawY <= BigLogY2 + 16) && BigLogSprite[DrawY-BigLogY2][DrawX-BigLogX2]!= 0)
				bigLog2 = 1'b1;				
			else
				bigLog2 = 1'b0;
	 end
	
    logic bigLog3;
	 always_comb
	 begin
			if ((DrawX >= BigLogX3) && (DrawX <= BigLogX3 + 64) && (DrawY >= BigLogY3) && (DrawY <= BigLogY3 + 16) && BigLogSprite[DrawY-BigLogY3][DrawX-BigLogX3]!= 0)
				bigLog3 = 1'b1;				
			else
				bigLog3 = 1'b0;
	 end
	 
	 /*************** Safe Frogs *****************/	 
	 logic safeFrog1;
	 always_comb
	 begin
			if ((DrawX >= SafeFrog1X) && (DrawX <= SafeFrog1X + 18) && (DrawY >= SafeFrogY) && (DrawY <= SafeFrogY + 18) && SafeFrogSprite[DrawY-SafeFrogY][DrawX-SafeFrog1X]!= 0)
				safeFrog1 = 1'b1;				
			else
				safeFrog1 = 1'b0;
	 end
		 
	 logic safeFrog2;
	 always_comb
	 begin
			if ((DrawX >= SafeFrog2X) && (DrawX <= SafeFrog2X + 18) && (DrawY >= SafeFrogY) && (DrawY <= SafeFrogY + 18) && SafeFrogSprite[DrawY-SafeFrogY][DrawX-SafeFrog2X]!= 0)
				safeFrog2 = 1'b1;				
			else
				safeFrog2 = 1'b0;
	 end
	
    logic safeFrog3;
	 always_comb
	 begin
			if ((DrawX >= SafeFrog3X) && (DrawX <= SafeFrog3X + 18) && (DrawY >= SafeFrogY) && (DrawY <= SafeFrogY + 18) && SafeFrogSprite[DrawY-SafeFrogY][DrawX-SafeFrog3X]!= 0)
				safeFrog3 = 1'b1;				
			else
				safeFrog3 = 1'b0;
	 end
	 
	 logic safeFrog4;
	 always_comb
	 begin
			if ((DrawX >= SafeFrog4X) && (DrawX <= SafeFrog4X + 18) && (DrawY >= SafeFrogY) && (DrawY <= SafeFrogY + 18) && SafeFrogSprite[DrawY-SafeFrogY][DrawX-SafeFrog4X]!= 0)
				safeFrog4 = 1'b1;				
			else
				safeFrog4 = 1'b0;
	 end
	 
	 logic safeFrog5;
	 always_comb
	 begin
			if ((DrawX >= SafeFrog5X) && (DrawX <= SafeFrog5X + 18) && (DrawY >= SafeFrogY) && (DrawY <= SafeFrogY + 18) && SafeFrogSprite[DrawY-SafeFrogY][DrawX-SafeFrog5X]!= 0)
				safeFrog5 = 1'b1;				
			else
				safeFrog5 = 1'b0;
	 end
		 
	 /*************** Background *****************/		 
	 logic overlay;
	 always_comb
	 begin:overlayx
		if(DrawX < x1 || DrawX > x2 || DrawY < y1 || DrawY > y2)
			  overlay = 1'b1;
		else 
			  overlay = 1'b0;
	 end 
	  
	 logic blue;
	 always_comb
	 begin:bluex
		if( (DrawY >= greeny2 && DrawY <= purpley1) || (DrawY > bluetop && DrawY < greeny2 && DrawX > bluex1 && DrawX < bluex2) ||
			 (DrawY > bluetop && DrawY < greeny2 && DrawX > bluex3 && DrawX < bluex4) || 
			 (DrawY > bluetop && DrawY < greeny2 && DrawX > bluex5 && DrawX < bluex6) || 
			 (DrawY > bluetop && DrawY < greeny2 && DrawX > bluex7 && DrawX < bluex8) ||
			 (DrawY > bluetop && DrawY < greeny2 && DrawX > bluex9 && DrawX < bluex10))
			 
			blue=1'b1;
		else
			blue=1'b0;
	 end
	
	 logic green;
	 always_comb
	 begin:greenx
		if( DrawY > greeny1 && DrawY < greeny2)
			green=1'b1;
		else
			green=1'b0;
	 end
	 
	 logic purple;
	 always_comb
	 begin:purplex
		if( (DrawY > purpley1 && DrawY < purpley2) || (DrawY > purpley3 && DrawY < purpley4) )
			purple=1'b1;
		else
			purple=1'b0;
	 end
		 

	 
	 
	 
    // Assign colors
    always_comb
    begin:RGB_Display
	 
	   if(overlay == 1'b1)
		begin
		   Red = 8'h00;
		   Green = 8'h00;
		   Blue = 8'h47;
		end 	
		
		/*************** Title *****************/
		else if(startx && title == 1 && TitleSprite[DrawY-TitleY][DrawX-TitleX] == 1)
		begin
			Red = 8'h21;
			Green = 8'hde;
			Blue = 8'h00;
		end	
		
		else if(startx && title == 1 && TitleSprite[DrawY-TitleY][DrawX-TitleX] == 2)
		begin
			Red = 8'hff;
			Green = 8'h47;
			Blue = 8'hf7;
		end	
		
		else if(startx && title == 1 && TitleSprite[DrawY-TitleY][DrawX-TitleX] == 3)
		begin
			Red = 8'hff;
			Green = 8'hff;
			Blue = 8'h00;
		end	
		
		/*************** Win *****************/
		else if(winx && win == 1 && WinSprite[DrawY-WinY][DrawX-WinX] == 1)
		begin
			Red = 8'hff;
			Green = 8'h00;
			Blue = 8'h00;
		end	
		
		/*************** Game Over *****************/
		else if(gameoverx && gameover == 1 && GameOverSprite[DrawY-GameOverY][DrawX-GameOverX] == 1)
		begin
			Red = 8'hff;
			Green = 8'h00;
			Blue = 8'h00;
		end	
		
		/*************** Press Enter *****************/
		else if(holdx && pressenter == 1 && PressEnterSprite[DrawY-PressEnterY][DrawX-PressEnterX] == 1)
		begin
			Red = 8'hff;
			Green = 8'hff;
			Blue = 8'hff;
		end	
		
		/*************** Player 1/2 *****************/
		else if(startx && player1 == 1 && Player1Sprite[DrawY-Player1Y][DrawX-Player1X] == 1)
		begin
			Red = 8'hff;
			Green = 8'hff;
			Blue = 8'hff;
		end	
	
		else if(startx && player2 == 1 && Player2Sprite[DrawY-Player2Y][DrawX-Player2X] == 1)
		begin
			Red = 8'hff;
			Green = 8'hff;
			Blue = 8'hff;
		end	
		
			
		
		/*************** Title Background *****************/
		else if(startx && DrawY <= 240 && DrawY >= 128)
		begin
		   Red = 8'h00;
		   Green = 8'h00;
		   Blue = 8'h47;
		end 	
		
		else if(startx && DrawY > 240)
		begin
		   Red = 8'h00;
		   Green = 8'h00;
		   Blue = 8'h00;
		end 	
		
		/*************** Win Background *****************/
		else if(winx)
		begin
		   Red = 8'h00;
		   Green = 8'h00;
		   Blue = 8'h00;
		end 	
		
		/*************** Game Over Background *****************/
		else if(gameoverx)
		begin
		   Red = 8'h00;
		   Green = 8'h00;
		   Blue = 8'h00;
		end 		
		
		/*************** Trucks *****************/		
		else if(truck1 == 1 && TruckSprite[DrawY-TruckY1][DrawX-TruckX1] == 1)
		begin
			Red = 8'hde;
			Green = 8'hde;
			Blue = 8'hf7;
		end	
		else if(truck1 == 1 && TruckSprite[DrawY-TruckY1][DrawX-TruckX1] == 2)
		begin
			Red = 8'hff;
			Green = 8'h00;
			Blue = 8'h00;
		end		
		else if(truck1 == 1 && TruckSprite[DrawY-TruckY1][DrawX-TruckX1] == 3)
		begin
			Red = 8'h21;
			Green = 8'hde;
			Blue = 8'h00;
		end	 	  
		
		else if(truck2 == 1 && TruckSprite[DrawY-TruckY2][DrawX-TruckX2] == 1)
		begin
			Red = 8'hde;
			Green = 8'hde;
			Blue = 8'hf7;
		end	
		else if(truck2 == 1 && TruckSprite[DrawY-TruckY2][DrawX-TruckX2] == 2)
		begin
			Red = 8'hff;
			Green = 8'h00;
			Blue = 8'h00;
		end		
		else if(truck2 == 1 && TruckSprite[DrawY-TruckY2][DrawX-TruckX2] == 3)
		begin
			Red = 8'h21;
			Green = 8'hde;
			Blue = 8'h00;
		end	 	
		
		else if(truck3 == 1 && TruckSprite[DrawY-TruckY3][DrawX-TruckX3] == 1)
		begin
			Red = 8'hde;
			Green = 8'hde;
			Blue = 8'hf7;
		end	
		else if(truck3 == 1 && TruckSprite[DrawY-TruckY3][DrawX-TruckX3] == 2)
		begin
			Red = 8'hff;
			Green = 8'h00;
			Blue = 8'h00;
		end		
		else if(truck3 == 1 && TruckSprite[DrawY-TruckY3][DrawX-TruckX3] == 3)
		begin
			Red = 8'h21;
			Green = 8'hde;
			Blue = 8'h00;
		end	 	

		
		/*************** Tractors *****************/
		else if(tractor1 == 1 && TractorSprite[DrawY-TractorY1][DrawX-TractorX1] == 1)
		begin
			Red = 8'hde;
			Green = 8'hde;
			Blue = 8'hf7;
		end	
		else if(tractor1 == 1 && TractorSprite[DrawY-TractorY1][DrawX-TractorX1] == 2)
		begin
			Red = 8'h21;
			Green = 8'hde;
			Blue = 8'h00;
		end		
		else if(tractor1 == 1 && TractorSprite[DrawY-TractorY1][DrawX-TractorX1] == 3)
		begin
			Red = 8'hff;
			Green = 8'h00;
			Blue = 8'h00;
		end	 	  
		
		else if(tractor2 == 1 && TractorSprite[DrawY-TractorY2][DrawX-TractorX2] == 1)
		begin
			Red = 8'hde;
			Green = 8'hde;
			Blue = 8'hf7;
		end	
		else if(tractor2 == 1 && TractorSprite[DrawY-TractorY2][DrawX-TractorX2] == 2)
		begin
			Red = 8'h21;
			Green = 8'hde;
			Blue = 8'h00;
		end		
		else if(tractor2 == 1 && TractorSprite[DrawY-TractorY2][DrawX-TractorX2] == 3)
		begin
			Red = 8'hff;
			Green = 8'h00;
			Blue = 8'h00;
		end	 	  
		
		else if(tractor3 == 1 && TractorSprite[DrawY-TractorY3][DrawX-TractorX3] == 1)
		begin
			Red = 8'hde;
			Green = 8'hde;
			Blue = 8'hf7;
		end	
		else if(tractor3 == 1 && TractorSprite[DrawY-TractorY3][DrawX-TractorX3] == 2)
		begin
			Red = 8'h21;
			Green = 8'hde;
			Blue = 8'h00;
		end		
		else if(tractor3 == 1 && TractorSprite[DrawY-TractorY3][DrawX-TractorX3] == 3)
		begin
			Red = 8'hff;
			Green = 8'h00;
			Blue = 8'h00;
		end	 	  
		
		else if(tractor4 == 1 && TractorSprite[DrawY-TractorY4][DrawX-TractorX4] == 1)
		begin
			Red = 8'hde;
			Green = 8'hde;
			Blue = 8'hf7;
		end	
		else if(tractor4 == 1 && TractorSprite[DrawY-TractorY4][DrawX-TractorX4] == 2)
		begin
			Red = 8'h21;
			Green = 8'hde;
			Blue = 8'h00;
		end		
		else if(tractor4 == 1 && TractorSprite[DrawY-TractorY4][DrawX-TractorX4] == 3)
		begin
			Red = 8'hff;
			Green = 8'h00;
			Blue = 8'h00;
		end	 	  
		
		/*************** Yellow Cars *****************/
		else if(yellowCar1 == 1 && YellowCarSprite[DrawY-YellowCarY1][DrawX-YellowCarX1] == 1)
		begin
			Red = 8'hff;
			Green = 8'h00;
			Blue = 8'h00;
		end	
		else if(yellowCar1 == 1 && YellowCarSprite[DrawY-YellowCarY1][DrawX-YellowCarX1] == 2)
		begin
			Red = 8'hff;
			Green = 8'hff;
			Blue = 8'h00;
		end		
		else if(yellowCar1 == 1 && YellowCarSprite[DrawY-YellowCarY1][DrawX-YellowCarX1] == 3)
		begin
			Red = 8'h97;
			Green = 8'h00;
			Blue = 8'hf7;
		end	 	  
		
		else if(yellowCar2 == 1 && YellowCarSprite[DrawY-YellowCarY2][DrawX-YellowCarX2] == 1)
		begin
			Red = 8'hff;
			Green = 8'h00;
			Blue = 8'h00;
		end	
		else if(yellowCar2 == 1 && YellowCarSprite[DrawY-YellowCarY2][DrawX-YellowCarX2] == 2)
		begin
			Red = 8'hff;
			Green = 8'hff;
			Blue = 8'h00;
		end		
		else if(yellowCar2 == 1 && YellowCarSprite[DrawY-YellowCarY2][DrawX-YellowCarX2] == 3)
		begin
			Red = 8'h97;
			Green = 8'h00;
			Blue = 8'hf7;
		end
		
		else if(yellowCar3 == 1 && YellowCarSprite[DrawY-YellowCarY3][DrawX-YellowCarX3] == 1)
		begin
			Red = 8'hff;
			Green = 8'h00;
			Blue = 8'h00;
		end	
		else if(yellowCar3 == 1 && YellowCarSprite[DrawY-YellowCarY3][DrawX-YellowCarX3] == 2)
		begin
			Red = 8'hff;
			Green = 8'hff;
			Blue = 8'h00;
		end		
		else if(yellowCar3 == 1 && YellowCarSprite[DrawY-YellowCarY3][DrawX-YellowCarX3] == 3)
		begin
			Red = 8'h97;
			Green = 8'h00;
			Blue = 8'hf7;
		end
		
		else if(yellowCar4 == 1 && YellowCarSprite[DrawY-YellowCarY4][DrawX-YellowCarX4] == 1)
		begin
			Red = 8'hff;
			Green = 8'h00;
			Blue = 8'h00;
		end	
		else if(yellowCar4 == 1 && YellowCarSprite[DrawY-YellowCarY4][DrawX-YellowCarX4] == 2)
		begin
			Red = 8'hff;
			Green = 8'hff;
			Blue = 8'h00;
		end		
		else if(yellowCar4 == 1 && YellowCarSprite[DrawY-YellowCarY4][DrawX-YellowCarX4] == 3)
		begin
			Red = 8'h97;
			Green = 8'h00;
			Blue = 8'hf7;
		end
		
		
		/*************** Gray Cars *****************/
		else if(grayCar1 == 1 && GrayCarSprite[DrawY-GrayCarY1][DrawX-GrayCarX1] == 1)
		begin
			Red = 8'hff;
			Green = 8'h00;
			Blue = 8'h00;
		end	
		else if(grayCar1 == 1 && GrayCarSprite[DrawY-GrayCarY1][DrawX-GrayCarX1] == 2)
		begin
			Red = 8'hde;
			Green = 8'hde;
			Blue = 8'hf7;
		end		
		else if(grayCar1 == 1 && GrayCarSprite[DrawY-GrayCarY1][DrawX-GrayCarX1] == 3)
		begin
			Red = 8'h21;
			Green = 8'hde;
			Blue = 8'h00;
		end	 	  
		
		else if(grayCar2 == 1 && GrayCarSprite[DrawY-GrayCarY2][DrawX-GrayCarX2] == 1)
		begin
			Red = 8'hff;
			Green = 8'h00;
			Blue = 8'h00;
		end	
		else if(grayCar2 == 1 && GrayCarSprite[DrawY-GrayCarY2][DrawX-GrayCarX2] == 2)
		begin
			Red = 8'hde;
			Green = 8'hde;
			Blue = 8'hf7;
		end		
		else if(grayCar2 == 1 && GrayCarSprite[DrawY-GrayCarY2][DrawX-GrayCarX2] == 3)
		begin
			Red = 8'h21;
			Green = 8'hde;
			Blue = 8'h00;
		end	 	  
		
		/*************** Frogger *****************/
		else if(frog == 1 && Life1 > 0 && FrogSprite[DrawY-Ball1Y][DrawX-Ball1X] == 1)
		begin
			Red = 8'h21;
			Green = 8'hde;
			Blue = 8'h00;
		end	
		else if(frog == 1 && Life1 > 0 && FrogSprite[DrawY-Ball1Y][DrawX-Ball1X] == 2)
		begin
			Red = 8'hff;
			Green = 8'hff;
			Blue = 8'h00;
		end		
		else if(frog == 1 && Life1 > 0 && FrogSprite[DrawY-Ball1Y][DrawX-Ball1X] == 3)
		begin
			Red = 8'hff;
			Green = 8'h47;
			Blue = 8'hf7;
		end	 	 
	
	   /*************** Frogger 2 *****************/
		else if(frog2 == 1 && Life2 > 0 && FrogSprite[DrawY-Ball2Y][DrawX-Ball2X] == 1)
		begin
			Red = 8'h00;
			Green = 8'hff;
			Blue = 8'hff;
		end	
		else if(frog2 == 1 && Life2 > 0 && FrogSprite[DrawY-Ball2Y][DrawX-Ball2X] == 2)
		begin
			Red = 8'hff;
			Green = 8'h00;
			Blue = 8'hff;
		end		
		else if(frog2 == 1 && Life2 > 0 && FrogSprite[DrawY-Ball2Y][DrawX-Ball2X] == 3)
		begin
			Red = 8'hff;
			Green = 8'h00;
			Blue = 8'h00;
		end	 
		
		
		/*************** Fish Three*****************/
		else if(fishThree1 == 1 && FishThreeSprite[DrawY-FishThreeY1][DrawX-FishThreeX1] == 1)
		begin
			Red = 8'hde;
			Green = 8'hde;
			Blue = 8'hf7;
		end	
		else if(fishThree1 == 1 && FishThreeSprite[DrawY-FishThreeY1][DrawX-FishThreeX1] == 2)
		begin
			Red = 8'h21;
			Green = 8'hde;
			Blue = 8'h00;
		end		
		else if(fishThree1 == 1 && FishThreeSprite[DrawY-FishThreeY1][DrawX-FishThreeX1] == 3)
		begin
			Red = 8'hff;
			Green = 8'h00;
			Blue = 8'h00;
		end	 	  
	      
		else if(fishThree2 == 1 && FishThreeSprite[DrawY-FishThreeY2][DrawX-FishThreeX2] == 1)
		begin
			Red = 8'hde;
			Green = 8'hde;
			Blue = 8'hf7;
		end	
		else if(fishThree2 == 1 && FishThreeSprite[DrawY-FishThreeY2][DrawX-FishThreeX2] == 2)
		begin
			Red = 8'h21;
			Green = 8'hde;
			Blue = 8'h00;
		end		
		else if(fishThree2 == 1 && FishThreeSprite[DrawY-FishThreeY2][DrawX-FishThreeX2] == 3)
		begin
			Red = 8'hff;
			Green = 8'h00;
			Blue = 8'h00;
		end	 	  
		
		else if(fishThree3 == 1 && FishThreeSprite[DrawY-FishThreeY3][DrawX-FishThreeX3] == 1)
		begin
			Red = 8'hde;
			Green = 8'hde;
			Blue = 8'hf7;
		end	
		else if(fishThree3 == 1 && FishThreeSprite[DrawY-FishThreeY3][DrawX-FishThreeX3] == 2)
		begin
			Red = 8'h21;
			Green = 8'hde;
			Blue = 8'h00;
		end		
		else if(fishThree3 == 1 && FishThreeSprite[DrawY-FishThreeY3][DrawX-FishThreeX3] == 3)
		begin
			Red = 8'hff;
			Green = 8'h00;
			Blue = 8'h00;
		end	 	  
			
			
	   /*************** Logs *****************/
		else if(log1 == 1 && LogSprite[DrawY-LogY1][DrawX-LogX1] == 1)
		begin
			Red = 8'hde;
			Green = 8'h68;
			Blue = 8'h4f;
		end	
		else if(log1 == 1 && LogSprite[DrawY-LogY1][DrawX-LogX1] == 2)
		begin
			Red = 8'h97;
			Green = 8'h68;
			Blue = 8'h4f;
		end		
		else if(log1 == 1 && LogSprite[DrawY-LogY1][DrawX-LogX1] == 3)
		begin
			Red = 8'hde;
			Green = 8'hde;
			Blue = 8'hf7;
		end	 	  
		
		else if(log2 == 1 && LogSprite[DrawY-LogY2][DrawX-LogX2] == 1)
		begin
			Red = 8'hde;
			Green = 8'h68;
			Blue = 8'h4f;
		end	
		else if(log2 == 1 && LogSprite[DrawY-LogY2][DrawX-LogX2] == 2)
		begin
			Red = 8'h97;
			Green = 8'h68;
			Blue = 8'h4f;
		end		
		else if(log2 == 1 && LogSprite[DrawY-LogY2][DrawX-LogX2] == 3)
		begin
			Red = 8'hde;
			Green = 8'hde;
			Blue = 8'hf7;
		end	 	  
		
		else if(log3 == 1 && LogSprite[DrawY-LogY3][DrawX-LogX3] == 1)
		begin
			Red = 8'hde;
			Green = 8'h68;
			Blue = 8'h4f;
		end	
		else if(log3 == 1 && LogSprite[DrawY-LogY3][DrawX-LogX3] == 2)
		begin
			Red = 8'h97;
			Green = 8'h68;
			Blue = 8'h4f;
		end		
		else if(log3 == 1 && LogSprite[DrawY-LogY3][DrawX-LogX3] == 3)
		begin
			Red = 8'hde;
			Green = 8'hde;
			Blue = 8'hf7;
		end	 	  
		
		
		/*************** Fish Two*****************/
		else if(fishTwo1 == 1 && FishTwoSprite[DrawY-FishTwoY1][DrawX-FishTwoX1] == 1)
		begin
			Red = 8'hde;
			Green = 8'hde;
			Blue = 8'hf7;
		end	
		else if(fishTwo1 == 1 && FishTwoSprite[DrawY-FishTwoY1][DrawX-FishTwoX1] == 2)
		begin
			Red = 8'h21;
			Green = 8'hde;
			Blue = 8'h00;
		end		
		else if(fishTwo1 == 1 && FishTwoSprite[DrawY-FishTwoY1][DrawX-FishTwoX1] == 3)
		begin
			Red = 8'hff;
			Green = 8'h00;
			Blue = 8'h00;
		end	 	  
	      
		else if(fishTwo2 == 1 && FishTwoSprite[DrawY-FishTwoY2][DrawX-FishTwoX2] == 1)
		begin
			Red = 8'hde;
			Green = 8'hde;
			Blue = 8'hf7;
		end	
		else if(fishTwo2 == 1 && FishTwoSprite[DrawY-FishTwoY2][DrawX-FishTwoX2] == 2)
		begin
			Red = 8'h21;
			Green = 8'hde;
			Blue = 8'h00;
		end		
		else if(fishTwo2 == 1 && FishTwoSprite[DrawY-FishTwoY2][DrawX-FishTwoX2] == 3)
		begin
			Red = 8'hff;
			Green = 8'h00;
			Blue = 8'h00;
		end	 	  
		
		else if(fishTwo3 == 1 && FishTwoSprite[DrawY-FishTwoY3][DrawX-FishTwoX3] == 1)
		begin
			Red = 8'hde;
			Green = 8'hde;
			Blue = 8'hf7;
		end	
		else if(fishTwo3 == 1 && FishTwoSprite[DrawY-FishTwoY3][DrawX-FishTwoX3] == 2)
		begin
			Red = 8'h21;
			Green = 8'hde;
			Blue = 8'h00;
		end		
		else if(fishTwo3 == 1 && FishTwoSprite[DrawY-FishTwoY3][DrawX-FishTwoX3] == 3)
		begin
			Red = 8'hff;
			Green = 8'h00;
			Blue = 8'h00;
		end	 	

	   else if(fishTwo4 == 1 && FishTwoSprite[DrawY-FishTwoY4][DrawX-FishTwoX4] == 1)
		begin
			Red = 8'hde;
			Green = 8'hde;
			Blue = 8'hf7;
		end	
		else if(fishTwo4 == 1 && FishTwoSprite[DrawY-FishTwoY4][DrawX-FishTwoX4] == 2)
		begin
			Red = 8'h21;
			Green = 8'hde;
			Blue = 8'h00;
		end		
		else if(fishTwo4 == 1 && FishTwoSprite[DrawY-FishTwoY4][DrawX-FishTwoX4] == 3)
		begin
			Red = 8'hff;
			Green = 8'h00;
			Blue = 8'h00;
		end	 	  
		
		else if(fishTwo5 == 1 && FishTwoSprite[DrawY-FishTwoY5][DrawX-FishTwoX5] == 1)
		begin
			Red = 8'hde;
			Green = 8'hde;
			Blue = 8'hf7;
		end	
		else if(fishTwo5 == 1 && FishTwoSprite[DrawY-FishTwoY5][DrawX-FishTwoX5] == 2)
		begin
			Red = 8'h21;
			Green = 8'hde;
			Blue = 8'h00;
		end		
		else if(fishTwo5 == 1 && FishTwoSprite[DrawY-FishTwoY5][DrawX-FishTwoX5] == 3)
		begin
			Red = 8'hff;
			Green = 8'h00;
			Blue = 8'h00;
		end	
		
      /*************** Big Logs *****************/
		else if(bigLog1 == 1 && BigLogSprite[DrawY-BigLogY1][DrawX-BigLogX1] == 1)
		begin
			Red = 8'hde;
			Green = 8'h68;
			Blue = 8'h4f;
		end	
		else if(bigLog1 == 1 && BigLogSprite[DrawY-BigLogY1][DrawX-BigLogX1] == 2)
		begin
			Red = 8'h97;
			Green = 8'h68;
			Blue = 8'h4f;
		end		
		else if(bigLog1 == 1 && BigLogSprite[DrawY-BigLogY1][DrawX-BigLogX1] == 3)
		begin
			Red = 8'hde;
			Green = 8'hde;
			Blue = 8'hf7;
		end	 	  
		
		else if(bigLog2 == 1 && BigLogSprite[DrawY-BigLogY2][DrawX-BigLogX2] == 1)
		begin
			Red = 8'hde;
			Green = 8'h68;
			Blue = 8'h4f;
		end	
		else if(bigLog2 == 1 && BigLogSprite[DrawY-BigLogY2][DrawX-BigLogX2] == 2)
		begin
			Red = 8'h97;
			Green = 8'h68;
			Blue = 8'h4f;
		end		
		else if(bigLog2 == 1 && BigLogSprite[DrawY-BigLogY2][DrawX-BigLogX2] == 3)
		begin
			Red = 8'hde;
			Green = 8'hde;
			Blue = 8'hf7;
		end	 	  
		
		else if(bigLog3 == 1 && BigLogSprite[DrawY-BigLogY3][DrawX-BigLogX3] == 1)
		begin
			Red = 8'hde;
			Green = 8'h68;
			Blue = 8'h4f;
		end	
		else if(bigLog3 == 1 && BigLogSprite[DrawY-BigLogY3][DrawX-BigLogX3] == 2)
		begin
			Red = 8'h97;
			Green = 8'h68;
			Blue = 8'h4f;
		end		
		else if(bigLog3 == 1 && BigLogSprite[DrawY-BigLogY3][DrawX-BigLogX3] == 3)
		begin
			Red = 8'hde;
			Green = 8'hde;
			Blue = 8'hf7;
		end	 	  
		
		/*************** Safe Frogs *****************/
		else if((safe1 | safe1x | winreset) && safeFrog1 == 1 && SafeFrogSprite[DrawY-SafeFrogY][DrawX-SafeFrog1X] == 1)
		begin
			Red = 8'h21;
			Green = 8'hde;
			Blue = 8'h00;
		end	
		else if((safe1 | safe1x | winreset) && safeFrog1 == 1 && SafeFrogSprite[DrawY-SafeFrogY][DrawX-SafeFrog1X] == 3)
		begin
			Red = 8'h00;
			Green = 8'hde;
			Blue = 8'hf7;
		end
		else if((safe1 | safe1x | winreset) && safeFrog1 == 1 && SafeFrogSprite[DrawY-SafeFrogY][DrawX-SafeFrog1X] == 2)
		begin
			Red = 8'hff;
			Green = 8'h47;
			Blue = 8'h00;
		end		
		
		else if((safe2 | safe2x | winreset) && safeFrog2 == 1 && SafeFrogSprite[DrawY-SafeFrogY][DrawX-SafeFrog2X] == 1)
		begin
			Red = 8'h21;
			Green = 8'hde;
			Blue = 8'h00;
		end	
		else if((safe2 | safe2x |winreset) && safeFrog2 == 1 && SafeFrogSprite[DrawY-SafeFrogY][DrawX-SafeFrog2X] == 3)
		begin
			Red = 8'h00;
			Green = 8'hde;
			Blue = 8'hf7;
		end
		else if((safe2 | safe2x | winreset) && safeFrog2 == 1 && SafeFrogSprite[DrawY-SafeFrogY][DrawX-SafeFrog2X] == 2)
		begin
			Red = 8'hff;
			Green = 8'h47;
			Blue = 8'h00;
		end		
		
		else if((safe3 | safe3x | winreset) && safeFrog3 == 1 && SafeFrogSprite[DrawY-SafeFrogY][DrawX-SafeFrog3X] == 1)
		begin
			Red = 8'h21;
			Green = 8'hde;
			Blue = 8'h00;
		end	
		else if((safe3 | safe3x | winreset) && safeFrog3 == 1 && SafeFrogSprite[DrawY-SafeFrogY][DrawX-SafeFrog3X] == 3)
		begin
			Red = 8'h00;
			Green = 8'hde;
			Blue = 8'hf7;
		end
		else if((safe3 | safe3x | winreset) && safeFrog3 == 1 && SafeFrogSprite[DrawY-SafeFrogY][DrawX-SafeFrog3X] == 2)
		begin
			Red = 8'hff;
			Green = 8'h47;
			Blue = 8'h00;
		end		
		
		else if((safe4 | safe4x | winreset) && safeFrog4 == 1 && SafeFrogSprite[DrawY-SafeFrogY][DrawX-SafeFrog4X] == 1)
		begin
			Red = 8'h21;
			Green = 8'hde;
			Blue = 8'h00;
		end	
		else if((safe4 | safe4x | winreset) && safeFrog4 == 1 && SafeFrogSprite[DrawY-SafeFrogY][DrawX-SafeFrog4X] == 3)
		begin
			Red = 8'h00;
			Green = 8'hde;
			Blue = 8'hf7;
		end
		else if((safe4 | safe4x | winreset) && safeFrog4 == 1 && SafeFrogSprite[DrawY-SafeFrogY][DrawX-SafeFrog4X] == 2)
		begin
			Red = 8'hff;
			Green = 8'h47;
			Blue = 8'h00;
		end		
		
		else if((safe5 | safe5x | winreset) && safeFrog5 == 1 && SafeFrogSprite[DrawY-SafeFrogY][DrawX-SafeFrog5X] == 1)
		begin
			Red = 8'h21;
			Green = 8'hde;
			Blue = 8'h00;
		end	
		else if((safe5 | safe5x | winreset) && safeFrog5 == 1 && SafeFrogSprite[DrawY-SafeFrogY][DrawX-SafeFrog5X] == 3)
		begin
			Red = 8'h00;
			Green = 8'hde;
			Blue = 8'hf7;
		end
		else if((safe5 | safe5x | winreset) && safeFrog5 == 1 && SafeFrogSprite[DrawY-SafeFrogY][DrawX-SafeFrog5X] == 2)
		begin
			Red = 8'hff;
			Green = 8'h47;
			Blue = 8'h00;
		end		
		
	   /*************** Background *****************/			
	  else if(blue == 1'b1)
		begin
		Red = 8'h00;
		Green = 8'h00;
		Blue = 8'h47;
		end
	
	else if(green == 1'b1)
		begin
		Red = 8'h21;
		Green = 8'hde;
		Blue = 8'h00;
		end
	
	else if(purple == 1'b1)
		begin
		Red = 8'h97;
		Green = 8'h00;
		Blue = 8'hf7;
		end
	
	else
		begin
		Red = 8'h00;
		Green = 8'h00;
		Blue = 8'h00;
		end
    end 
    
endmodule
