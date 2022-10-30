library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity vending_machine is
	port(
		--INPUTS:
		clk				: in std_logic;
		rst				:in std_logic;
		para_giris_biti : in std_logic; -- CASH INPUT BYTE
		toplam_para		: in std_logic_vector(4 downto 0); -- TOTAL MONEY AND CASH INPUT (JUST 1$-5$-10$)
		--OUTPUTS
		urun_verildi    : out std_logic; --PRODUCT GIVEN BYTE
		para_geri_odeme : out std_logic_vector(4 downto 0) -- CHANGE ONLY 1$
	
	
	
	
	);


end entity;


architecture arch of vending_machine is 


type state_type is  (IDLE,Para_Giris,Para_Ustu,Urun_Ver);--(IDLE - MONEY_IN - CHANGE - GIVE PRODUCT)
signal state : state_type; --STATE
signal cost : std_logic_vector(4 downto 0) := "01010"; --PRODUCT PRICE
signal para_ustu_miktari : std_logic_vector(4 downto 0); --CHANGE SIGNAL
signal urun_verildi_biti : std_logic; -- --PRODUCT GIVEN SIGNAL
signal tp_artis : std_logic_vector (4 downto 0); --TOTAL MONEY SIGNAL






begin
process(clk, rst)
		begin
		if (rst = '1') then
		
		
			urun_verildi <= '0';
			para_geri_odeme <= (others => '0');
			para_ustu_miktari <= (others => '0');
			urun_verildi_biti <= '0';
		
		elsif rising_edge(clk) then
				case state is 
			 
			 			 			 
					when IDLE =>
					
						
						urun_verildi <= '0';
						tp_artis <= (others => '0');						
						para_geri_odeme <= (others => '0');
						para_ustu_miktari <= (others => '0');
						urun_verildi_biti <= '0';
						
						if (para_giris_biti = '1') then
						   tp_artis <= toplam_para + tp_artis;
							state <= Para_Giris;
						else
							state <= IDLE;
						end if;
					
					when Para_Giris =>
						
						if (para_giris_biti = '1') then   -- MONEY INPUT AVAILABLE
							tp_artis <= toplam_para + tp_artis;
							
								
						
						else                               --NO MONEY ENTRY
							if (tp_artis < "01010") then
							state <= Para_Ustu;
							
							else
								state <= Urun_Ver;
							end if;	
						end if;	
					when Para_Ustu =>
						if (para_ustu_miktari /= "00000") then
							para_ustu_miktari <= para_ustu_miktari - ("00001");
							para_geri_odeme   <= para_ustu_miktari;
							state <= Para_Ustu;
						else
							state <= IDLE;
						end if;
						
					when Urun_Ver =>
						para_ustu_miktari <= tp_artis - cost;
						urun_verildi_biti <= '1';
						state <= Para_Ustu;
					
					when others =>
						state <= IDLE;
				
				
				


				end case;
        end if;
end process;  
end architecture;