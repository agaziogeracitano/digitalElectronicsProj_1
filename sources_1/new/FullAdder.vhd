library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FullAdder is
    Port ( A : in bit;
           B : in bit;
           Cin : in bit;
           Cout : out bit;
           S : out bit);
end FullAdder;

architecture Behavioral of FullAdder is
signal p,g: bit;
begin
    Cout <= g when p='0' else Cin;
    S <= p xor Cin;
    p<=a xor b;
    g<= a and b;
end Behavioral;


