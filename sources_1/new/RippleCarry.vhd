library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RippleCarry is
    Port( A: in bit_vector(7 downto 0);
          B: in bit_vector(7 downto 0);
          Cin: in bit;
          Cout: out bit;
          S: out bit_vector(7 downto 0));
end RippleCarry;

architecture Behavioral of RippleCarry is
    component FullAdder is
        port (A, B, Cin: in bit;
              Cout, S: out bit);
    end component;

    signal C: bit_vector(8 downto 0);
begin
    myFOR: for i in 0 to 7 generate
        FAx: FullAdder port map(A(i), B(i), C(i), C(i+1), S(i));
    end generate;

    C(0) <= Cin;
    Cout <= C(8);
end Behavioral;



