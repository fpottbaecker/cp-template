#!/bin/bash

# ARGS
EXECUTABLE_FILE=$1
SAMPLE_ROOT=$2
SAMPLE=$3

SAMPLE_INPUT=${SAMPLE_ROOT}/${SAMPLE}.in
SAMPLE_OUTPUT=${SAMPLE_ROOT}/${SAMPLE}.out
RESULT_OUTPUT=${SAMPLE_ROOT}/${SAMPLE}.result
RESULT_DIFF=${SAMPLE_ROOT}/${SAMPLE}.result.diff
RESULT_ERROR=${SAMPLE_ROOT}/${SAMPLE}.result.err

# Cleanup
rm -f "$RESULT_OUTPUT" "$RESULT_DIFF" "$RESULT_ERROR"

# Run target
$EXECUTABLE_FILE <"$SAMPLE_INPUT" >"$RESULT_OUTPUT" 2>"$RESULT_ERROR"

# Commit suicide if target failed to report exception for CTest (SIGSEGV)
if [ $? -ne 0 ]; then
  echo "Run Error"
  rm "$RESULT_OUTPUT"
  kill -11 $$
fi

# Remove error output if empty
if [ ! -s $RESULT_ERROR ]; then
  rm "$RESULT_ERROR"
fi

# Compare output
echo "Wrong Answer                            Correct Answer" >"$RESULT_DIFF"
echo "------------------------------------------------------" >>"$RESULT_DIFF"
diff -byd -W 80 "${RESULT_OUTPUT}" "${SAMPLE_OUTPUT}" >>"$RESULT_DIFF"

if [ $? -eq 0 ]; then
  # OK
  rm "$RESULT_DIFF"
  exit 0
else
  # Output truncated diff
  MAX_LINES=12
  DIFF_LINES=$(($(wc -l <"$RESULT_DIFF")))
  head -n $MAX_LINES "$RESULT_DIFF"
  if [ $DIFF_LINES -gt $MAX_LINES ]; then
    echo "... (see ${SAMPLE}.result.diff) ..."
  fi
  exit 1
fi
