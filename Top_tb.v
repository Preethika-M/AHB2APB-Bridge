module top_tb();

 wire  Hclk_w,Hwrite_w,Hresetn_w,Hreadyin_w;
 wire [1:0]Htrans_w;
 wire [31:0]Haddr_w,Hwdata_w;

 wire Hreadyout,Penable_w,Pwrite_w;
 wire [1:0]Hresp;
 wire [31:0]Hrdata_w,Pwdata_w,Paddr_w,Prdata_w;
 wire [2:0]Pselx_w; 



AHB_master master(Hrdata_w,Hclk_w,Hwrite_w,Hresetn_w,Hreadyin_w,Htrans_w,Haddr_w,Hwdata_w);

Bridge_top brg(Hclk_w,Hwrite_w,Hresetn_w,Hreadyin_w,Htrans_w,Haddr_w,Hwdata_w,Prdata_w,
		 Hrdata_w,Hresp,Penable_w,Pwrite_w,Hreadyout,Pselx_w,Pwdata_w,Paddr_w);

APB_Slave slave(Penable_w,Pwrite_w,
		 Pselx_w,Pwdata_w,Paddr_w,
		 Prdata_w);


 initial begin 
	master.s_read(); #100
	 master.b_write(); #100
	 master.s_write(); #100
	$finish();
end
 
endmodule
