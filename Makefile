VERILATOR := verilator
LINT_OPTIONS := --lint-only --top-module top
RTL_DIR = rtl

lint:
		${VERILATOR} ${LINT_OPTIONS} ${RTL_DIR}/* 
