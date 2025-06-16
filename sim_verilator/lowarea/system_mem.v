// Copyright (c) 2025 Patrick Schaumont
// Licensed under the Apache License, Version 2.0, see LICENSE for details.

module system_mem (
		   input wire	     clk,
		   input wire	     rst_n,
		   input wire	     enR,
		   input wire	     enW,
		   input wire [5:0]  addr,
		   input wire [63:0] mem_input,
		   output reg [63:0] mem_output
);
   parameter ADDR_WIDTH = 6;
   localparam MEM_DEPTH = 64;
   
   reg [63:0] memory [0:63];
   
   always @(posedge clk or negedge rst_n) begin
      if (!rst_n) begin
         mem_output <= 64'b0;
      end else begin
         if (enW) begin
            memory[addr] <= mem_input;
         end
         if (enR) begin
            mem_output <= memory[addr];
         end
      end
   end
endmodule
