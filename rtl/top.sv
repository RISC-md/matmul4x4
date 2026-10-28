import params::*;

module top (
  input logic clk,
  input logic rst_n,
  logic start,
  input logic [DATA_WIDTH-1:0] mat_a[M][M],
  input logic [DATA_WIDTH-1:0] mat_b[M][M],
  output logic [2*DATA_WIDTH:0] mat_out[M][M]
);

  //This will only run for 4 cycles

  //TODO: state machine so we can run
  //for an arbitrary number of cycles
  //and be able to do NxN multiplication
  //rather than just 4x4
  logic enable;
  logic [1:0] count;  

  mac_4x4 mac4x4_inst(
    .clk(clk),
    .rst_n(rst_n),
    .enable(enable),
    .a(mat_a),
    .b(mat_b),
    .out(mat_out)
    );

  always_ff @(posedge clk or negedge rst_n) begin 
    if (!rst_n) begin
      enable <= 0;
      count <= 0;
    end else if (start && !enable) begin
      enable <= 1;
      count <= 0;
    end else if (enable) begin
      if (count == 3)
        enable <= 0;
      else
        count <= count + 1;
      end 
  end

endmodule
