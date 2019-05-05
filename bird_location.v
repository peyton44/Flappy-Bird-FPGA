///////////////////////////////////////////////////////////////////////
// Filename:    game_check.v
// Author:      Peyton Garrett
// Date:        02 May 2019
// Version:     1
// Description: Generates the bird coordinates. Will increase y on tap.


module bird_location(input wire         clk,
							input wire         move,
                     input wire  [3:0]  KEY,
							input wire         RESET_GAME,
							output wire [10:0] bird_x,
							output wire [10:0] bird_y);
							
	reg [10:0] bx;
	reg [10:0] by, by_next;
	reg        start_game;
	
	wire       FLAP;

	// if KEY is pressed, flap upward (*tap screen on app version)
	keypressed KEY3(clk, 
						 KEY[0], 
						 KEY[3], 
						 FLAP);
						 
	
	initial begin
	  by = 11'd360;
	  start_game = 1'b0;
	end  
	
	always @(posedge clk) begin
		
		if(RESET_GAME) begin
			by_next <= 11'd360;
			start_game <= 1'b1;
		end	
		
		if(FLAP && start_game == 1'b1) begin
		  by_next <= by - 11'd95;   // y- coordinate increase w/ each "flap"
		end
		
		if(move && start_game == 1'b1) begin
			by_next <= by + 11'd3;
		end	
	
   end
	
	always @(posedge move) begin
		if(start_game == 1'b1) begin
		  by <= by_next;     // bird constantly falls down
		end
	end	

	assign bird_x = 11'd125;
	assign bird_y = by;
							
endmodule						