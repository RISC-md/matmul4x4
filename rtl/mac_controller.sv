import params::*;

module mac_controller (
  input logic clk,
  input logic rst_n,
  logic start,
  input logic [DATA_WIDTH-1:0] mat_a[M][M],
  input logic [DATA_WIDTH-1:0] mat_b[M][M],
  output logic [2*DATA_WIDTH + $clog2(M)-1:0] mat_out[M][M],
  output logic done
  
);

  typedef enum logic [1:0]{
    IDLE,
    CLEAR,
    RUN
    }state_t;

  state_t state;

  logic enable;
  logic clear;
  assign clear = (state == CLEAR);
  assign enable = (state == RUN);
  logic [$clog2(M)-1:0] k;

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n)begin
      k <= 0;
      done <= 0;
      state <= IDLE;
    end else begin
      done <= 0;

      //Small state machine
      case (state)
        IDLE: begin
          if (start) begin
            k <= 0;
            state <= CLEAR;
          end
        end

        CLEAR: begin
          // since the register 'clear' is continuously assigned to this state 
          // I don't need to explicitly seet it to 1 to clear the MACs
          state <= RUN;
        end

        RUN: begin
          if (int'(k) == M - 1) begin
            done <= 1;
            state <= IDLE;
          end else begin
            k <= k + 1;
          end
        end

        default: state <= IDLE;
      endcase
    end
  end


  mac_4x4 mac4x4_inst(
    .clk(clk),
    .rst_n(rst_n),
    .enable(enable),
    .clear(clear),
    .a(mat_a),
    .b(mat_b),
    .out(mat_out),
    .k(k)
    );
  
  


endmodule
