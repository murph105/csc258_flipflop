module card(clock, resetn, value, selectedA, selectedB, display);
  
  input clock;
  input resetn;
  input [3:0]value;
  input [3:0]selectedA;
  input [3:0]selectedB;
  output reg [3:0]display;
  
  //need to assign wires and regs
  
  assign match_found = (selectedA == value) && (selectedB == value); //match found if both selected -> what if they are the same card? must prevent when selecting
  
  always@(*) begin
    if (!resetn)
      trigger <= 0;
    if (match_found)
      trigger <= 1;
  end
  
  remove = trigger && (selectedA == 4'b1111); //triggers when selectedA is reset - is this the best solution?
  
  always@(posedge clock) begin
    if (!resetn) 
      begin
      	display <= 4'b0000;
      	stuck <= 0;
      end
   else
        if (remove)
          begin
        	display <= 4'b1111;
            stuck <= 1;
          end
    else
      if (!stuck)
        begin
          if ((selectedA == value)||(selectedB == value))
            display <= value;
          else
            display <= 4'b0000;
        end
  end
  
endmodule
