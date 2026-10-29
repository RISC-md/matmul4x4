TOP := top
VERILATOR := verilator
LINT_OPTIONS := --lint-only --top-module ${TOP}
GEN_FLAGS := --cc --exe --trace --top-module ${TOP} -o tests -Mdir build
CLANG := clang++
RTL_DIR = rtl
TB_DIR = tb
VTOP = Vtop.mk
OUT_DIR = build

.PHONY: build lint gen

lint:
		${VERILATOR} ${LINT_OPTIONS} ${RTL_DIR}/* 

#gen the obj_dir files
gen:
		${VERILATOR} ${GEN_FLAGS} ${RTL_DIR}/* ${TB_DIR}/*

#make the executable testbench
build: gen
		${MAKE} -C ${OUT_DIR} -f ${VTOP} CXX=${CLANG} LINK=${CLANG}

clean:
		rm -rf ${OUT_DIR}
	 
