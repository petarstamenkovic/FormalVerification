module hanoi_logic2    #(parameter S = 3)
    (
     input clk,
     input rst,
     input [1:0] fr,

     input [1:0] to);

// Number of steps should be is 2^S - 1, where S is number of disks
// Idea is to have 3 registers for each pole, LSB represents the largest disk and MSB smallest.
// File is named logic2 because my first attempt was to use a diffetent combination for MSB and LSB 
// This variation doesnt use any enable signals just 3 * S bits, and it is pretty much the same code as
// one previously sent(same swtich and for loops) except the view at the problem is different.

     // Three sticks
     logic [S-1:0] left;
     logic [S-1:0] mid; 
     logic [S-1:0] right;
     
     always @(posedge clk) begin
	  if(rst) begin
		    // Reset moves all disks to initial state, all on left (starting postition)
		    left  <= '1;
		    mid   <= '0;
		    right <= '0;
		end
	        else
		begin
		  // Transition from left to mid pole  ---- 1
		  if( fr == 2'b00 && to == 2'b01)
		  begin
				if(left > mid) 
				begin
					for(int i = S-1 ; i!=-1 ; i--)
					begin
					  if(left[i] == 1'b1)
					    begin
					        left[i] <= 1'b0;
					        mid[i]  <= 1'b1;
					        break;		  // If you do the switch, break ensures 									     that only one disk is moved 
				            end
					end
				end
		  end
		 
		  // Transition from left to right pole ---- 2
 		  if( fr == 2'b00 && to == 2'b10)
		  begin
				if(left > right) 
				begin
					for(int i = S-1 ; i!=-1 ; i--)
					begin
					  if(left[i] == 1'b1)
					    begin
					        left[i] <= 1'b0;
					        right[i]  <= 1'b1;
					        break;	
				            end
					end
				end
		  end

		 // Transition from mid to left pole ---- 3
		  if( fr == 2'b01 && to == 2'b00)
		  begin
				if(mid > left) 
				begin
					for(int i = S-1 ; i!=-1 ; i--)
					begin
					  if(mid[i] == 1'b1)
					    begin
					        mid[i] <= 1'b0;
					        left[i]  <= 1'b1;
					        break;	
				            end
					end
				end
		  end			
			
	          // Transition from mid to right pole ---- 4
		  if( fr == 2'b01 && to == 2'b10)
		  begin
				if(mid > right) 
				begin
					for(int i = S-1 ; i!=-1 ; i--)
					begin
					  if(mid[i] == 1'b1)
					    begin
					        mid[i] <= 1'b0;
					        right[i]  <= 1'b1;
					        break;	
				            end
					end
				end
		  end

		  // Transition from right to left pole ---- 5
		  if( fr == 2'b10 && to == 2'b00)
		  begin
				if(right > left) 
				begin
					for(int i = S-1 ; i!=-1 ; i--)
					begin
					  if(right[i] == 1'b1)
					    begin
					        right[i] <= 1'b0;
					        left[i]  <= 1'b1;
					        break;	
				            end
					end
				end
		  end

		  // Transition from right to mid pole ---- 6
       		  if( fr == 2'b10 && to == 2'b01 )
		  begin
				if(right > mid) 
				begin
					for(int i = S-1 ; i!=-1 ; i--)
					begin
					  if(right[i] == 1'b1)
					    begin
					        right[i] <= 1'b0;
					        mid[i]  <= 1'b1;
					        break;	
				            end
					end
				end
	         end
	end // else branch end
end // Always block end 


    // Default signals      
    default clocking
        @(posedge clk);
    endclocking
    default disable iff (rst);	

    //inital_cov : cover property(1'b1[*3]);  Testing coverage to see if design is alive

    // These assumes make sure that transition can't happen with same pole(from left to left for example)
    assume_same1 : assume property(not (fr == 2'b00 && to == 2'b00));
    assume_same2 : assume property(not (fr == 2'b10 && to == 2'b10));
    assume_same3 : assume property(not (fr == 2'b01 && to == 2'b01));

    // State 11 is not used since we have only 3 sticks
    assume_not_used : assume property(fr != 2'b11 && to != 2'b11);

    // You can't take disks from an empty pole
    assume_cant_from_empty1 : assume property(fr == 2'b00 |-> ~(left == '0));
    assume_cant_from_empty2 : assume property(fr == 2'b01 |-> ~(mid == '0));
    assume_cant_from_empty3 : assume property(fr == 2'b10 |-> ~(right == '0));
     
    // Debuggin coverage
    //test_cover1 : cover property(left == 3'b100 && mid == 3'b011 && right == 3'b000);
	
    // Final assume, all disks are on right pole (ending position)
    final_cover : cover property( right == '1 );

    

endmodule
