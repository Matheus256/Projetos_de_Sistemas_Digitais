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
	logic [3:0] value;
	
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
						//Decodifique baseado em lin_matriz e col_matriz...
						//Analisar como fazer: for ou always_comb
						case (lin)
							0: begin // Linha 0 ativada (bit 0 em 0)
								case (col_matriz)
								    4'b1110: value <= 0x1;
								    4'b1101: value <= 0x2;
								    4'b1011: value <= 0x3;
								    4'b0111: value <= 0xA;
								    default: value <= 0xF;
								endcase
							end
							1: begin // Linha 1 ativada (bit 1 em 0)
								case (col_matriz)
								    4'b1110: value <= 0x4;
								    4'b1101: value <= 0x5;
								    4'b1011: value <= 0x6;
								    4'b0111: value <= 0xB;
								    default: value <= 0xF;
								endcase
							end
							2: begin // Linha 2 ativada (bit 2 em 0)
								case (col_matriz)
								    4'b1110: value <= 0x7;
								    4'b1101: value <= 0x8;
								    4'b1011: value <= 0x9;
								    4'b0111: value <= 0xC;
								    default: value <= 0xF;
								endcase
							end
							3: begin // Linha 3 ativada (bit 3 em 0)
								case (col_matriz)
								    4'b1110: value <= 0xF;
								    4'b1101: value <= 0x0;
								    4'b1011: value <= 0xE;
								    4'b0111: value <= 0xD;
								    default: value <= 0xF;
								endcase
							end
							default: value <= 0xF;
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
			lin_matriz = 4'b1110;
			tecla_value = 0xF;
			tecla_valid = 0;
		end
		else
			case(Estado) begin
				ESPERANDO:
					if(lin == 0)
						lin_matriz = 4'b1110;
					else if(lin == 1)
						lin_matriz = 4'b1101;
					else if(lin == 2)
						lin_matriz = 4'b1011;
					else if(lin == 3)
						lin_matriz = 4'b0111;		
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
					tecla_value = value;
					tecla_valid = 0;
				end
				VALID: begin
					tecla_value = value;
					tecla_valid = 1;
				end
				default: begin
					lin_matriz = 4'b1110;
					tecla_value = 0xF;
					tecla_valid = 0;
				end
			endcase
	end

endmodule
