// `timescale 1 ps/ 1 ps
`include "vunit_defines.svh"
module flag_cdc_tb;

// constants
// general purpose registers
// test vector input registers
reg A, B;
reg clkA,clkB;
reg rst;
// wires

integer   PERIOD_A = 5;
integer   PERIOD_B = 10;

// assign statements (if any)
flag_cdc i1 (
// port map - connection between master ports and signals/registers
	.A(A),
	.B(B),
	.clkA(clkA),
	.clkB(clkB),
	.rst(rst)
);

`TEST_SUITE begin
   // It is possible to create a basic test bench without any test cases
   $display("flag_cdc_tb");
	 $display("Running testbench");
	 $monitor("%g A = %b B = %b rst = %b", $time, A, B, rst);
	 `TEST_CASE("clkA faster") begin

	 clkA=0;
	 clkB=0;
	 PERIOD_A = 5;
	 PERIOD_B = 10;

	 #10
	 A = 0;
	 rst = 0;
	 #10
	 rst = 1;
	 #30
	 rst = 0;
	 #30
	 A = 1;
	 #10
	 A = 0;
	 #120
	 $display("end test");
	 // $finish;
	 end
	 `TEST_CASE("clkB faster") begin

	 clkA=0;
	 clkB=0;
	 PERIOD_A = 10;
	 PERIOD_B = 5;

	 #10
	 A = 0;
	 rst = 0;
	 #10
	 rst = 1;
	 #30
	 rst = 0;
	 #60
	 A = 1;
	 #10
	 A = 0;
	 #160
	 $display("end test");
	 // $finish;
	 end
end

always #PERIOD_A clkA = ~clkA;
always #PERIOD_B clkB = ~clkB;

endmodule
