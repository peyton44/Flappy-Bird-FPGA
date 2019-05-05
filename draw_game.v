////////////////////////////////////////////////////////////
// Filename:    draw_game.v
// Author:      Peyton Garrett
// Date:        02 May 2019
// Version:     1
// Description: Updates the pixel colors based on bird/pipes. 

module draw_game(input wire        clk,
						input wire        bird_color,
						input wire        pipe_color,
						output wire [7:0] VGA_R,
						output wire [7:0] VGA_G,
						output wire [7:0] VGA_B);
						
						
	reg [7:0]   red;
	reg [7:0]   green;
	reg [7:0]   blue;

	always @(posedge clk) begin
	
		if(bird_color == 1'b1) begin
			red   <= 8'hff;
			green <= 8'h00;
			blue  <= 8'h00;
		end
	
		else if(pipe_color == 1'b1) begin
			red   <= 8'h00;
			green <= 8'hff;
			blue  <= 8'h00;
		end	
		
		else begin
			red   <= 8'h00;
			green <= 8'h00;
			blue  <= 8'hff;
		end
	end					
	
	
   assign VGA_R = red;
   assign VGA_G = green;
   assign VGA_B = blue;	
						
endmodule						