`timescale 1ns / 1ps
// Educational RV32I-style demonstration datapath.
// This is a small demo for Vivado simulation, not the complete MYTH core.
module riscv_core_gen (
    input  wire        clk,
    input  wire        rst,
    output reg  [31:0] pc,
    output reg  [31:0] a0,
    output reg         done
);
    reg [31:0] sum;
    reg [31:0] next_value;

    always @(posedge clk) begin
        if (rst) begin
            pc          <= 32'd0;
            a0          <= 32'd0;
            sum         <= 32'd0;
            next_value  <= 32'd1;
            done        <= 1'b0;
        end else if (!done) begin
            // Demonstration program: accumulate 1 through 9.
            sum <= sum + next_value;
            pc  <= pc + 32'd4;

            if (next_value == 32'd9) begin
                a0   <= sum + next_value;
                done <= 1'b1;
            end else begin
                next_value <= next_value + 32'd1;
            end
        end
    end
endmodule
