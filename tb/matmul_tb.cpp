#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vtop.h"

#include <cstdint>
#include <array>
// #include <cstring>
// #include <cfenv>
// #include <cmath>
#include <cstdio>


Vtop* dut;
static VerilatedVcdC *trace;

std::array<std::array<uint8_t, 4>, 4> input = {{
    {1, 2, 3, 4},
    {5, 6, 7, 8},
    {9, 10, 11, 12},
    {13, 14, 15, 16}
}};


void tick(){
  dut -> clk = 0;
  dut -> eval();
  dut -> clk = 1;
  dut -> eval();
}

void reset(){
  dut -> rst_n = 0;
  dut -> start = 0;
}

int main(int argc, char **argv){
  Verilated::commandArgs(argc, argv);
  Verilated::traceEverOn(true);
  trace = new VerilatedVcdC;
  dut = new Vtop;
  dut -> trace(trace, 10);

  
  reset();
  tick();

  dut -> rst_n = 1;
  for (int i =0; i < 4; ++i){
    for (int j = 0; j< 4; ++j){
      dut -> mat_a[i][j] = input[i][j];
      dut -> mat_b[i][j] = input[i][j];
    }
  }

  dut -> start = 1;
  tick();
  dut -> start = 0;
  tick();
  tick();
  tick();
  tick();

  for (int i =0; i < 4; ++i){
    for (int j = 0; j< 4; ++j){
      printf("%u ", static_cast<unsigned>(dut -> mat_out[i][j]));
    }
    printf("\n");
  }
}
