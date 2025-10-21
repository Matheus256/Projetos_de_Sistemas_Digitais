// SUBMODULO 3

module submodulo_3  #(
parameter AUTO_SHUTDOWN_T = 10)

  (input 	logic 	clk,
  input		logic	rst,
  input 	logic	enable,
  input 	logic	infravermelho,
  output 	logic 	C);
  
  bit[14:0] Tc;
  enum logic [2:0] {Inicial,Contando,Temp} estado;
  
  always_ff @ (posedge rst or posedge clk) begin
    if (rst == 1)
      estado <= Inicial;
  	else
      case(estado)
        Inicial: begin
          Tc <= 0;
          if(!infravermelho && enable) estado <= Contando;
        end
        Contando: begin
          Tc <= Tc + 1;
          if(infravermelho || !enable) estado <= Inicial;
          else if (Tc >= AUTO_SHUTDOWN_T) estado <= Temp;
        end
        Temp: begin
          Tc <= 0;
          estado <= Inicial;
        end
        default: estado <= Inicial;
      endcase
  end
  
  always_comb begin
    case(estado)
      Inicial: C = 0;
      Contando: C = 0;
      Temp: C = 1;
      default: C = 0;
    endcase
  end

endmodule
