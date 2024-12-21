library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity simulazioneCarrySelect is

end simulazioneCarrySelect;

architecture Behavioral of simulazioneCarrySelect is
    component CarrySelect is
           Port (
        Acarry: in bit_vector(15 downto 0);
        Bcarry: in bit_vector(15 downto 0);
        Scarry: out bit_vector(16 downto 0));
    end component;

    signal IA, IB: bit_vector(15 downto 0);
    signal Somma: bit_vector(16 downto 0);
begin
    IA <= "1111111111111111";
    IB <= "0000000000000000";
   
    
    CarrySelectAdder: CarrySelect port map(IA, IB, Somma);
end Behavioral;

