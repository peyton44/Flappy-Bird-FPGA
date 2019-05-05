////////////////////////////////////////////////////////////////////////////////////////////////////
// Filename:    proc7segdecoder.v
// Author:      Peyton Garrett
// Date:        28 October 2018
// Version:     1
// Description: This code is for a 7-segment display using a procedural model.

module proc7segdecoder(input  wire [3:0] hexDigit, 
                       output wire [6:0] hexDisplay);

 reg [6:0] hex_display;
 
 always@(hexDigit)
 begin
 
 case(hexDigit)                            //case statement for each
	4'd0:  hex_display =  7'b1000000;        //value of hex_digit
	4'd1:  hex_display =  7'b1111001;
   4'd2:  hex_display =  7'b0100100;
	4'd3:  hex_display =  7'b0110000;
	4'd4:  hex_display =  7'b0011001;
	4'd5:  hex_display =  7'b0010010;
	4'd6:  hex_display =  7'b0000010;
	4'd7:  hex_display =  7'b1111000;
	4'd8:  hex_display =  7'b0000000;
   4'd9:  hex_display =  7'b0010000;
	4'd10: hex_display =  7'b0001000;
	4'd11: hex_display =  7'b0000011;
	4'd12: hex_display =  7'b1000110;
	4'd13: hex_display =  7'b0100001;
	4'd14: hex_display =  7'b0000110;
	4'd15: hex_display =  7'b0001110; 
	
	
	default: hex_display = 7'bxxxxxxx;      //defualt case
endcase
	
end

	assign hexDisplay = hex_display;
 
endmodule
