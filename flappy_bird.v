////////////////////////////////////////////////////////////
// Filename:    flappy_bird.v
// Author:      Peyton Garrett
// Date:        02 May 2019
// Version:     1
// Description: DE1-SoC Version of Flappy Bird. Plays similar
//              to the original mobile game. Your score is how
//              long you can last in the game. Highscore is kept
//              on the left most seven-segment LEDs with current 
//              score on the right. LEDR's will blink on game over.
//
//              KEY3 = "tap"
//              KEY2 = game reset
//


module flappy_bird(
	 input  wire       CLOCK_50,
    input  wire [3:0] KEY,
	 output wire [9:0] LEDR,
	 output wire [6:0] HEX0,
	 output wire [6:0] HEX1,
	 output wire [6:0] HEX4,
	 output wire [6:0] HEX5,
    output wire [7:0] VGA_R,
    output wire [7:0] VGA_G,
    output wire [7:0] VGA_B,
    output wire       VGA_CLK,
    output wire       VGA_BLANK_N,
    output wire       VGA_SYNC_N,
    output wire       VGA_HS,
    output wire       VGA_VS,
	 input wire [9:0]  SW);

	 
   wire 	      rst;
   wire 	      in_clock;
   wire 	      sys_clock;
   wire 	      locked;
   wire 	      hsync;
   wire 	      vsync;
   wire 	      csync;
   wire 	      video_on;
   wire [10:0] 	      pixel_x;
   wire [10:0] 	      pixel_y;
   wire                 bird_move;
   wire [10:0] 	      bird_x;
   wire [10:0] 	      bird_y;
	wire [10:0] 	      pipe_x, pipe_x2, pipe_x3;
   wire [10:0] 	      pipe_y, pipe_y2, pipe_y3;
   wire 	      bird_color;
	wire        pipe_color;
	
	wire [7:0] red;
   wire [7:0] green;
   wire [7:0] blue;
	
	wire       RESET_GAME;
	
	// KEY2 is game reset (debounces KEY)
	keypressed KEY2(sys_clock, 
						 KEY[0], 
						 KEY[2], 
						 RESET_GAME);
	      
  // 75MHz clock
  clockgen my_clockgen(in_clock,
							rst,
							sys_clock,
							locked);
	
	// Writes values to screen, output x/y of current pixel.
   vesasync myvesa(sys_clock, 
		   rst, 
		   hsync, 
		   vsync, 
		   csync, 
		   video_on, 
		   pixel_x, 
		   pixel_y);	
	
	// Controls the location of the bird during the game. Outputs the x/y coord.
	bird_location birdloc(sys_clock,
					  bird_move,
                 KEY,
					  RESET_GAME,
					  bird_x,
					  bird_y);
	
   // Pipe generators. Outputs the x and y coordinates of the pipes in the game.	
	pipe_generator pipeGen(sys_clock,
                         bird_move,
								 RESET_GAME,
							    pipe_x,
						       pipe_y);
								
	pipe_generator2 pipeGen2(sys_clock,
                         bird_move,
								 RESET_GAME,
							    pipe_x2,
						       pipe_y2);
		
	pipe_generator3 pipeGen3(sys_clock,
                         bird_move,
								 RESET_GAME,
							    pipe_x3,
						       pipe_y3);		
	
   // Output high if certain pixel contains a pipe.	
	pipe_painter mypipe(sys_clock,
           rst,
			  pipe_x,
			  pipe_y,
			  pipe_x2,
			  pipe_y2,
			  pipe_x3,
			  pipe_y3,			  
			  pixel_x,
			  pixel_y,
			  pipe_color);			
	
	// Ouput high if certain pixel contains a bird.
	bird_painter #(32) mybird(sys_clock, 
			  rst, 
			  bird_x,  
			  bird_y, 
			  pixel_x, 
			  pixel_y, 
			  bird_color);
			  
	// draw the screen colors based on bird/pipe positions.		  
	draw_game mygame(sys_clock,
						bird_color,
						pipe_color,
						red,
						green,
						blue);
	
	// check the status of game and keep score		  
	game_check mycheck(sys_clock,
						 RESET_GAME,
						 bird_color,
						 pipe_color,
						 HEX0,
						 HEX1,
						 HEX4,
						 HEX5,
						 LEDR);	
	
	
	assign rst         = ~KEY[0];
   assign in_clock    = CLOCK_50;
   assign bird_move   = (pixel_y == 769) && (pixel_x == 0); //asserted at finish of drawing one frame
   assign VGA_VS      = vsync;
   assign VGA_SYNC_N  = ~csync;
   assign VGA_BLANK_N = video_on;
   assign VGA_B       = blue;
   assign VGA_R       = red;
   assign VGA_G       = green;
   assign VGA_CLK     = sys_clock;
	

endmodule