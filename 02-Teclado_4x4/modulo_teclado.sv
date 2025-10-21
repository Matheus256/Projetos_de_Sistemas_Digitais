module decodificador_de_teclado #(
    parameter DEBOUNCE_P = 100)
  
   (input ​ logic​ ​clk,
	input​ logic​ ​rst,
	input ​ logic [3:0] col_matriz,
	output ​logic [3:0] ​lin_matriz,
	output ​logic [3:0]​ tecla_value,
	output​ logic ​ ​tecla_valid);
	
	
	bit[6:0] Tp;
	enum logic [4:0] {ESPERANDO, DEBOUNCE, DECOD, SAIDA, VALID} Estado;
	
	bit[3:0] lin;
	
	always_ff @ (posedge clk or posedge rst) begin
		if (rst == 1) begin
			Estado <= ESPERANDO;
			lin <= 0;
			Tp <= 0;
		end
		else
			case(Estado)
				ESPERANDO: begin
					Tp <= 0;
					if(col_matriz != 4'b1111)
						Estado <= DEBOUNCE;
					lin <= (lin + 1) % 4;
				end
				DEBOUNCE: begin
					Tp <= Tp + 1;
					if(Tp >= DEBOUNCE_P)
						Estado <= DECOD;
					else if(col_matriz == 4'b1111)
						Estado <= ESPERANDO;
				end
				DECOD: begin
					if(clk) begin
						//DEcodifique baseado em lin_matriz e col_matriz...
						//Analisar como fazer: for ou always_comb
						// Verificar ordem dos bits
						case (lin_matriz) //Melhor usar lin ao invés de lin_matriz??
							4'b1110: begin // Linha 0 ativada (bit 0 em 0)
								case (col_matriz)
								    4'b1110: value <= "1";
								    4'b1101: value <= "2";
								    4'b1011: value <= "3";
								    4'b0111: value <= "A";
								    //default: value <= 8'h00;
								endcase
							end
							4'b1101: begin // Linha 1 ativada (bit 1 em 0)
								case (col_matriz)
								    4'b1110: tecla_value <= "4";
								    4'b1101: tecla_value <= "5";
								    4'b1011: tecla_value <= "6";
								    4'b0111: tecla_value <= "B";
								    //default: tecla_value <= 8'h00;
								endcase
							end
							4'b1011: begin // Linha 2 ativada (bit 2 em 0)
								case (col_matriz)
								    4'b1110: tecla_value <= "7";
								    4'b1101: tecla_value <= "8";
								    4'b1011: tecla_value <= "9";
								    4'b0111: tecla_value <= "C";
								    //default: tecla_value <= 8'h00;
								endcase
							end
							4'b0111: begin // Linha 3 ativada (bit 3 em 0)
								case (col_matriz)
								    4'b1110: tecla_value <= 0xA;
								    4'b1101: tecla_value <= 0x3;
								    4'b1011: tecla_value <= 0x2;
								    4'b0111: tecla_value <= 0x1;
								    //default: tecla_value <= 8'h00;
								endcase
							end
							default: tecla_value <= 8'h00;
						endcase
						Estado <= SAIDA;
					end
					else if(col_matriz == 4'b1111)
						Estado <= ESPERANDO;
				end
				SAIDA: begin
					if(clk)
						Estado <= VALID;
					else if(col_matriz == 4'b1111)
						Estado <= ESPERANDO;
				end
				VALID: begin
					if(col_matriz == 4'b1111)
						Estado <= ESPERANDO;	
				end
				default: Estado <= ESPERANDO;
			endcase
	end
	
	always_comb begin
		if(rst) begin
			lin_matriz = 4'b0111;
			tecla_value = 0xF;
			tecla_valid = 0;
		end
		else
			case(Estado) begin
				ESPERANDO:
					if(lin == 0)
						lin_matriz = 4'b0111;
					else if(lin == 1)
						lin_matriz = 4'b1011;
					else if(lin == 2)
						lin_matriz = 4'b1101;
					else if(lin == 3)
						lin_matriz = 4'b1110;		
				end
				DEBOU: begin
					tecla_value = 0xF;
					tecla_valid = 0;
				end
				DECOD: begin
					tecla_value = 0xF;
					tecla_valid = 0;
				end
				SAIDA: begin
					tecla_value = valor;
					tecla_valid = 0;
				end
				SAIDA: begin
					tecla_value = valor;
					tecla_valid = 1;
				end
				default: begin
					lin_matriz = 4'b0111;
					tecla_value = 0xF;
					tecla_valid = 0;
				end
			endcase
	end

endmodule
