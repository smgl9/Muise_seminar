// `timescale 1 ps/ 1 ps
`include "vunit_defines.svh"
module if_else_test_tb;

// constants
// general purpose registers
reg eachvec;
// test vector input registers
reg [7:0] A=10;
reg [7:0] B=20;
reg [7:0] C=30;
reg [7:0] D=40;
reg [1:0] S;
reg clk;
reg reset;
// wires
wire [7:0] Y;

// assign statements (if any)
if_else_test i1 (
// port map - connection between master ports and signals/registers
	.A(A),
	.B(B),
	.C(C),
	.D(D),
	.S(S),
	.Y(Y),
	.clk(clk),
	.reset(reset)
);

`TEST_SUITE begin
   // It is possible to create a basic test bench without any test cases
   $display("if_else_tb");

// code that executes only once
// insert code here --> begin
$display("Running testbench");
$monitor("%g A = %b B = %b C = %b D = %b S = %b Y = %b", $time, A, B, C, D, S, Y);
#3
clk = 0;

S=0;
#30
`CHECK_EQUAL(Y, A);
S=1;
#30
`CHECK_EQUAL(Y, B);
S=2;
#30
`CHECK_EQUAL(Y, C);
S=3;
#30
`CHECK_EQUAL(Y, D);
// $finish;
end

always #10 clk = ~clk;

endmodule
