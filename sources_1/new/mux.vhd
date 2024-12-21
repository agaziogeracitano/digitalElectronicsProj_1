library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux is
    Port ( A: in bit;
           B: in bit;
           S: in bit;
           cout: out bit);
end mux;

architecture Behavioral of mux is
begin
    cout <= (A and (not S)) or (B and S);
end Behavioral;

