module AHB_master( input [31:0]Hrdata,
		   output reg Hclk,Hwrite,Hresetn,Hreadyin,[1:0]Htrans,[31:0]Haddr,[31:0]Hwdata);

always  begin
	Hclk = 1'b1;
	forever #10 Hclk = ~Hclk;
	end


task s_write();
begin   #21;
	Hresetn = 1;
	Htrans = 2'b10;
	Hreadyin = 1;
	Haddr = 32'h80000001;
	Hwrite = 1;
	

	#20;
	Htrans = 2'b00;
	Hreadyin = 0;
	Hwdata = 32'h1234;
	Hwrite = 0;
	
end
endtask

task b_write();
begin   #21;
	Hresetn = 1;
	Htrans = 2'b10;
	Hreadyin = 1;
	Haddr = 32'h80000001;
	Hwrite = 1;
	

	#20;
	Htrans = 2'b11;
	Hreadyin = 1;
	Haddr = 32'h80000002;
	Hwdata = 32'h1234;
	Hwrite = 1;
	
	#20;
	Htrans = 2'b11;
	Hreadyin = 1;
	Haddr = 32'h80000003;
	Hwdata = 32'h1235;
	Hwrite = 1;

	#40;
	Htrans = 2'b11;
	Hreadyin = 1;
	Haddr = 32'h80000004;
	Hwdata = 32'h1236;
	Hwrite = 1;
	
	#40;
	Htrans = 2'b00;
	Hreadyin = 0;
	Hwdata = 32'h1237;
	Hwrite = 0;
	
end
endtask

task s_read();
begin   #21;
	Hresetn = 1;
	Htrans = 2'b11;
	Hreadyin = 1;
	Haddr = 32'h80004001;
	Hwrite = 0;
	
	#40;
	Htrans = 2'b00;
	Hreadyin = 0;

	#20;
	Hwrite = 1;
	
end
endtask

task burst_read();
begin   
    #21;
    Hresetn = 1;
    Htrans = 2'b10;  // Non-sequential transfer
    Hreadyin = 1;
    Haddr = 32'h80004001;
    Hwrite = 0;

    #20;
    Htrans = 2'b11;  // Sequential transfer
    Hreadyin = 1;
    Haddr = 32'h80004002;
    Hwrite = 0;

    #20;
    Htrans = 2'b11;  // Sequential transfer
    Hreadyin = 1;
    Haddr = 32'h80004003;
    Hwrite = 0;

    #20;
    Htrans = 2'b11;  // Sequential transfer
    Hreadyin = 1;
    Haddr = 32'h80004004;
    Hwrite = 0;

    #20;
    Htrans = 2'b00;  // Idle transfer
    Hreadyin = 0;
end
endtask

task wrap_write();
    integer j;
    begin
        @(posedge Hclk)
        #1;
        begin
            Hwrite = 1;
            Htrans = 2'b10;
            Hsize = 3'b001;  // Assuming size 8-bit
            Hburst = 3'b011; // Assuming WRAP burst
            Hreadyin = 1;
            Haddr = 32'h8000_0010;
            Hwdata = $random % 256; // Initial data
        end

        for (j = 0; j < 4; j = j + 1) begin // Adjusted burst length for wrap
            @(posedge Hclk)
            #1;
            begin
                Htrans = 2'b11; // Incremental burst
                Haddr = {Haddr[31:3], Haddr[2:0] + 3'b001}; // Adjust for wrap
                Hwdata = $random % 256; // Random data to write

                // Introduce wait state
                @(posedge Hclk);
                #1;
                Hreadyin = 0;
                @(posedge Hclk);
                #1;
                Hreadyin = 1;
            end
        end
        Htrans = 2'b00; // End burst
    end
endtask



endmodule
