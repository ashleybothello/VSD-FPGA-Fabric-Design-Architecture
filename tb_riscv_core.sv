`timescale 1ns / 1ps
module tb_riscv_core;
    reg clk = 1'b0;
    reg rst = 1'b1;
    wire [31:0] pc;
    wire [31:0] a0;
    wire done;

    always #5 clk = ~clk;

    riscv_core dut (
        .clk(clk),
        .rst(rst),
        .pc(pc),
        .a0(a0),
        .done(done)
    );

    initial begin
        $display("time  reset  pc          a0          done");
        $monitor("%4t  %b      %h  %h  %b", $time, rst, pc, a0, done);
        #20 rst = 1'b0;
        wait(done);
        #10;
        if (a0 == 32'd45)
            $display("PASS: demonstration sum 1..9 = %0d", a0);
        else
            $display("FAIL: expected 45, got %0d", a0);
        $finish;
    end
endmodule
