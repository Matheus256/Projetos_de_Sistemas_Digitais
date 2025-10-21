//  Divisor de frequência


module divfreq(input reset, clock, output logic clk_i);


  int cont;


  always @(posedge clock or posedge reset) begin
    if(reset) begin
      cont  = 0;
      clk_i = 0;
    end
    else
      if( cont <= 25000 )
        cont++;
      else begin
        clk_i = ~clk_i;
        cont = 0;
      end
  end
endmodule










****************  Golden TOP  ***************




wire clk_1khz;




 controladora #(
        .DEBOUNCE_P(300),
        .SWITCH_MODE_MIN_T(5000),
        .AUTO_SHUTDOWN_T(30000)
    ) dut (
        .clk(clk_1khz),
        .rst(!KEY[0]),
        .infravermelho(!KEY[3]),
        .push_button(!KEY[1]),
        .led(LEDR[0]),
        .saida(LEDR[9])
    );
 
divfreq my_div(.reset(!KEY[0]), .clock(CLOCK_50), .clk_i(clk_1khz));