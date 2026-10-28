import params::*;

module mac_4x4
  #(
    parameter N = 4
  )(
    input logic clk,
    input logic rst_n,
    input logic enable,
    input logic unsigned [DATA_WIDTH-1:0] a[M][M],
    input logic unsigned [DATA_WIDTH-1:0] b[M][M],
    output logic unsigned [2*DATA_WIDTH:0] out[M][M]
  );

  //source https://chipverify.com/verilog/verilog-generate-block
  genvar i, j;
  logic [1:0] k;

  always_ff @(posedge clk or negedge rst_n) begin 
    if (!rst_n) begin
      k <= 0;
    end else if (enable && k < 3) begin
      k <= k + 1 ;
    end
  end

  generate
    for(i = 0; i < N ; i = i +1) begin
      for(j = 0; j < N ; j = j +1) begin : gen_mac
        mac mac_unit(
          .clk(clk),
          .rst_n(rst_n),
          .enable(enable),
          .a(a[i][k]),
          .b(b[k][j]),
          .out(out[i][j])
          );
      end
    end
  endgenerate


endmodule
