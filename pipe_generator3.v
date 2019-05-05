
module pipe_generator3(input wire clk,
                      input wire move,
							 input wire RESET_GAME,
							 output wire [10:0]  pipe_x,
						    output wire [10:0]  pipe_y);
		
		reg [10:0] px_next;
		reg [10:0] py_next;
		reg [10:0] px;
		reg [10:0] py;
		reg [10:0] y_random;
		
		reg        start_game;
		
		initial begin
			px = 11'd423;
			py = 11'd300;
			y_random = 11'd300;
			start_game = 1'b0;
		end	
		
		always @(posedge clk) begin
			if(RESET_GAME) begin
			  px_next <= 11'd423;
			  start_game <= 1'b1;
			end
			
			if(move && start_game) begin
				px_next <= (px_next == 11'd0) ? 11'd1023 : px_next - 11'd3;
			end
		
			y_random <= (y_random == 11'd560) ? 11'd300 : (y_random + 11'd1);
			py_next  <= (px_next == 11'd0) ? y_random : py;
		end	
		
		always @(posedge move) begin		
			if(start_game == 1'b1) begin
				px <= px_next;
				py <= py_next;
			end
		end
	
		assign pipe_x = px;
		assign pipe_y = py;

endmodule							 