// Code your design here

// SUBMODULO 2

module submodulo_2 #(
	parameter DEBOUNCE_P = 300,
	parameter SWITCH_MODE_MIN_T = 5000)

	(input logic clk, 
	input logic	rst,
	input logic	push_button,
	output logic A,
	output logic B);

  bit[14:0] Tp;
  enum logic[4:0] {Inicial, DB, EB, EA, Temp} estado;
  
  always_ff @ (posedge rst or posedge clk) begin
    if(rst==1) estado <= Inicial;
    else
      case(estado)
        Inicial: begin
          Tp <= 0;
          if(push_button) estado <= DB;
        end
        DB: begin
          Tp <= Tp+1;
          if(!push_button) estado <= Inicial;
          else if (Tp >= DEBOUNCE_P) estado <= EB;
        end
        EB:begin
          Tp <= Tp+1;
          if(!push_button) estado <= Temp;
          else if (Tp >= SWITCH_MODE_MIN_T) estado <= EA;
        end
        EA: begin
        	Tp <= Tp + 1;
        	if(!push_button) estado <= Temp;
        end
        Temp: if(clk) estado <= Inicial;
        default: estado <= Inicial;
      endcase
  end
  
  always_comb begin
    case(estado)
      Inicial: begin
        A = 0;
        B = 0;
      end
      DB:begin
        A = 0;
        B = 0;
      end
      EB:begin
        A = 0;
        B = 1;
      end
      EA:begin
        A = 1;
        B = 0;
      end
      //Temp:begin
      //  A = A;
      //  B = B;
      //end
      default: begin
        A = 0;
        B = 0;
      end      
    endcase
  end
  
endmodule
