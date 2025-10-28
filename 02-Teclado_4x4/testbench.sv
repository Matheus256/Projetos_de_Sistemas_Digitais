module tb;
  
  bit [1] CLK, RST, TECLA_VALID;
  logic [3:0] COL_MATRIZ, LIN_MATRIZ, TECLA_VALUE;
  
  decodificador_de_teclado #(.DEBOUNCE_P(100)) teclado(.clk(CLK), .rst(RST), .col_matriz(COL_MATRIZ), .lin_matriz(LIN_MATRIZ), .tecla_value(TECLA_VALUE), .tecla_valid(TECLA_VALID));
  
  initial begin
    
    $display(" =================================================== ");
    $display(" ** Iniciando ** ");
    $display(" =================================================== ");
    $display(" ");
    
    CLK = 0;
    RST = 0;
    COL_MATRIZ = 4'b1111;

    #2
    RST = 1;
    #2
    RST = 0;
    
    $display(" Estado: Esperando ");
    $display(" ");
    $display("Time: %0t | tecla_value: %h | tecla_valid: %b | lin_matriz: %b | estado: %d", 
                 $time, TECLA_VALUE, TECLA_VALID, LIN_MATRIZ, teclado.Estado);
    
    for(int i=0; i < 5; i++) begin
      #2
      $display("Time: %0t | tecla_value: %h | tecla_valid: %b | lin_matriz: %b | estado: %d", 
                 $time, TECLA_VALUE, TECLA_VALID, LIN_MATRIZ, teclado.Estado);
    end
    $display(" ");
    
//----------------------------------------------------------------------------------------------
	$display(" =================================================== ");

    $display("Aperto do botao - Coluna 1 - 1110");
    $display(" ");
    
    COL_MATRIZ = 4'b1110;
    #2
    $display("Time: %0t | tecla_value: %h | tecla_valid: %b | lin_matriz: %b | estado: %d", 
                 $time, TECLA_VALUE, TECLA_VALID, LIN_MATRIZ, teclado.Estado);    
    #50
    COL_MATRIZ = 4'b1111;
    #2
     $display(" ");
     $display("Botao solto antes de superar o debounce");
     $display(" ");
     $display("Time: %0t | tecla_value: %h | tecla_valid: %b | lin_matriz: %b | estado: %d", 
                 $time, TECLA_VALUE, TECLA_VALID, LIN_MATRIZ, teclado.Estado);  
    
    for(int i=0; i < 5; i++) begin
      #2
      $display("Time: %0t | tecla_value: %h | tecla_valid: %b | lin_matriz: %b | estado: %d", 
                 $time, TECLA_VALUE, TECLA_VALID, LIN_MATRIZ, teclado.Estado);
    end
    
    $display(" ");
   	$display(" =================================================== "); //----------------------------------------------------------------------------------------------
    #6
    $display("Time: %0t | tecla_value: %h | tecla_valid: %b | lin_matriz: %b | estado: %d", 
                 $time, TECLA_VALUE, TECLA_VALID, LIN_MATRIZ, teclado.Estado);
        
    $display(" ");
    $display("Botao apertado: Coluna 1 - 1110");
    $display(" ");
    
    COL_MATRIZ = 4'b1110;
    #200
    $display("Time: %0t | tecla_value: %h | tecla_valid: %b | lin_matriz: %b | estado: %d", 
                 $time, TECLA_VALUE, TECLA_VALID, LIN_MATRIZ, teclado.Estado);
    
    for(int i=0; i < 10; i++) begin
      #2
      $display("Time: %0t | tecla_value: %h | tecla_valid: %b | lin_matriz: %b | estado: %d", 
                 $time, TECLA_VALUE, TECLA_VALID, LIN_MATRIZ, teclado.Estado);
    end
    COL_MATRIZ = 4'b1111;
    $display(" ");
    $display("Botao solto");
    $display(" ");
    
    for(int i=0; i < 5; i++) begin
      #10
      $display("Time: %0t | tecla_value: %h | tecla_valid: %b | lin_matriz: %b | estado: %d", 
                 $time, TECLA_VALUE, TECLA_VALID, LIN_MATRIZ, teclado.Estado);
    end
    $display(" ");
    $display(" =================================================== ");
//-------------------------------------------------------------------------------------------------
    #14
    $display("Time: %0t | tecla_value: %h | tecla_valid: %b | lin_matriz: %b | estado: %d", 
                 $time, TECLA_VALUE, TECLA_VALID, LIN_MATRIZ, teclado.Estado);
    
    $display(" ");
    $display("Botao apertado: Coluna 2 - 1101"); 
    $display(" ");
    
    COL_MATRIZ = 4'b1101;
    #200
    $display("Time: %0t | tecla_value: %h | tecla_valid: %b | lin_matriz: %b | estado: %d", 
                 $time, TECLA_VALUE, TECLA_VALID, LIN_MATRIZ, teclado.Estado);
    for(int i=0; i < 10; i++) begin
      #2
      $display("Time: %0t | tecla_value: %h | tecla_valid: %b | lin_matriz: %b | estado: %d", 
                 $time, TECLA_VALUE, TECLA_VALID, LIN_MATRIZ, teclado.Estado);
    end
    COL_MATRIZ = 4'b1111;
    $display(" ");
    $display("Botao solto"); 
    $display(" ");
 
    for(int i=0; i < 5; i++) begin
      #10
      $display("Time: %0t | tecla_value: %h | tecla_valid: %b | lin_matriz: %b | estado: %d", 
                 $time, TECLA_VALUE, TECLA_VALID, LIN_MATRIZ, teclado.Estado);
    end
    $display(" ");
   $display(" =================================================== ");
//-------------------------------------------------------------------------------------------------
    #22
    $display("Time: %0t | tecla_value: %h | tecla_valid: %b | lin_matriz: %b | estado: %d", 
                 $time, TECLA_VALUE, TECLA_VALID, LIN_MATRIZ, teclado.Estado);
    $display(" ");
    $display("Botao apertado: Coluna 3 - 1011"); 
    $display(" ");
            
    COL_MATRIZ = 4'b1011;
    #200
    $display("Time: %0t | tecla_value: %h | tecla_valid: %b | lin_matriz: %b | estado: %d", 
                 $time, TECLA_VALUE, TECLA_VALID, LIN_MATRIZ, teclado.Estado);
    
    for(int i=0; i < 10; i++) begin
      #2
      $display("Time: %0t | tecla_value: %h | tecla_valid: %b | lin_matriz: %b | estado: %d", 
                 $time, TECLA_VALUE, TECLA_VALID, LIN_MATRIZ, teclado.Estado);
    end
    COL_MATRIZ = 4'b1111;
    $display(" ");
    $display("Botao solto"); 
    $display(" ");
 
    
    for(int i=0; i < 5; i++) begin
      #10
      $display("Time: %0t | tecla_value: %h | tecla_valid: %b | lin_matriz: %b | estado: %d", 
                 $time, TECLA_VALUE, TECLA_VALID, LIN_MATRIZ, teclado.Estado);
    end
    $display(" ");
   $display(" =================================================== "); //-------------------------------------------------------------------------------------------------
    #46
    $display("Time: %0t | tecla_value: %h | tecla_valid: %b | lin_matriz: %b | estado: %d", 
                 $time, TECLA_VALUE, TECLA_VALID, LIN_MATRIZ, teclado.Estado);
    
    $display(" ");
    $display("Botao apertado: Coluna 4 - 0111");
    $display(" ");
    
    COL_MATRIZ = 4'b0111;
    #200
    $display("Time: %0t | tecla_value: %h | tecla_valid: %b | lin_matriz: %b | estado: %d", 
                 $time, TECLA_VALUE, TECLA_VALID, LIN_MATRIZ, teclado.Estado);
    
    for(int i=0; i < 10; i++) begin
      #2
      $display("Time: %0t | tecla_value: %h | tecla_valid: %b | lin_matriz: %b | estado: %d", 
                 $time, TECLA_VALUE, TECLA_VALID, LIN_MATRIZ, teclado.Estado);
    end
    COL_MATRIZ = 4'b1111;
    $display(" ");
    $display("Botao solto"); 
    $display(" ");
 
    
    for(int i=0; i < 5; i++) begin
      #10
      $display("Time: %0t | tecla_value: %h | tecla_valid: %b | lin_matriz: %b | estado: %d", 
                 $time, TECLA_VALUE, TECLA_VALID, LIN_MATRIZ, teclado.Estado);
    end
    $display(" ");
    $display("==================================================== ");
    $display("Teste finalizado.");
    $display("==================================================== ");
    $finish;
    
  end
  
  
  //Sinal de Clock
  always begin
    #1 CLK = ~CLK;
  end
  
endmodule

