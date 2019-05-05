`timescale 1ns/1ps

// Created to test the 75MHz generator and the VGA outputs

module vesasync_tb();

	reg clk;
	reg rst;
	reg locked;
	
	wire sys_clock;
	
	wire hsync;
	wire vsync;
	wire csync;
	wire video_on;
	wire [10:0] pixel_x;
	wire [10:0] pixel_y;
	
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
	
	
	initial begin
		rst = 1'b1;
		#50;
		rst = 1'b0;
		#50;
	end

	always begin
		clk = 1'b0;
		#10;
		clk = 1'b1;
		#10;
	end	


endmodule