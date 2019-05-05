`timescale 1ns/1ps

// Created to test the movement of the bird during the game.
// When KEY is pressed, the birds y coordinate should decrease (up).

module bird_move_tb();

	reg clk, bird_move;
	reg RESET_GAME;
	reg [3:0] KEY;
	
	wire [10:0] bird_x;
	wire [10:0] bird_y;
							
	bird_location birdloc(clk,
					  bird_move,
                 KEY,
					  RESET_GAME,
					  bird_x,
					  bird_y);						
													
	

	initial begin
		
		RESET_GAME = 1'b1;
		#50;
		RESET_GAME = 1'b0;
		
	end

	always begin
		clk = 1'b0;
		#10;
		clk = 1'b1;
		#10;
	end
	
	always begin
		KEY[3] = 1'b0;
		#1000;
		KEY[3] = 1'b1;
		#10;
	end	

	always begin
		bird_move = 1'b0;
		#250;
		bird_move = 1'b1;
		#250;
	end	


endmodule