// Code your design here

//CONTROLADORA 

module controladora #( parameter DEBOUNCE_P = 300,
                      parameter SWITCH_MODE_MIN_T = 5000,
                      parameter AUTO_SHUTDOWN_T = 30000) 
  (input 		logic 	clk, 
   input		logic	rst,
   input		logic	infravermelho,
   input		logic	push_button,
   output 		logic	led,
   output		logic	saida );

	logic A,B,C,enable;
  
  submodulo_1 sub1(
    .clk(clk),
    .rst(rst),
    .a(A),
    .b(B),
    .c(C),
    .d(infravermelho),
    .enable_sub_3(enable),
    .led(led),
    .saida(saida)
  );
  
  submodulo_2#(
    .DEBOUNCE_P(DEBOUNCE_P),
    .SWITCH_MODE_MIN_T(SWITCH_MODE_MIN_T)
  ) sub2(
    .clk(clk),
    .rst(rst),
    .push_button(push_button),
    .A(A),
    .B(B)
  );
  
  submodulo_3#(
    .AUTO_SHUTDOWN_T(AUTO_SHUTDOWN_T)
  ) sub3(
    .clk(clk),
    .rst(rst),
    .enable(enable),
    .infravermelho(infravermelho),
    .C(C)
  );

endmodule

// SUBMODULO 1

module submodulo_1(
  input		logic 	clk,
  input		logic	rst,
  input		logic 	a, 
  input		logic 	b,
  input		logic 	c,
  input		logic	d,
  output	logic	enable_sub_3,
  output 	logic 	led, 
  output	logic	saida);
  

  enum logic [3:0]{LLA, LDA, LLM, LDM} estado;

  always_ff @ (posedge rst or posedge clk)begin
    if(rst==1) estado <= LDA;
    else
      case(estado)
        LDA:begin
          if(a) estado <= LDM;
          else if(d) estado <= LLA;
        end
        LLA:begin
          if(a) estado <= LDM;
          else if(c) estado <= LDA;
          else if(d) estado <= LLA;
        end
        LLM:begin
          if(a) estado <= LLA;
          else if(b) estado <= LDM;
        end
        LDM:begin
          if(a) estado <= LLA;
          else if(b) estado <= LLM;
        end
        default: estado<=LDA;
      endcase
  end
  
  always_comb begin
    if(rst)begin
      enable_sub_3 = 0;
      led = 0;
      saida = 0;
    end
    else
      case(estado)
        LDA:begin
          enable_sub_3 = 0;
          led = 0;
          saida = 0;
        end
        LDM:begin
          enable_sub_3 = 0;
          led = 1;
          saida = 0;
        end
        LLA:begin
          enable_sub_3 = 1;
          led = 0;
          saida = 1;
        end
        LLM:begin
          enable_sub_3 = 0;
          led = 1;
          saida = 1;
        end
        default:begin
          enable_sub_3 = 0;
          led = 0;
          saida = 0;
        end
      endcase
    end

endmodule



// SUBMODULO 2

module submodulo_2 #(
    parameter DEBOUNCE_P = 300,
    parameter SWITCH_MODE_MIN_T = 5000)
  
  (input  logic clk, 
   input  logic rst,
   input  logic push_button,
   output logic A,
   output logic B);

  bit[14:0] Tp;
  enum logic[4:0] {Inicial, DB, EB, EA, Temp} estado;
  logic reg_a,reg_b;

  always_ff @ (posedge rst or posedge clk) begin
    if(rst==1) estado <= Inicial;
    else
      case(estado)
        Inicial: begin
          Tp <= 0;
          reg_a <= 0;
          reg_b <= 0;
          if(push_button) estado <= DB;
        end
        DB: begin
          Tp <= Tp+1;
          if(!push_button) estado <= Inicial;
          else if (Tp >= DEBOUNCE_P) estado <= EB;
        end
        EB:begin
          Tp <= Tp+1;
          if(!push_button) begin
            estado <= Temp;
            reg_b <= 1;
          end
          else if (Tp >= SWITCH_MODE_MIN_T) estado <= EA;
        end
        EA: begin
            Tp <= Tp + 1;
          if(!push_button)begin
            estado <= Temp;
            reg_a <= 1;
          end
        end
        Temp: if(clk) estado <= Inicial;
        default: estado <= Inicial;
      endcase
  end

  always_comb begin
    if(rst)begin
      A=0;
      B=0;
    end
    else
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
          B = reg_b;
        end
        EA:begin
          A = reg_a;
          B = 0;
        end
        Temp:begin
          A = reg_a;
          B = reg_b;
        end
        default: begin
          A = 0;
          B = 0;
        end
      endcase
    
  end

endmodule



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
    if(rst) C = 0;
    else
      case(estado)
        Inicial: C = 0;
        Contando: C = 0;
        Temp: C = 1;
        default: C = 0;
      endcase
  end

endmodule