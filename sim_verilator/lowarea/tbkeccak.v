module tbkeccak;
   reg clk;
   reg rst_n;
   wire enR;
   wire enW;
   wire [5:0] addr;
   wire [63:0] mem_input;
   wire [63:0] mem_output;
   
   system_mem u_system_mem (
			    .clk(clk),
			    .rst_n(rst_n),
			    .enR(enR),
			    .enW(enW),
			    .addr(addr),
			    .mem_input(mem_input),
			    .mem_output(mem_output)
			    );
   
   reg 		   start;   
   wire		   done;
   
   keccak_copro u_keccak_copro (
				.clk(clk),
				.rst_n(rst_n),
				.start(start),
				.addr(addr),
				.enR(enR),
				.enW(enW),
				.data_from_mem(mem_output),
				.data_to_mem(mem_input),
				.done(done)
				);
   
   initial
     begin
	rst_n = 1'b0;
	#19;
	rst_n = 1'b1;
     end
   
   always
     begin
	clk = 1'b0;
	#10;
	clk = 1'b1;
	#10;
     end
   
   integer     file, file_out;
   string      line;
   integer     i, r;
   reg [63:0]  hex_value;
   
   initial 
     begin
	
	$dumpfile("keccak.vcd");
	$dumpvars(0, tbkeccak);
	
	file = $fopen("../test_vectors/perm_in.txt", "rb");
	if (file == 0) begin
	   $display("Error: Could not open test_vectors.txt");
	   $finish;
	end
	
	file_out = $fopen("../test_vectors/perm_verilog_out.txt", "w");

	start = 1'b0;	
	rst_n = 1'b0;
	repeat(5)
	  @(posedge clk);

	rst_n = 1'b1;	
	repeat(5)
	  @(posedge clk);
	
	forever
	  begin
	     for (i=0; i<25; i=i+1)
	       begin
		  r = $fscanf(file, "%s", line);
		  r = $sscanf(line, "%h", hex_value);
		  u_system_mem.memory[i] = hex_value;
	       end
	     for (i=25; i<64; i=i+1)
	       u_system_mem.memory[i] = 64'h0;
	     
	     start = 1'b1;
	     @(posedge clk);
	     forever
	       begin
		  start = 1'b0;
		  if (done == 1'b1)
		    break;
		  @(posedge clk);
	       end
	     
	     for (i=0; i<25; i=i+1)
	       $fdisplay(file_out, "%h", u_system_mem.memory[i]);
	     $fdisplay(file_out, "-");
	     
 	     r = $fscanf(file, "%s", line); // separator
	     
	     if (($feof(file)) || (line[0] == "."))
	       break;
	     
	  end
	
	$fclose(file);	
	$fclose(file_out);	
	$finish;
	
     end   
   
endmodule

