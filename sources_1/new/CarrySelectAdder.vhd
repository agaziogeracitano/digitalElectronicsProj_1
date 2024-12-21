library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CarrySelectAdder16 is
    Port (
        A : in STD_LOGIC_VECTOR(15 downto 0);
        B : in STD_LOGIC_VECTOR(15 downto 0);
        Cin : in STD_LOGIC;
        S : out STD_LOGIC_VECTOR(15 downto 0);
        Cout : out STD_LOGIC
    );
end CarrySelectAdder16;

architecture Behavioral of CarrySelectAdder16 is
    signal IntermediateSum1 : STD_LOGIC_VECTOR(7 downto 0);
    signal IntermediateSum2 : STD_LOGIC_VECTOR(7 downto 0);
    signal CarryOut1 : STD_LOGIC;
    signal CarryOut2 : STD_LOGIC;

    component RippleCarry is
        generic(n: Integer := 8);
        Port (
            A: in STD_LOGIC_VECTOR(n-1 downto 0);
            B: in STD_LOGIC_VECTOR(n-1 downto 0);
            Cin: in STD_LOGIC;
            Cout: out STD_LOGIC;
            S: out STD_LOGIC_VECTOR(n-1 downto 0)
        );
    end component;

    component mux is
        Port (
            A: in STD_LOGIC;
            B: in STD_LOGIC;
            S: in STD_LOGIC;
            cout: out STD_LOGIC
        );
    end component;

begin
    -- Dividi A e B in due parti di 8 bit ciascuna
    signal A_Lower : STD_LOGIC_VECTOR(7 downto 0);
    signal A_Upper : STD_LOGIC_VECTOR(7 downto 0);
    signal B_Lower : STD_LOGIC_VECTOR(7 downto 0);
    signal B_Upper : STD_LOGIC_VECTOR(7 downto 0);

    A_Lower <= A(7 downto 0);
    A_Upper <= A(15 downto 8);
    B_Lower <= B(7 downto 0);
    B_Upper <= B(15 downto 8);

    -- Primo RippleCarry
    RippleCarry_1: RippleCarry
    port map (A_Lower, B_Lower, Cin, CarryOut1, IntermediateSum1);

    -- Secondo RippleCarry
    RippleCarry_2: RippleCarry
    port map (A_Upper, B_Upper, CarryOut1, CarryOut2, IntermediateSum2);

    -- Mux per il risultato
    Mux_1: mux
    port map (IntermediateSum1(7), IntermediateSum2(7), CarryOut2, S(7));

    -- Altri mux per i bit rimanenti
    myFOR: for i in 6 downto 0 generate
        Mux_i: mux
        port map (IntermediateSum1(i), IntermediateSum2(i), CarryOut1, S(i));
    end generate;

    -- Cout è l'ultimo carry-out
    Cout <= CarryOut2;

end Behavioral;
