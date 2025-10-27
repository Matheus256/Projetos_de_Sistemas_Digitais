module tb;
  
  bit [1] CLK, RST, TECLA_VALID;
  logic [3:0] COL_MATRIZ, LIN_MATRIZ, TECLA_VALUE;
  
  decodificador_de_teclado #(.DEBOUNCE_P(5)) teclado(.clk(CLK), .rst(RST), .col_matriz(COL_MATRIZ), .lin_matriz(LIN_MATRIZ), .tecla_value(TECLA_VALUE), .tecla_valid(TECLA_VALID));
  
  initial begin
    
    $display(" ** Iniciando ** ");
    
    CLK = 0;
    RST = 0;
    COL_MATRIZ = 4'b1111;

    #2
    RST = 1;
    #2
    RST = 0;
    
    $display("Time: %0t | tecla_value: %h | tecla_valid: %b | lin_matriz: %b | estado: %d", 
                 $time, TECLA_VALUE, TECLA_VALID, LIN_MATRIZ, teclado.Estado);
    
    for(int i=0; i < 5; i++) begin
      #2
      $display("Time: %0t | tecla_value: %h | tecla_valid: %b | lin_matriz: %b | estado: %d", 
                 $time, TECLA_VALUE, TECLA_VALID, LIN_MATRIZ, teclado.Estado);
    end
    
 //----------------------------------------------------------------------------------------------
    $display("Botao apertado: Coluna 1 - 1110"); 
        
    COL_MATRIZ = 4'b1110;
    
    for(int i=0; i < 20; i++) begin
      #2
      $display("Time: %0t | tecla_value: %h | tecla_valid: %b | lin_matriz: %b | estado: %d", 
                 $time, TECLA_VALUE, TECLA_VALID, LIN_MATRIZ, teclado.Estado);
    end
    COL_MATRIZ = 4'b1111;
    $display("Botao solto"); 
    
    for(int i=0; i < 5; i++) begin
      #3
      $display("Time: %0t | tecla_value: %h | tecla_valid: %b | lin_matriz: %b | estado: %d", 
                 $time, TECLA_VALUE, TECLA_VALID, LIN_MATRIZ, teclado.Estado);
    end
    
//-------------------------------------------------------------------------------------------------
    
    $display("Botao apertado: Coluna 2 - 1101"); 
        
    COL_MATRIZ = 4'b1101;
    
    for(int i=0; i < 20; i++) begin
      #2
      $display("Time: %0t | tecla_value: %h | tecla_valid: %b | lin_matriz: %b | estado: %d", 
                 $time, TECLA_VALUE, TECLA_VALID, LIN_MATRIZ, teclado.Estado);
    end
    COL_MATRIZ = 4'b1111;
    $display("Botao solto"); 
 
    for(int i=0; i < 5; i++) begin
      #2
      $display("Time: %0t | tecla_value: %h | tecla_valid: %b | lin_matriz: %b | estado: %d", 
                 $time, TECLA_VALUE, TECLA_VALID, LIN_MATRIZ, teclado.Estado);
    end
   
//-------------------------------------------------------------------------------------------------
    
    $display("Botao apertado: Coluna 3 - 1011"); 
        
    COL_MATRIZ = 4'b1011;
    
    for(int i=0; i < 20; i++) begin
      #2
      $display("Time: %0t | tecla_value: %h | tecla_valid: %b | lin_matriz: %b | estado: %d", 
                 $time, TECLA_VALUE, TECLA_VALID, LIN_MATRIZ, teclado.Estado);
    end
    COL_MATRIZ = 4'b1111;
    $display("Botao solto"); 
 
    
    for(int i=0; i < 5; i++) begin
      #5
      $display("Time: %0t | tecla_value: %h | tecla_valid: %b | lin_matriz: %b | estado: %d", 
                 $time, TECLA_VALUE, TECLA_VALID, LIN_MATRIZ, teclado.Estado);
    end
    
    //-------------------------------------------------------------------------------------------------
    
    $display("Botao apertado: Coluna 4 - 0111"); 
        
    COL_MATRIZ = 4'b0111;
    
    for(int i=0; i < 20; i++) begin
      #2
      $display("Time: %0t | tecla_value: %h | tecla_valid: %b | lin_matriz: %b | estado: %d", 
                 $time, TECLA_VALUE, TECLA_VALID, LIN_MATRIZ, teclado.Estado);
    end
    COL_MATRIZ = 4'b1111;
    $display("Botao solto"); 
 
    
    for(int i=0; i < 5; i++) begin
      #2
      $display("Time: %0t | tecla_value: %h | tecla_valid: %b | lin_matriz: %b | estado: %d", 
                 $time, TECLA_VALUE, TECLA_VALID, LIN_MATRIZ, teclado.Estado);
    end
    
    $display("Teste finalizado.");
    $finish;
    
  end
  
  
  //Sinal de Clock
  always begin
    #1 CLK = ~CLK;
  end
  
endmodule
