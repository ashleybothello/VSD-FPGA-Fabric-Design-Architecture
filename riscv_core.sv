`timescale 1ns / 1ps
// Top-level wrapper for the educational RISC-V-style demo.
module riscv_core (
    input  wire        clk,
    input  wire        rst,
    output wire [31:0] pc,
    output wire [31:0] a0,
    output wire        done
);
    riscv_core_gen u_core (
        .clk  (clk),
        .rst  (rst),
        .pc   (pc),
        .a0   (a0),
        .done (done)
    );
endmodule
