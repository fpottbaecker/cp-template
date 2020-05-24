# Competitive Programming Template

This is a mostly platform independent template, most scripts are written for CMake, which is required as build system.

## Setup

* Change project name in root `CMakeLists.txt`
* Run `contests/add_contest NAME`
* Then, either
    * Download `samples-TASK.zip` files and run `contest/NAME/load_tasks`, or
    * Run `contest/NAME/add_task TASK`
* Write code (this is the important part)
* Run `ctest` in the tasks cmake binary directory to test it

## Features

### Contest and task management

* `contests/add_contest NAME` to create a new contest `NAME`.
  > This invokes `scripts/add_contest.cmake` to create a contest folder, using `templates/contest.cmake` and `templates/contest/*`.
* `contests/NAME/add_task TASK` to create a new task `TASK` in contest `NAME`.
  > This invokes `scripts/add_task.cmake` to create a task folder, using `templates/task.cmake`, `templates/template.cpp` and `templates/task/*`.
* `contests/NAME/load_tasks` creates a task for each `samples-TASK.zip` in contest `NAME` and adds the samples contained in the zip file.
  > This invokes `scripts/load_tasks.cmake`, which uses `scripts/add_task.cmake` to create task folders.
* `contests/NAME/TASK/add_sample NAME` creates a sample for the given task (both `NAME.in` and `NAME.out`).
  > This is just a bash script, but rather simple, so it should be easily portable.

### Automatic testing of all samples

Run `ctest` in the cmake build directory corresponding to a task (in CLion: `cmake-build-TYPE/contests/NAME/TASK`) to run all samples. Add `--output-on-failure` for more detail (e.g. solution diff). Add `-j 8` and/or `--progress` if you feel like it.

Each time `cmake` is run (the project is reloaded), `ctest` tests are generated.
Each task receives a build test (as testing is performed via a script, the test runner does not have to be built).
For each `SAMPLE` of the task, a test is created which runs the task executable with `SAMPLE.in` as input and compares the output with `SAMPLE.out`.
The test fails if:

* the execution does not finish within 5 seconds (configurable in `common.cmake` in the `add_sample_tests` macro)
* the executable exits with a non-zero exit code (usually a run error, error output is printed to console if using `--output-on-failure`)
* the output does not match the desired output (wrong answer, diff output is printed to console if using `--output-on-failure`)

Program output is saved to `SAMPLE.result`, diff output (if any) is saved to `SAMPLE.result.diff`, error output (if any) is saved to `SAMPLE.result.err`.
The sample tests are skipped if the build fails.

> There are two test runner scripts, `perform_test.sh` for UNIX and `perform_test.cmake` for other platforms. `perform_test.sh` terminates itself with `SIGSEGV` to make `ctest` output `Exception` instead of `Failed` to allow for a quick distinction between run errors and wrong answers. `perform_test.cmake` does not have this capability, so both run errors and wrong answers are reported as `Failed`.
>
> `perform_test.cmake` uses `diff` to compare outputs, this might need to be changed based on the setup.
>
> `perform_test.sh` uses `diff`, `head` and `wc` (although the latter two are not strictly required).

