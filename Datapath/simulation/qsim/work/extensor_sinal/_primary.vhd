library verilog;
use verilog.vl_types.all;
entity extensor_sinal is
    port(
        contador        : in     vl_logic_vector(11 downto 0);
        instrucao       : in     vl_logic_vector(31 downto 0);
        contador_64     : out    vl_logic_vector(63 downto 0);
        instrucao_64    : out    vl_logic_vector(63 downto 0)
    );
end extensor_sinal;
