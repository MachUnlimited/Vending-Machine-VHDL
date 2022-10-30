library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;



entity tb_vending_machine is
--  Port ( );
end tb_vending_machine;

architecture arch of tb_vending_machine is

component vending_machine is
	port(
		--INPUTS:
		clk				: in std_logic;
		rst				:in std_logic;
		para_giris_biti : in std_logic;
		toplam_para		: in std_logic_vector(4 downto 0);
		--OUTPUTS
		urun_verildi    : out std_logic ; --urun verildi sinyali
		para_geri_odeme : out std_logic_vector(4 downto 0)
	
	
	
	
	);


end component;
--INPUTS:
	signal	clk				:  std_logic;
	signal	rst				: std_logic;
	signal	para_giris_biti :  std_logic;
	signal	toplam_para		:  std_logic_vector(4 downto 0);
		--OUTPUTS
	signal	urun_verildi    :  std_logic; --urun verildi sinyali
	signal  para_geri_odeme :  std_logic_vector(4 downto 0);
		
	constant clock_period : time := 20ns;

begin
clock_process:Process
begin
    clk <= '0';
    wait for clock_period/2;
    clk <= '1';
    wait for clock_period/2;
end process;
uut : vending_machine port map(
    clk => clk,
    rst => rst,
    para_giris_biti => para_giris_biti,
    toplam_para => toplam_para,
    
    --out
    urun_verildi => urun_verildi,
    para_geri_odeme => para_geri_odeme
 );   
stim_proc: process
begin
rst <= '1';
para_giris_biti <= '0';
toplam_para <= (others => '0');
wait for 100ns;
rst <= '0';
wait for clock_period*2;


--1--
para_giris_biti <='1';
wait for clock_period;
toplam_para <= "00001";
wait for clock_period;
toplam_para <= "00101";
wait for clock_period;
toplam_para <= "01010";
wait for clock_period;
para_giris_biti <= '0';
wait for clock_period*15;

----2--

--para_giris_biti <='1';
--toplam_para <= "00001";
--wait for clock_period;
--toplam_para <= "00001";
--wait for clock_period;
--toplam_para <= "00101";
--wait for clock_period;
--para_giris_biti <= '0';
--wait for clock_period*15;


----3--
--para_giris_biti <='1';
--wait for clock_period;
--toplam_para <= "00101";
--wait for clock_period;
--toplam_para <= "00001";
--wait for clock_period;
--toplam_para <= "00001";
--wait for clock_period;
--toplam_para <= "00101";
--wait for clock_period;
--para_giris_biti <= '0';
--wait for clock_period*15;


----4--

--para_giris_biti <='1';
--wait for clock_period;
--toplam_para <= "01010";
--wait for clock_period;
--toplam_para <= "00101";
--wait for clock_period;
--para_giris_biti <= '0';
--wait for clock_period*15;

wait;




end process;



end arch;
