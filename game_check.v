///////////////////////////////////////////////////////////////////////
// Filename:    game_check.v
// Author:      Peyton Garrett
// Date:        02 May 2019
// Version:     1
// Description: Checks the game status and keeps the score/highscore. 

module game_check(input wire         clk,
						input wire         reset_game,
						input wire         bird_color,
						input wire         pipe_color,
						output wire [6:0]  HEX0,
						output wire [6:0]  HEX1,
						output wire [6:0]  HEX4,
						output wire [6:0]  HEX5,
						output wire [9:0]  LEDR);
						
						
	reg [9:0]   LED_R;
	reg         game_over;
	reg [24:0]  counter;
	reg [26:0]  counter2;
	reg [3:0]   hex_digit, hex_digit2;
	reg [3:0]   high_score1, high_score2;
	
	reg [7:0]   score;
	
	
	// Decodes the digits into the 7-segment digit form to write to LEDs.
	proc7segdecoder DEC(hex_digit, 
                       HEX0);
							  
	proc7segdecoder DEC2(hex_digit2, 
                        HEX1);  
								
	proc7segdecoder DEC3(high_score1, 
                       HEX4);
							  
	proc7segdecoder DEC4(high_score2, 
                        HEX5);  								
	
	// clock counters
	always @(posedge clk) begin
		counter <= (counter == 24999999) ? 0 : (counter + 1);
		counter2 <= (counter2 == 74999999) ? 0 : (counter2 + 1);
	end	

	
	always @(posedge clk) begin
	
		if(reset_game) begin                  // reset score
			game_over <= 1'b0;
			hex_digit <= 4'b0;
			hex_digit2 <= 4'b0;
			LED_R <= 10'b0;
		end	
	
		// GAME OVER when bird touches pipe.
		if(bird_color == 1'b1 && pipe_color == 1'b1) begin
			game_over <= 1'b1;
		end	

		if(game_over) begin                     // Flash LEDs / Update High Score
			if(counter == 0) begin
				if(LED_R == 10'b0) begin
					LED_R <= 10'b1111111111;
				end
			
				else begin
					LED_R <= 10'b0;
				end
			end
		
			if(score > {high_score2, high_score1}) begin
				high_score1 <= hex_digit;
				high_score2 <= hex_digit2;
			end	
		end
		
		if(game_over == 1'b0) begin                // Score counter
			if(counter2 == 0) begin
				if(hex_digit == 4'd9) begin
					hex_digit <= 4'd0;
					hex_digit2 <= hex_digit2 + 4'd1;
				end	
			
				else begin
					hex_digit <= hex_digit + 4'd1;
				end	
			end
			
			score <= {hex_digit2, hex_digit};
		end	
		
	end

	
	assign LEDR  = LED_R;
						
endmodule						