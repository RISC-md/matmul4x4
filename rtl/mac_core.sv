import params::*;

module mac(
  input logic clk,
  input logic rst_n,
  input logic enable,
  input logic clear,
  input logic unsigned [DATA_WIDTH-1:0] a,
  input logic unsigned [DATA_WIDTH-1:0] b,
  output logic unsigned [2*DATA_WIDTH + $clog2(M)-1:0] out
  );

  logic unsigned [2*DATA_WIDTH + $clog2(M)-1:0] d_product;

  assign d_product = a * b;

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n || clear) begin
      out <= 0;
    end else if (enable) begin
      out <= out + d_product;
    end
  end

endmodule
