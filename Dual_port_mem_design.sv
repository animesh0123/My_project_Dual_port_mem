module memory(clk,rst,wr_data,rd_addr,wr_addr,valid,wr_en,rd_en,rdata,ready);
  parameter MEM_DEPTH=16;
  parameter MEM_WIDTH=8;
  parameter ADD_WIDTH=4;
  input clk,rst,valid,wr_en,rd_en;
  input[MEM_WIDTH-1:0] wr_data;
  input [ADD_WIDTH-1:0] rd_addr,wr_addr;
  output reg [MEM_WIDTH-1:0] rdata;
  output reg ready;
  
  reg[MEM_WIDTH-1:0] mem[MEM_DEPTH-1:0];
  always@(posedge clk or  negedge rst)
    begin
      if(!rst)
        begin
          rdata<=0;
          ready<=0;
          for(integer i=0; i<MEM_DEPTH-1; i=i+1)
            begin
            mem[i]<=0;
        end
    end
  else begin                     /////write//////////
    if(valid==1)begin
      ready<=1;
      if(wr_en==1  && rd_en==0)
        mem[wr_addr]<=wr_data;
      
      
      else if(wr_en==0  && rd_en ==1)    ///    ///////read/////
        rdata<=mem[rd_addr];
      
      
      else if(wr_en==1 && rd_en==1)begin //////read_write/////
        mem[wr_addr]<=wr_data; 
        rdata<=mem[rd_addr];
      end
      ready<=0;
    end
  end
    end  
endmodule
        
        
      
        
      
          
