module tb;
  parameter MEM_DEPTH=16;
  parameter MEM_WIDTH=8;
  parameter ADD_WIDTH=4;
  reg clk,rst,valid,wr_en,rd_en;
  reg [ADD_WIDTH-1:0] rd_addr,wr_addr;
  reg[MEM_WIDTH-1:0] wr_data;
  wire [MEM_WIDTH-1:0] rdata;
  wire ready;
  memory mo (clk,rst,wr_data,rd_addr,wr_addr,valid,wr_en,rd_en,rdata,ready);
  
  initial begin
    clk=0;
    rst=0;
    valid=0;
    wr_en=0;
    rd_en=0;
    #20 rst=1'b1;
  end
  
  always #20 clk =~clk;
  
  ////////////////////////write operation///////////
  
  task write(integer count);
     for(integer i=0;i<count;i=i+1)begin
       //@(posedge clk); 
      wr_en=1;
      valid=1;
      wr_addr=i;
      wr_data=$random;
       @(negedge clk);
    end
    wr_en=0;
  endtask
  
  ///////////////////////////////////read operation/////////
  
  task read(integer count);
    for(integer i=0;i<count;i=i+1)begin
     // @(posedge clk); 
      rd_en=1;
      valid=1;
      rd_addr=i;
      @(negedge clk); 
    end
    rd_en=0;
  endtask
  
  //////////////////////////read_write//////////////////
  
  /*task read_write(integer count);
    for(integer j=0;j<count;j=j+1)begin
        @(negedge clk);
        rd_en=1;
        valid=1;
        rd_addr=j;
    end
    for(integer i=0;i<count;i=i+1)begin
      @(negedge clk);
      wr_en=1;
      valid=1;
      wr_addr=i;
      wr_data=$random;
      end
  endtask*/
  
  task read_write(integer count);
    for(integer i=0;i<count;i=i+1)begin
    fork
      write(2);
      read(2);
    join
    end
  endtask
  
  initial begin
    repeat(3) @(negedge clk);
    write(3);
    read(2);
    write(3);
    read(2);
    read_write(2);
   
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
  initial #5000 $finish;
endmodule
  
    
  
    
    
