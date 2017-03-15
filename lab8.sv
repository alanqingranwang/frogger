//-------------------------------------------------------------------------
//      lab7_usb.sv                                                      --
//      Christine Chen                                                   --
//      Fall 2014                                                        --
//                                                                       --
//      Fall 2014 Distribution                                           --
//                                                                       --
//      For use with ECE 385 Lab 7                                       --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------


module  lab8 		( input         CLOCK_50,
                       input[3:0]    KEY, //bit 0 is set up as Reset
							  output [6:0]  HEX0, HEX1, 
							  output [8:0]  LEDG,
							  output [17:0] LEDR,
							  // VGA Interface 
                       output [7:0]  VGA_R,					//VGA Red
							                VGA_G,					//VGA Green
												 VGA_B,					//VGA Blue
							  output        VGA_CLK,				//VGA Clock
							                VGA_SYNC_N,			//VGA Sync signal
												 VGA_BLANK_N,			//VGA Blank signal
												 VGA_VS,					//VGA vertical sync signal	
												 VGA_HS,					//VGA horizontal sync signal
							  // CY7C67200 Interface
							  inout [15:0]  OTG_DATA,						//	CY7C67200 Data bus 16 Bits
							  output [1:0]  OTG_ADDR,						//	CY7C67200 Address 2 Bits
							  output        OTG_CS_N,						//	CY7C67200 Chip Select
												 OTG_RD_N,						//	CY7C67200 Write
												 OTG_WR_N,						//	CY7C67200 Read
												 OTG_RST_N,						//	CY7C67200 Reset
							  input			 OTG_INT,						//	CY7C67200 Interrupt
							  // SDRAM Interface for Nios II Software
							  output [12:0] DRAM_ADDR,				// SDRAM Address 13 Bits
							  inout [31:0]  DRAM_DQ,				// SDRAM Data 32 Bits
							  output [1:0]  DRAM_BA,				// SDRAM Bank Address 2 Bits
							  output [3:0]  DRAM_DQM,				// SDRAM Data Mast 4 Bits
							  output			 DRAM_RAS_N,			// SDRAM Row Address Strobe
							  output			 DRAM_CAS_N,			// SDRAM Column Address Strobe
							  output			 DRAM_CKE,				// SDRAM Clock Enable
							  output			 DRAM_WE_N,				// SDRAM Write Enable
							  output			 DRAM_CS_N,				// SDRAM Chip Select
							  output			 DRAM_CLK				// SDRAM Clock
											);
    
    logic Reset_h, vssig, Clk;
    // logic [9:0] drawxsig, drawysig, ballxsig, ballysig, ballsizesig;
	 logic [15:0] keycode;
    
	 
	 assign {Reset_h} = ~(KEY[0]);
	 assign Clk = CLOCK_50;
	 
	 logic [0:15][0:15][0:1]  FrogSprite;
	 logic [0:15][0:31][0:1]  TruckSprite;
	 logic [0:15][0:15][0:1]  YellowCarSprite;
	 logic [0:15][0:15][0:1]  GrayCarSprite;
	 logic [0:15][0:15][0:1]  TractorSprite;
	 logic [0:15][0:47][0:1]  FishThreeSprite;
	 logic [0:15][0:47][0:1]  LogSprite;	 
	 logic [0:15][0:31][0:1]  FishTwoSprite;
	 logic [0:15][0:63][0:1]  BigLogSprite;
	 logic [0:17][0:17][0:1]  SafeFrogSprite;
	 logic [0:16][0:111][0:1] TitleSprite;
	 logic [0:15][0:15][0:1]  DeathSprite;
	 logic [0:9][0:103][0:1]  Player1Sprite;
	 logic [0:9][0:103][0:1]  Player2Sprite;	 
	 logic [0:9][0:55][0:1]   WinSprite;
	 logic [0:9][0:71][0:1]   GameOverSprite;
	 logic [0:9][0:87][0:1]   PressEnterSprite;
	 
	 logic frogreset1, frogreset2;
	 logic [3:0] Life1;
	 logic [3:0] Life2;
	 logic frogwins;
	 logic startx, winx, gameoverx;
	 
	 logic stage1x, stage2x;
	 logic player2;
	 logic onfish31, fish3moved, water1, water2, onlog, logmoved, onfish2, fish2moved, onbiglog, biglogmoved;
	 
	 logic onfish32, onlog2, onfish22, onbiglog2;
	 
	 logic safe1, safe2, safe3, safe4, safe5;
	 logic safe12, safe22, safe32, safe42, safe52;
	 
	 logic winreset;
	 logic winreset2;
	 
	 logic holdx;
	 
	 

	 
	 wire [1:0] hpi_addr;
	 wire [15:0] hpi_data_in, hpi_data_out;
	 wire hpi_r, hpi_w,hpi_cs;
	 
	 hpi_io_intf hpi_io_inst(   .from_sw_address(hpi_addr),
										 .from_sw_data_in(hpi_data_in),
										 .from_sw_data_out(hpi_data_out),
										 .from_sw_r(hpi_r),
										 .from_sw_w(hpi_w),
										 .from_sw_cs(hpi_cs),
		 								 .OTG_DATA(OTG_DATA),    
										 .OTG_ADDR(OTG_ADDR),    
										 .OTG_RD_N(OTG_RD_N),    
										 .OTG_WR_N(OTG_WR_N),    
										 .OTG_CS_N(OTG_CS_N),    
										 .OTG_RST_N(OTG_RST_N),   
										 .OTG_INT(OTG_INT),
										 .Clk(Clk),
										 .Reset(Reset_h)
	 );
	 
	 //The connections for nios_system might be named different depending on how you set up Qsys
	 nios_system m_nios_system(
										 .clk_clk(Clk),         
										 .reset_reset_n(KEY[0]),   
										 .sdram_wire_addr(DRAM_ADDR), 
										 .sdram_wire_ba(DRAM_BA),   
										 .sdram_wire_cas_n(DRAM_CAS_N),
										 .sdram_wire_cke(DRAM_CKE),  
										 .sdram_wire_cs_n(DRAM_CS_N), 
										 .sdram_wire_dq(DRAM_DQ),   
										 .sdram_wire_dqm(DRAM_DQM),  
										 .sdram_wire_ras_n(DRAM_RAS_N),
										 .sdram_wire_we_n(DRAM_WE_N), 
										 .sdram_clk_clk(DRAM_CLK),
										 .keycode_export(keycode),  
										 .otg_hpi_address_export(hpi_addr),
										 .otg_hpi_data_in_port(hpi_data_in),
										 .otg_hpi_data_out_port(hpi_data_out),
										 .otg_hpi_cs_export(hpi_cs),
										 .otg_hpi_r_export(hpi_r),
										 .otg_hpi_w_export(hpi_w));
	
	 //Fill in the connections for the rest of the modules

	 logic [9:0]	x1, y1, x2, y2, s, Dx, Dy;
	
    vga_controller vgasync_instance( .Clk(Clk),       
                                     .Reset(Reset_h), 
                                     .hs(VGA_HS),        
								             .vs(VGA_VS),        
												 .pixel_clk(VGA_CLK),
												 .blank(VGA_BLANK_N),    
												 .sync(VGA_SYNC_N),      
								             .DrawX(Dx),     
								             .DrawY(Dy));  
	 
    ball ball1( .Reset(Reset_h), 
	                     .frame_clk(Clk),
                        .BallX(x1), 
								.BallY(y1), 
								.keycode(keycode),
								.frogreset(frogreset1),
								.stage1x(stage1x),
								.stage2x(stage2x),
								.onfish3(onfish31),
								.onlog(onlog),
								.onfish2(onfish2),
								.onbiglog(onbiglog),
								.fish3moved(fish3moved),
								.logmoved(logmoved),
								.fish2moved(fish2moved),
								.biglogmoved(biglogmoved),
								.lives(Life1)
    );
		
    ball2 ball( .Reset(Reset_h), 
	                     .frame_clk(Clk),
                        .BallX(x2), 
								.BallY(y2), 
								.keycode(keycode),
								.frogreset(frogreset2),
								.stage1x(stage1x),
								.stage2x(stage2x),
								.onfish3(onfish32),
								.onlog(onlog2),
								.onfish2(onfish22),
								.onbiglog(onbiglog2),
								.fish3moved(fish3moved),
								.logmoved(logmoved),
								.fish2moved(fish2moved),
								.biglogmoved(biglogmoved),
								.lives(Life2)
    );
		
	 /*		
	 ball2 ball2( .Reset(Reset_h), 
	                     .frame_clk(VGA_VS),
                        .BallX(x2), 
								.BallY(y2), 
								.keycode(keycode),
								.frogreset(frogreset2),
								.stage1x(stage1x),
								.stage2x(stage2x),
								.player2(player2)
	 );
     */
	  
	  
	 /*************** Trucks *****************/
	 logic [9:0]	Truckx1, Trucky1;
	 truck truck1( .Reset(Reset_h), 
	                      .frame_clk(Clk),
								 .truckCenter(431),
								 .stage2x(stage2x),
                         .truckX(Truckx1),
								 .truckY(Trucky1));
								 
	 logic [9:0]	Truckx2, Trucky2;
	 truck truck2( .Reset(Reset_h), 
	                      .frame_clk(Clk),
								 .truckCenter(527),
								 .stage2x(stage2x),
                         .truckX(Truckx2),
								 .truckY(Trucky2));
								 
	 logic [9:0]	Truckx3, Trucky3;
	 truck truck3( .Reset(Reset_h), 
	                      .frame_clk(Clk),
								 .truckCenter(623),
								 .stage2x(stage2x),
                         .truckX(Truckx3),
								 .truckY(Trucky3));
							
	 /*************** Tractors *****************/		
	 logic [9:0]	Tractorx1, Tractory1;
	 tractor tractor1( .Reset(Reset_h), 
	                      .frame_clk(Clk),
								 .tractorCenter(191),
								 .stage2x(stage2x),
                         .tractorX(Tractorx1),
								 .tractorY(Tractory1));
								 
	 logic [9:0]	Tractorx2, Tractory2;
	 tractor tractor2( .Reset(Reset_h), 
	                      .frame_clk(Clk),
								 .tractorCenter(135),
								 .stage2x(stage2x),
                         .tractorX(Tractorx2),
								 .tractorY(Tractory2));
								 
	 logic [9:0]	Tractorx3, Tractory3;
	 tractor tractor3( .Reset(Reset_h), 
	                      .frame_clk(Clk),
								 .tractorCenter(79),
								 .stage2x(stage2x),
                         .tractorX(Tractorx3),
								 .tractorY(Tractory3));
								 
	 logic [9:0]	Tractorx4, Tractory4;
	 tractor tractor4( .Reset(Reset_h), 
	                      .frame_clk(Clk),
								 .tractorCenter(23),
								 .stage2x(stage2x),
                         .tractorX(Tractorx4),
								 .tractorY(Tractory4));
								 
	 /*************** Yellow Cars *****************/
	 logic [9:0]	YellowCarx1, YellowCary1;
	 yellowCar yellowCar1( .Reset(Reset_h), 
	                      .frame_clk(Clk),
								 .yellowCarCenter(431),
								 .stage2x(stage2x),
                         .yellowCarX(YellowCarx1),
								 .yellowCarY(YellowCary1));
								 
	 logic [9:0]	YellowCarx2, YellowCary2;
	 yellowCar yellowCar2( .Reset(Reset_h), 
	                      .frame_clk(Clk),
								 .yellowCarCenter(487),
								 .stage2x(stage2x),
                         .yellowCarX(YellowCarx2),
								 .yellowCarY(YellowCary2));
								 
	 logic [9:0]	YellowCarx3, YellowCary3;
	 yellowCar yellowCar3( .Reset(Reset_h), 
	                      .frame_clk(Clk),
								 .yellowCarCenter(543),
								 .stage2x(stage2x),
                         .yellowCarX(YellowCarx3),
								 .yellowCarY(YellowCary3));
								 
	 logic [9:0]	YellowCarx4, YellowCary4;
	 yellowCar yellowCar4( .Reset(Reset_h), 
	                      .frame_clk(Clk),
								 .yellowCarCenter(599),
								 .stage2x(stage2x),
                         .yellowCarX(YellowCarx4),
								 .yellowCarY(YellowCary4));
								 
								 
	 /*************** Gray Cars *****************/								 
	 logic [9:0]	GrayCarx1, GrayCary1;
	 grayCar grayCar1( .Reset(Reset_h), 
	                      .frame_clk(Clk),
								 .grayCarCenter(191),
								 .stage2x(stage2x),
                         .grayCarX(GrayCarx1),
								 .grayCarY(GrayCary1));
								 
	 logic [9:0]	GrayCarx2, GrayCary2;
	 grayCar grayCar2( .Reset(Reset_h), 
	                      .frame_clk(Clk),
								 .grayCarCenter(150),
								 .stage2x(stage2x),
                         .grayCarX(GrayCarx2),
								 .grayCarY(GrayCary2)); 
								 
								 
	 /*************** Fish Three *****************/								 
	 logic [9:0]	FishThreex1, FishThreey1;
	 fishThree fishThree1( .Reset(Reset_h), 
	                      .frame_clk(Clk),
								 .fishThreeCenter(431),
                         .fishThreeX(FishThreex1),
								 .fishThreeY(FishThreey1),
								 .stage2x(stage2x),
								 .moved(fish3moved)
	 );		
	
    logic [9:0]	FishThreex2, FishThreey2;
	 fishThree fishThree2( .Reset(Reset_h), 
	                      .frame_clk(Clk),
								 .fishThreeCenter(495),
                         .fishThreeX(FishThreex2),
								 .fishThreeY(FishThreey2),
								 .stage2x(stage2x)
	 );	
							
	 logic [9:0]	FishThreex3, FishThreey3;
	 fishThree fishThree3( .Reset(Reset_h), 
	                      .frame_clk(Clk),
								 .fishThreeCenter(559),
                         .fishThreeX(FishThreex3),
								 .fishThreeY(FishThreey3),
								 .stage2x(stage2x)
	 );	
								 
	 /*************** Fish Two *****************/								 
	 logic [9:0]	FishTwox1, FishTwoy1;
	 fishTwo fishTwo1( .Reset(Reset_h), 
	                      .frame_clk(Clk),
								 .fishTwoCenter(431),
                         .fishTwoX(FishTwox1),
								 .fishTwoY(FishTwoy1),
								 .moved(fish2moved));		
	
    logic [9:0]	FishTwox2, FishTwoy2;
	 fishTwo fishTwo2( .Reset(Reset_h), 
	                      .frame_clk(Clk),
								 .fishTwoCenter(479),
                         .fishTwoX(FishTwox2),
								 .fishTwoY(FishTwoy2)
	 );	
							
	 logic [9:0]	FishTwox3, FishTwoy3;
	 fishTwo fishTwo3( .Reset(Reset_h), 
	                      .frame_clk(Clk),
								 .fishTwoCenter(527),
                         .fishTwoX(FishTwox3),
								 .fishTwoY(FishTwoy3));
								
	 logic [9:0]	FishTwox4, FishTwoy4;
	 fishTwo fishTwo4( .Reset(Reset_h), 
	                      .frame_clk(Clk),
								 .fishTwoCenter(575),
                         .fishTwoX(FishTwox4),
								 .fishTwoY(FishTwoy4));
								
	 logic [9:0]	FishTwox5, FishTwoy5;
	 fishTwo fishTwo5( .Reset(Reset_h), 
	                      .frame_clk(Clk),
								 .fishTwoCenter(623),
                         .fishTwoX(FishTwox5),
								 .fishTwoY(FishTwoy5));	
							
	 /*************** Small Logs *****************/								 
	 logic [9:0]	Logx1, Logy1;
	 log log1( .Reset(Reset_h), 
	                      .frame_clk(Clk),
								 .logXCenter(159),
								 .logYCenter(202),
                         .logX(Logx1),
								 .logY(Logy1),
								 .moved(logmoved)
	 );
							
	 logic [9:0]	Logx2, Logy2;
	 log log2( .Reset(Reset_h), 
	                      .frame_clk(Clk),
								 .logXCenter(89),
								 .logYCenter(202),
                         .logX(Logx2),
								 .logY(Logy2));
							
	 logic [9:0]	Logx3, Logy3;
	 log log3( .Reset(Reset_h), 
	                      .frame_clk(Clk),
								 .logXCenter(19),
								 .logYCenter(202),
                         .logX(Logx3),
								 .logY(Logy3));		
								 
	 /*************** Big Logs *****************/								 
	 logic [9:0]	BigLogx1, BigLogy1;
	 bigLog biglog1( .Reset(Reset_h), 
	                      .frame_clk(Clk),
								 .bigLogXCenter(159),
								 .bigLogYCenter(162),
                         .bigLogX(BigLogx1),
								 .bigLogY(BigLogy1),
								 .moved(biglogmoved));
							
	 logic [9:0]	BigLogx2, BigLogy2;
	 bigLog biglog2( .Reset(Reset_h), 
	                      .frame_clk(Clk),
								 .bigLogXCenter(75),
								 .bigLogYCenter(162),
                         .bigLogX(BigLogx2),
								 .bigLogY(BigLogy2));
							
	 logic [9:0]	BigLogx3, BigLogy3;
	 bigLog biglog3( .Reset(Reset_h), 
	                      .frame_clk(Clk),
								 .bigLogXCenter(0),
								 .bigLogYCenter(162),
                         .bigLogX(BigLogx3),
								 .bigLogY(BigLogy3));		
	

	 hitdetection hitdetection1( .frame_clk(VGA_VS), 
	                      .Reset(Reset_h),
					          .frogX1(x1),
					          .frogY1(y1),
					          .truckX1(Truckx1),
					          .truckY1(Trucky1),
								 .truckX2(Truckx2),
								 .truckY2(Trucky2),
								 .truckX3(Truckx3),
								 .truckY3(Trucky3),
								 .grayCarX1(GrayCarx1),
								 .grayCarY1(GrayCary1),
								 .grayCarX2(GrayCarx2),
								 .grayCarY2(GrayCary2),
								 .yellowCarX1(YellowCarx1),
								 .yellowCarY1(YellowCary1),
								 .yellowCarX2(YellowCarx2),
								 .yellowCarY2(YellowCary2),
								 .yellowCarX3(YellowCarx3),
								 .yellowCarY3(YellowCary3),
								 .yellowCarX4(YellowCarx4),
								 .yellowCarY4(YellowCary4),
								 .tractorX1(Tractorx1),
								 .tractorY1(Tractory1),
								 .tractorX2(Tractorx2),
								 .tractorY2(Tractory2),
								 .tractorX3(Tractorx3),
								 .tractorY3(Tractory3),
								 .tractorX4(Tractorx4),
								 .tractorY4(Tractory4),
								 .stage2x(stage2x),
								 .gameoverx(gameoverx),
					          .frogreset(frogreset1),
					          .Life(Life1),
								 .water(water1),
								 .safe1(safe1), .safe2(safe2), .safe3(safe3), .safe4(safe4), .safe5(safe5),
								 .safe1x(safe12), .safe2x(safe22), .safe3x(safe32), .safe4x(safe42), .safe5x(safe52),
								 .winreset(winreset),
								 .winx(winx)
	 );
		

    hitdetection hitdetection2( .frame_clk(VGA_VS), 
	                      .Reset(Reset_h),
					          .frogX1(x2),
					          .frogY1(y2),
					          .truckX1(Truckx1),
					          .truckY1(Trucky1),
								 .truckX2(Truckx2),
								 .truckY2(Trucky2),
								 .truckX3(Truckx3),
								 .truckY3(Trucky3),
								 .grayCarX1(GrayCarx1),
								 .grayCarY1(GrayCary1),
								 .grayCarX2(GrayCarx2),
								 .grayCarY2(GrayCary2),
								 .yellowCarX1(YellowCarx1),
								 .yellowCarY1(YellowCary1),
								 .yellowCarX2(YellowCarx2),
								 .yellowCarY2(YellowCary2),
								 .yellowCarX3(YellowCarx3),
								 .yellowCarY3(YellowCary3),
								 .yellowCarX4(YellowCarx4),
								 .yellowCarY4(YellowCary4),
								 .tractorX1(Tractorx1),
								 .tractorY1(Tractory1),
								 .tractorX2(Tractorx2),
								 .tractorY2(Tractory2),
								 .tractorX3(Tractorx3),
								 .tractorY3(Tractory3),
								 .tractorX4(Tractorx4),
								 .tractorY4(Tractory4),
								 .stage2x(stage2x),
								 .gameoverx(gameoverx),
								 
					          .frogreset(frogreset2),
					          .Life(Life2),
								 .water(water2),
								 .safe1(safe12), .safe2(safe22), .safe3(safe32), .safe4(safe42), .safe5(safe52),
								 .safe1x(safe1), .safe2x(safe2), .safe3x(safe3), .safe4x(safe4), .safe5x(safe5),
								 .winreset(winreset),
								 .winx(winx)
	 );
	 /*
	 hitdetection hitdetection2( .frame_clk(VGA_VS), 
	                      .Reset(Reset_h),
					          .frogX1(x2),
					          .frogY1(y2),
					          .truckX1(Truckx1),
					          .truckY1(Trucky1),
								 .truckX2(Truckx2),
								 .truckY2(Trucky2),
								 .truckX3(Truckx3),
								 .truckY3(Trucky3),
								 .grayCarX1(GrayCarx1),
								 .grayCarY1(GrayCary1),
								 .grayCarX2(GrayCarx2),
								 .grayCarY2(GrayCary2),
								 .yellowCarX1(YellowCarx1),
								 .yellowCarY1(YellowCary1),
								 .yellowCarX2(YellowCarx2),
								 .yellowCarY2(YellowCary2),
								 .yellowCarX3(YellowCarx3),
								 .yellowCarY3(YellowCary3),
								 .yellowCarX4(YellowCarx4),
								 .yellowCarY4(YellowCary4),
								 .tractorX1(Tractorx1),
								 .tractorY1(Tractory1),
								 .tractorX2(Tractorx2),
								 .tractorY2(Tractory2),
								 .tractorX3(Tractorx3),
								 .tractorY3(Tractory3),
								 .tractorX4(Tractorx4),
								 .tractorY4(Tractory4),
								 .stage2x(stage2x),
								 .gameoverx(gameoverx),
					          .frogreset(frogreset2),
					          .Life(Life2),
								 .water(water2),
								 .winx(winx)
	 );*/
								 
	 logdetection logdetection1(
								 .frame_clk(Clk),
								 .Reset(Reset_h),
								 .frogX1(x1),
								 .frogY1(y1),
								 .fishThreeX1(FishThreex1),
								 .fishThreeY1(FishThreey1),
								 .fishThreeX2(FishThreex2),
								 .fishThreeY2(FishThreey2),
								 .fishThreeX3(FishThreex3),
								 .fishThreeY3(FishThreey3),
								 .logX1(Logx1),
								 .logY1(Logy1),
								 .logX2(Logx2),
								 .logY2(Logy2),
								 .logX3(Logx3),
								 .logY3(Logy3),
								 .fishTwoX1(FishTwox1),
								 .fishTwoY1(FishTwoy1),
								 .fishTwoX2(FishTwox2),
								 .fishTwoY2(FishTwoy2),
								 .fishTwoX3(FishTwox3),
								 .fishTwoY3(FishTwoy3),
								 .fishTwoX4(FishTwox4),
								 .fishTwoY4(FishTwoy4),
								 .fishTwoX5(FishTwox5),
								 .fishTwoY5(FishTwoy5),
								 .bigLogX1(BigLogx1),
								 .bigLogY1(BigLogy1),
								 .bigLogX2(BigLogx2),
								 .bigLogY2(BigLogy2),
								 .bigLogX3(BigLogx3),
								 .bigLogY3(BigLogy3),
								 .stage2x(stage2x),
								 .onfish3(onfish31),
								 .onlog(onlog),
								 .onfish2(onfish2),
								 .onbiglog(onbiglog),
								 .water(water1)
	 );					 
	 
	 logdetection logdetection2(
								 .frame_clk(Clk),
								 .Reset(Reset_h),
								 .frogX1(x2),
								 .frogY1(y2),
								 .fishThreeX1(FishThreex1),
								 .fishThreeY1(FishThreey1),
								 .fishThreeX2(FishThreex2),
								 .fishThreeY2(FishThreey2),
								 .fishThreeX3(FishThreex3),
								 .fishThreeY3(FishThreey3),
								 .logX1(Logx1),
								 .logY1(Logy1),
								 .logX2(Logx2),
								 .logY2(Logy2),
								 .logX3(Logx3),
								 .logY3(Logy3),
								 .fishTwoX1(FishTwox1),
								 .fishTwoY1(FishTwoy1),
								 .fishTwoX2(FishTwox2),
								 .fishTwoY2(FishTwoy2),
								 .fishTwoX3(FishTwox3),
								 .fishTwoY3(FishTwoy3),
								 .fishTwoX4(FishTwox4),
								 .fishTwoY4(FishTwoy4),
								 .fishTwoX5(FishTwox5),
								 .fishTwoY5(FishTwoy5),
								 .bigLogX1(BigLogx1),
								 .bigLogY1(BigLogy1),
								 .bigLogX2(BigLogx2),
								 .bigLogY2(BigLogy2),
								 .bigLogX3(BigLogx3),
								 .bigLogY3(BigLogy3),
								 .stage2x(stage2x),
								 
								 .onfish3(onfish32),
								 .onlog(onlog2),
								 .onfish2(onfish22),
								 .onbiglog(onbiglog2),
								 .water(water2)
	 );					 
								
								
	 assign frogwins = (safe1|safe12) & (safe2|safe22) & (safe3|safe32) & (safe4|safe42) & (safe5|safe52);
	 control control (.Clk(Clk), 
	                  .Reset(Reset_h),
							.Life1(Life1), 
							.Life2(Life2),
							.frogwins(frogwins), 
							.keycode(keycode),
							.startx(startx), 
							.winx(winx),
							.gameoverx(gameoverx), 
							.stage1x(stage1x),
							.stage2x(stage2x),
							.player2(player2),
							.winreset(winreset),
							.holdx(holdx)
	 );
						
    color_mapper color_instance( .Clk(VGA_VS),
											.startx(startx), 
											.winx(winx),
											.gameoverx(gameoverx), 
											.holdx(holdx),
											.p2(player2),
											.stage1x(stage1x),
											.stage2x(stage2x),
											.winreset(winreset),
											.Life1(Life1), .Life2(Life2),
											.safe1(safe1), .safe2(safe2), .safe3(safe3), .safe4(safe4), .safe5(safe5),
											.safe1x(safe12), .safe2x(safe22), .safe3x(safe32), .safe4x(safe42), .safe5x(safe52),
											.Ball1X(x1), 
	                              .Ball1Y(y1),
										   .Ball2X(x2),
										   .Ball2Y(y2),
											.TruckX1(Truckx1),
											.TruckY1(Trucky1),
											.TruckX2(Truckx2),
											.TruckY2(Trucky2),
											.TruckX3(Truckx3),
											.TruckY3(Trucky3),
											.TractorX1(Tractorx1),
											.TractorY1(Tractory1),
											.TractorX2(Tractorx2),
											.TractorY2(Tractory2),
											.TractorX3(Tractorx3),
											.TractorY3(Tractory3),
											.TractorX4(Tractorx4),
											.TractorY4(Tractory4),
											.YellowCarX1(YellowCarx1),
											.YellowCarY1(YellowCary1),
											.YellowCarX2(YellowCarx2),
											.YellowCarY2(YellowCary2),
											.YellowCarX3(YellowCarx3),
											.YellowCarY3(YellowCary3),
											.YellowCarX4(YellowCarx4),
											.YellowCarY4(YellowCary4),
											.GrayCarX1(GrayCarx1),
											.GrayCarY1(GrayCary1),
											.GrayCarX2(GrayCarx2),
											.GrayCarY2(GrayCary2),
											.FishThreeX1(FishThreex1),
											.FishThreeY1(FishThreey1),
											.FishThreeX2(FishThreex2),
											.FishThreeY2(FishThreey2),
											.FishThreeX3(FishThreex3),
											.FishThreeY3(FishThreey3),
											.LogX1(Logx1),
											.LogY1(Logy1),
											.LogX2(Logx2),
											.LogY2(Logy2),
											.LogX3(Logx3),
											.LogY3(Logy3),
											.FishTwoX1(FishTwox1),
											.FishTwoY1(FishTwoy1),
											.FishTwoX2(FishTwox2),
											.FishTwoY2(FishTwoy2),
											.FishTwoX3(FishTwox3),
											.FishTwoY3(FishTwoy3),
											.FishTwoX4(FishTwox4),
											.FishTwoY4(FishTwoy4),
											.FishTwoX5(FishTwox5),
											.FishTwoY5(FishTwoy5),
											.BigLogX1(BigLogx1),
											.BigLogY1(BigLogy1),
											.BigLogX2(BigLogx2),
											.BigLogY2(BigLogy2),
											.BigLogX3(BigLogx3),
											.BigLogY3(BigLogy3),
											.DrawX(Dx), 
											.DrawY(Dy), 
											.FrogSprite(FrogSprite),
											.TruckSprite(TruckSprite),
											.TractorSprite(TractorSprite),
											.YellowCarSprite(YellowCarSprite),
											.GrayCarSprite(GrayCarSprite),
											.FishThreeSprite(FishThreeSprite),
											.LogSprite(LogSprite),
											.FishTwoSprite(FishTwoSprite),
											.BigLogSprite(BigLogSprite),
											.SafeFrogSprite(SafeFrogSprite),
											.TitleSprite(TitleSprite),
											.Player1Sprite(Player1Sprite),
											.Player2Sprite(Player2Sprite),
											.DeathSprite(DeathSprite),
											.WinSprite(WinSprite),
											.GameOverSprite(GameOverSprite),
											.PressEnterSprite(PressEnterSprite),
                                 .Red(VGA_R), 
											.Green(VGA_G), 
											.Blue(VGA_B)
	 );
											
											
	 Sprites Sprites (
								.FrogSprite(FrogSprite),
								.TruckSprite(TruckSprite),
								.YellowCarSprite(YellowCarSprite),
								.GrayCarSprite(GrayCarSprite),
								.TractorSprite(TractorSprite),
								.FishThreeSprite(FishThreeSprite),
								.LogSprite(LogSprite),
								.FishTwoSprite(FishTwoSprite),
								.BigLogSprite(BigLogSprite),
								.SafeFrogSprite(SafeFrogSprite),
								.TitleSprite(TitleSprite),
								.DeathSprite(DeathSprite),
								.Player1Sprite(Player1Sprite),
								.Player2Sprite(Player2Sprite),
								.WinSprite(WinSprite),
								.GameOverSprite(GameOverSprite),
								.PressEnterSprite(PressEnterSprite)
	 );
										  
	 HexDriver hex_inst_0 (Life2, HEX0);
	 HexDriver hex_inst_1 (Life1, HEX1); 
	 
	 always_comb
		begin
			LEDR = 18'b000000000000000000;
			case(keycode)
			16'h0016: LEDR[0] = 1'b1;
			16'h0007: LEDR[1] = 1'b1;
			16'h001A: LEDR[2] = 1'b1;
			16'h0004: LEDR[3] = 1'b1;
			default: LEDR[3:0] = 4'b0000;
			endcase
		end
endmodule
