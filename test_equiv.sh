#!/usr/bin/env bash

TEST_DIR=$1
TEST_FILE=$(find $TEST_DIR -name "*v")
if [ ! $TEST_FILE ]; then
    TEST_FILE=$(find ../Surelog/$TEST_DIR -name "*v")
fi
read TEST_FILE <<< $TEST_FILE

OUT_DIR=build-equiv

rm -rf $OUT_DIR
mkdir -p $OUT_DIR
../image/bin/sv2v $TEST_FILE > $OUT_DIR/test.v

../image/bin/surelog -parse -sverilog $TEST_FILE -odir $OUT_DIR

../image/bin/yosys -p "\
    read_verilog $OUT_DIR/test.v; \
    prep -auto-top; \
    rename -top gold; \
    design -stash gold; \
    read_uhdm -debug $OUT_DIR/slpp_all/surelog.uhdm; \
    prep -auto-top; \
    rename -top gate; \
    design -stash gate; \
    design -copy-from gold -as gold gold; \
    design -copy-from gate -as gate gate; \
    write_verilog; \
    equiv_make gold gate equiv; \
    hierarchy -top equiv; \
    flatten; \
    equiv_induct; \
    equiv_struct; \
    equiv_status;"
