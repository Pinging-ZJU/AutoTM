# Installation

## Getting Code

If retrieving the most up-to-date version of the code, clone the repository with
```sh
git clone --recursive https://github.com/darchr/AutoTM
export AUTOTM_HOME=$(pwd)/AutoTM
```

If retrieving code via DOI, run
```sh
wget https://zenodo.org/record/3612698/files/autotm.tar.gz
tar -xvf autotm.tar.gz
export AUTOTM_HOME=$(pwd)/AutoTM
```

## Setup

A simple setup needs to be performed to indicate how the project will be used.
To enter the setup, run
```sh
cd $AUTOTM_HOME
julia --color=yes setup.jl
```
The following selections can be made - choose which are appropriate for your system:
* Use NVDIMMs in 1LM (requires a Cascade Lake system with Optane DC NVDIMMs)
* Use of a GPU (requires CUDA 10.1 or CUDA 10.2)
* Use Gurobi as the ILP solver (requires a Gurobi license (see below)).
    If Gurobi is not selected, the open source Cbc solver will be used.
    Please note that the original experiments were run with Gurobi.
    
## Building

Launch Julia from the AutoTM project
```sh
cd $AUTOTM_HOME/AutoTM
julia --project
```

In the Julia REPL, press `]` to switch to package (pkg) mode and run following commands:
```julia
julia> ]
(AutoTM) pkg> instantiate
(AutoTM) pkg> build -v
```
This will trigger the build process for our custom version of ngraph.
Passing the `-v` command to `build` will helpfully display any errors that occur during the build process.

## Using the Gurobi ILP solver (optional)

The results in the AutoTM paper use [Gurobi](https://www.gurobi.com) for the ILP solver.
However, Gurobi requires a license to run.
Free trial and academic licenses are available from the Gurobi website: https://www.gurobi.com

If using Gurobi, please obtain a license and install the software according the instructions on the website.

Then, when building the project, make sure to run
```julia
julia> ENV["GUROBI_HOME"] = "path/to/gurobi"
```
in Julia before executing the build step above.

!!! note

    Using the Gurobi ILP solver is optional.
    If not selected during the setup step, an open-source solver [Cbc](https://projects.coin-or.org/Cbc) will be used.
    However, since Cbc is considerably less powerful than Gurobi, larger ILP models will likely not be solvable in a reasonable period of time.

## Acceptable Build Warnings

CMake warnings regarding variable `TBB_ROOT` can be ignored.
The version of `ngraph` used for this project does not use any of the `TBB` based code but does not build with `TBB` disabled.

