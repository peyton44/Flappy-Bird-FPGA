`timescale 1ns/1ps

// Created to test the VGA color outputs.

module draw_game_tb();

	reg clk;
	reg rst;
	reg bird_color;
	reg pipe_color;
	
   wire [7:0] green;
   wire [7:0] blue;
	wire [7:0] red;	
	
	
	// draw the screen colors based on bird/pipe positions.		  
	draw_game mygame(clk,
						bird_color,
						pipe_color,
						red,
						green,
						blue);
	
	
	
	initial begin
		rst = 1'b1;
		#50;
		rst = 1'b0;
		#50;
		
		pipe_color = 1'b1;   //should be green
		bird_color = 1'b0;
		#100;
		pipe_color = 1'b0;   //should be red
		bird_color = 1'b1;
		#100;
		pipe_color = 1'b1;   //neither
		bird_color = 1'b1;
		#100;
		
		rst = 1'b1;
		
	end

	always begin
		clk = 1'b0;
		#10;
		clk = 1'b1;
		#10;
	end	

endmodule