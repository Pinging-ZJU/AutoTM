module Profiler

# profiledata.jl
export  FunctionData,
        XNode,
        XTensor,
        enums, times, gettime, bytes,
        can_select_algo,
        is_persistent,
        isarg,
        nodes, tensors,
        unx,
        producer,
        consumer,
        users,
        locations,
        get_configs,
        getconfig,
        _setup!,
        configs_for,
        live_tensors

# cache.jl
export CPUKernelCache, GPUKernelCache

# kernels.jl
export profile, read_timing_data

# compare.jl
export compare

# stdlib deps
using Serialization, Dates

using ..Utils
using ProgressMeter
#using JSON
using Statistics
import nGraph
import ..AutoTM._env_context

include("profiledata.jl")
include("cache.jl")
include("kernels.jl")
include("compare.jl")
include("gpu.jl")
include("callbacks.jl")

end
