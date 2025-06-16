`timescale 1ns/1ps

// Copyright (c) 2025 Patrick Schaumont
// Licensed under the Apache License, Version 2.0, see LICENSE for details.

module tbkeccak;

   reg clk;
   reg rst_n;
   reg start;
   reg [63:0] din;
   reg	      din_valid;
   reg	      last_block;
   wire	      buffer_full;
   wire	      ready;
   wire [63:0] dout;
   wire	       dout_valid;
   
   keccak dut (.clk(clk),
	       .rst_n(rst_n),
	       .start(start),
	       .din(din),
	       .din_valid(din_valid),
	       .buffer_full(buffer_full),
	       .last_block(last_block),
	       .ready(ready),
	       .dout(dout),
	       .dout_valid(dout_valid)
	       );
   
   always
     begin
	clk = 1'b0;
	#10;
	clk = 1'b1;
	#10;
     end
   
   integer     file, file_out;
   integer     tv_count;
   integer     totaltv_count;
   string      totaltv_count_str;
   string      line;   
   reg [63:0]  hex_value;
   integer     i, r;
   
   integer     code;
   
   initial 
     begin
	
	$dumpfile("keccak.vcd");
	$dumpvars(0, tbkeccak);
	
	file = $fopen("../test_vectors/keccak_in.txt", "rb");
	if (file == 0) begin
	   $display("Error: Could not open test_vectors.txt");
	   $finish;
	end
	
	file_out = $fopen("../test_vectors/keccak_verilog_out.txt", "w");
	
	r = $fscanf(file, "%s", totaltv_count_str);
	code = $sscanf(totaltv_count_str, "%d", totaltv_count);
	$display("Test Records: %d", totaltv_count);
	
	start = 1'b0;	
	din = 64'd0;
	din_valid = 1'b0;
	last_block = 1'b0;
	
	rst_n = 1'b0;
	repeat(5)
	  @(posedge clk);
	
	rst_n = 1'b1;
	repeat(5)
	  @(posedge clk);
	
	for (tv_count = 0; 
	     tv_count < totaltv_count; 
	     tv_count = tv_count + 1) 
	  begin
	     
	     if ((tv_count % 100) == 99)
	       $display(tv_count + 1);
	     
	     start = 1'b1;
	     @(posedge clk);
	     
	     start = 1'b0;
	     @(posedge clk);

	     forever
	       begin
		  
		  start = 1'b0;		  
		  din_valid = 1'b0;
		  
		  r = $fscanf(file, "%s", line);
		  if ($feof(file) || (line[0] == "-"))
		    break;
		  
		  r = $sscanf(line, "%h", hex_value);
		  din = hex_value;
		  din_valid = 1'b1;
		  
		  @(posedge clk);

		  while (buffer_full == 1'b1)
		    begin
		       din_valid = 1'b0;
		       @(posedge clk);
		    end
		  
	       end 
	     
	     
	     if (line[0] == "-")
	       begin
		  @(posedge clk);
		  
		  forever
		    begin
		       if ((ready == 1'b0) || (buffer_full == 1'b1))
			 @(posedge clk);
		       
		       else
			 break;		       
		    end
		  
		  last_block = 1'b1;
		  @(posedge clk);
		  
		  i = 0;
		  forever
		    begin
		       
		       last_block = 1'b0;
		       if (dout_valid == 1'b1)
			 begin
			    i = i + 1;
			    $fdisplay(file_out, "%H", dout);
			 end
		       @(posedge clk);
		       
		       if (i == 4)
			 begin
			    $fdisplay(file_out, "-");
			    break;
			 end
		       
		    end
	       end // if (line[0] == "-")	     
	     
	  end // next testvector
	
	
	$fclose(file);	
	$fclose(file_out);	
	$finish;
	
     end   
   
endmodule
