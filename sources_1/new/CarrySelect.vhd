library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CarrySelect is
    Port (
        Acarry: in bit_vector(15 downto 0);
        Bcarry: in bit_vector(15 downto 0);
        Scarry: out bit_vector(16 downto 0));
end CarrySelect;

architecture Behavioral of CarrySelect is

    component FullAdder is
    Port ( A : in bit;
           B : in bit;
           Cin : in bit;
           Cout : out bit;
           S : out bit);
    end component;

    component RippleCarry is
    Port (A: in bit_vector(7 downto 0);
          B: in bit_vector(7 downto 0);
          Cin: in bit;
          Cout: out bit;
          S: out bit_vector(7 downto 0));
    end component;

    component mux is
        Port (A: in bit;
              B: in bit;
              S: in bit;
              cout: out bit);
    end component;

   signal C7, Cout0,Cout1: bit;
   signal Somma0,Somma1: bit_vector(7 downto 0);

begin
    RippleCarry0: RippleCarry port map(Acarry(7 downto 0), Bcarry(7 downto 0), '0', C7, Scarry(7 downto 0));
    RippleCarry1: RippleCarry port map(Acarry(15 downto 8), Bcarry(15 downto 8), '0', Cout0, Somma0);
    RippleCarry2: RippleCarry port map(Acarry(15 downto 8), Bcarry(15 downto 8), '1', Cout1, Somma1);

    myFor: for i in 0 to 7 generate
        m: mux port map (Somma0(i), Somma1(i), C7, Scarry(8+i) );
    end generate myFor;
    
    multiplexer: mux port map(Cout0,Cout1,C7,Scarry(16));
   
end Behavioral;


