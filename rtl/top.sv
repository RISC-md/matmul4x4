import params::*;

module top (
  input logic clk,
  input logic rst_n,
  logic start,
  input logic [DATA_WIDTH-1:0] mat_a[M][M],
  input logic [DATA_WIDTH-1:0] mat_b[M][M],
  output logic [2*DATA_WIDTH + $clog2(M)-1:0] mat_out[M][M],
  output logic done
);


  mac_controller controller1 (
    .clk    (clk),
    .rst_n  (rst_n),
    .start  (start),
    .mat_a  (mat_a),
    .mat_b  (mat_b),
    .mat_out(mat_out),
    .done   (done)
  );


endmodule
