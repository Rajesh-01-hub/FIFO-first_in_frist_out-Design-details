// declare all i/p and o/p , reg, parameters, wire
module FIFO #( parameter data_width = 8,
                parameter depth = 16,
              parameter ptr_size = 4)  //parameter data_width,depth,ptr_size
  (input clk,reset,write_en,read_en,
            input [data_width-1:0] data_in,
            output empty, full,
            output [data_width-1:0] data_out);

  reg [data_width-1:0] memory [depth-1:0];
  reg [ ptr_size-1 : 0] wr_ptr,rd_ptr;
  reg [ptr_size : 0 ]count;
  reg empty_reg, full_reg;
  integer i;
  // reg [data_width-1:0] data_out_reg data_width,depth,ptr_size
  
  //  write process
  always@(posedge clk or posedge reset) begin
    if(reset)
      wr_ptr <= 0;
    else if(write_en && !(full_reg))
      wr_ptr <= wr_ptr+1'b1;
  end
  // using count define full_reg / empty_reg
  always @(posedge clk or posedge reset) begin
    if(reset)
      count<= 0;
    else begin
      case({(write_en && !(full_reg)),(read_en && !(empty_reg))})
    2'b10 : count <= count +  1;
    2'b01 : count <= count -  1;
    default : count <= count
    endcase
    end
  end  
  // empty_reg and full_reg logic
  always @(posedge clk or posedge reset) begin

    if(reset) begin
      empty_reg <= 1;
      full_reg <= 0;
    end
    else if(count == 0) begin
      empty_reg <= 1;
      full_reg <= 0;
    end

    else if (count == depth) begin
      empty_reg <= 0; full_reg <= 1;
    end

    else begin
      empty_reg <= 0;
      full_reg  <= 0;
    end
    
  end 
  
  
  // read process
  always@(posedge clk or posedge reset ) begin
    if(reset)
      rd_ptr <= 0;
    else if(read_en && !(empty_reg))
      rd_ptr <= rd_ptr+ 1'b1;
  end
  
  // stroage memory 
  always@(posedge clk or posedge reset) begin
    if(reset)begin
      
      for(i=0;i<depth;i=i+1)  begin
          memory[i]<= {data_width{1'bx}};
    end
    end
    else if(write_en && !(full_reg))
      memory[wr_ptr] <= data_in;
  end

  assign data_out = !(empty_reg) ? memory[rd_ptr] : {data_width{1'bx}};
  assign empty = empty_reg;
  assign full = full_reg;
endmodule


  
