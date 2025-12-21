// module tb();
// parameter data_width = 8;
// reg  clk , reset, write_en, read_en;
// reg [data_width-1 : 0] data_in;
// wire [data_width-1 : 0] data_out ;
// wire empty, full;
// initial begin
//     clk =0; reset = 1; write_en = 0 ; read_en = 0 ;
// end
// always #5 clk = ~ clk;

// initial begin
//     reset = 0; write_en = 1; read_en =0; data_in = 8'h45; #10;
//     $display("time = %0t || reset = %0b || read_en = %0b || data_in = %0b || write_en = %0b|| data_out = %0b || empty = %0b || full = %0b", $time, reset, read_en,data_in,write_en,data_out,empty,full);
// end
// initial begin
// end
// initial begin
// end
// endmodule

// `timescale 1ns/1ps

module FIFO_tb;

  // Parameters match DUT
  localparam DATA_WIDTH = 8;
  localparam DEPTH      = 16;
  localparam PTR_SIZE   = 4;

  // DUT ports
  reg                   clk;
  reg                   reset;
  reg                   write_en;
  reg                   read_en;
  reg  [DATA_WIDTH-1:0] data_in;
  wire                  empty;
  wire                  full;
  wire [DATA_WIDTH-1:0] data_out;

  // Instantiate DUT
  FIFO #(DATA_WIDTH, DEPTH, PTR_SIZE) dut (
    .clk     (clk),
    .reset   (reset),
    .write_en(write_en),
    .read_en (read_en),
    .data_in (data_in),
    .empty   (empty),
    .full    (full),
    .data_out(data_out)
  );

  // Clock generation: 10 ns period
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Stimulus
  integer i;
  initial begin
    // Initialize
    reset    = 1;
    write_en = 0;
    read_en  = 0;
    data_in  = 0;

    // Apply reset for some cycles
    #20;
    reset = 0;

    // WRITE PHASE: write up to DEPTH values
    $display("Time  wr_en rd_en full empty data_in data_out");
    for (i = 0; i < DEPTH+2; i = i+1) begin
      @(posedge clk);
      if (!full) begin
        write_en <= 1;
        data_in  <= i;   // simple pattern: 0,1,2,...
      end else begin
        write_en <= 0;   // stop when full
      end
      read_en <= 0;
      $display("%0t   %b     %b     %b    %b    0x%0h   0x%0h",
               $time, write_en, read_en, full, empty, data_in, data_out);
    end

    // One idle cycle
    @(posedge clk);
    write_en <= 0;
    read_en  <= 0;

    // READ PHASE: read until empty
    for (i = 0; i < DEPTH+2; i = i+1) begin
      @(posedge clk);
      if (!empty) begin
        read_en  <= 1;
      end else begin
        read_en  <= 0;
      end
      write_en <= 0;
      $display("%0t   %b     %b     %b    %b    0x%0h   0x%0h",
               $time, write_en, read_en, full, empty, data_in, data_out);
    end

    // Finish simulation
    @(posedge clk);
    $finish;
  end

eendmodule
