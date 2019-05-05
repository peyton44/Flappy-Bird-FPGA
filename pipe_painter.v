module pipe_painter
   (input wire clk,
    input wire rst,
    input wire [10:0]  bx,
    input wire [10:0]  by,
	 input wire [10:0]  bx2,
    input wire [10:0]  by2,
	 input wire [10:0]  bx3,
    input wire [10:0]  by3,	 
    input wire [10:0]  px,
    input wire [10:0]  py,
    output wire        pipe_color);
	 
	 
	 reg        pipe; 	 
	 
	 always @(posedge clk) begin
	 
		if((bx - px) < 11'd72) begin
			if((by - py) < 11'd200) begin
			   pipe = 1'b0;
		   end else begin	
				pipe = 1'b1;
			end
		end 
		
		else if((bx2 - px) < 11'd72) begin
			if((by2 - py) < 11'd200) begin
			   pipe = 1'b0;
		   end else begin	
				pipe = 1'b1;
			end
		end
		
		else if((bx3 - px) < 11'd72) begin
			if((by3 - py) < 11'd200) begin
			   pipe = 1'b0;
		   end else begin	
				pipe = 1'b1;
			end
		end
	
		else begin
			pipe = 1'b0;
		end		
	 end
	 
	 assign pipe_color = pipe;
	 
	 
endmodule	 