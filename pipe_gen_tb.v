`timescale 1ns/1ps

// Created to test the generation and moving of the pipes
// during the game;

module pipe_gen_tb();

	reg clk;
	reg rst;
	reg RESET_GAME;
	reg bird_move;
	
	wire [10:0] pipe_x;
	wire [10:0] pipe_y;
	
							
	pipe_generator pipeGen(clk,
                         bird_move,
								 RESET_GAME,
							    pipe_x,
						       pipe_y);						
													
	

	initial begin
		
		rst = 1'b1;
		RESET_GAME = 1'b1;
		#50;
		rst = 1'b0;
		RESET_GAME = 1'b0;
		
	end

	always begin
		clk = 1'b0;
		#10;
		clk = 1'b1;
		#10;
	end

	always begin
		bird_move = 1'b0;
		#250;
		bird_move = 1'b1;
		#250;
	end	


endmodule