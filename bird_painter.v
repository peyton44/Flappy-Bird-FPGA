module bird_painter
  #(parameter RADIUS = 32)
    (input wire clk,
    input wire rst,
    input wire [10:0]  bx,
    input wire [10:0]  by,
    input wire [10:0]  px,
    input wire [10:0]  py,
    output wire        ball_color);

	wire ball; 
	 
   assign ball = (((px-bx)*(px-bx) + (py-by)*(py-by)) < (RADIUS*RADIUS)) ? 1'b1 : 1'b0;
	
	assign ball_color = rst ? 1'b0 : ball;

endmodule 

