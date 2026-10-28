//TODO: implement a MAC
//this is essential for multiplying matrices
//more at https://en.wikipedia.org/wiki/Multiply%E2%80%93accumulate_operation
import params::*;

module mac(
  input logic clk,
  input logic rst_n,
  input logic enable,
  input logic unsigned [DATA_WIDTH-1:0] a,
  input logic unsigned [DATA_WIDTH-1:0] b,
  output logic unsigned [2*DATA_WIDTH:0] out
  );
  
  logic unsigned [2*DATA_WIDTH:0] d_product;

  assign d_product = a * b;

  always_ff @(posedge clk or negedge rst_n) begin 
    if (!rst_n) begin
      out <= 0;
    end else if (enable) begin
      out <= out + d_product;
    end
  end
  

endmodule
