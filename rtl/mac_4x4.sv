import params::*;

module mac_4x4 (
    input logic clk,
    input logic rst_n,
    input logic enable,
    input logic clear,
    input logic unsigned [DATA_WIDTH-1:0] a[M][M],
    input logic unsigned [DATA_WIDTH-1:0] b[M][M],
    output logic unsigned [2*DATA_WIDTH + $clog2(M)-1:0] out[M][M],
    input logic [$clog2(M)-1:0] k
  );

  //source https://chipverify.com/verilog/verilog-generate-block
  genvar i, j;

  generate
    for(i = 0; i < M ; i = i +1) begin
      for(j = 0; j < M ; j = j +1) begin : gen_mac
        mac mac_unit(
          .clk(clk),
          .rst_n(rst_n),
          .enable(enable),
          .clear(clear),
          .a(a[i][k]),
          .b(b[k][j]),
          .out(out[i][j])
          );
      end
    end
  endgenerate


endmodule
