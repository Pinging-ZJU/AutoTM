module Optimizer

using ..Utils
using ..Profiler
import ..AutoTM
import nGraph


using ProgressMeter
using LightGraphs
using JuMP
using DocStringExtensions

# Scheduling Heuristic
include("affinity.jl")

include("abstractoptimizer.jl")
include("factory.jl")
include("configure.jl")

# Specific optimizer backends
include("ilp/ilp.jl")
include("numa/numa.jl")
include("memory_mode/memory_mode.jl")

#####
##### For gathering statistics
#####

_move_filter() = x -> ismove(x) && !ismoveasync(x)
_async_filter() = x -> ismoveasync(x)

# Hacky extensions for X-types
Utils.ismove(x::Profiler.XNode) = ismove(nGraph.Node(unx(x)))
Utils.ismoveasync(x::Profiler.XNode) = ismoveasync(nGraph.Node(unx(x)))
nGraph.is_persistent(x::Profiler.XTensor) = nGraph.is_persistent(unx(x))

function _move_filter(dest)
    is_persistent_result = (dest == PMEM) ? true : false

    return x -> ismove(x) && nGraph.is_persistent(first(outputs(x))) == is_persistent_result
end

function _async_filter(dest)
    is_persistent_result = (dest == PMEM) ? true : false

    return x -> _async_filter()(x) && nGraph.is_persistent(first(outputs(x))) == is_persistent_result
end

# Count metrics
_count(f, data; kw...) = _count(f, x -> 1, data; kw...)
function _count(f, g, data; filt = x -> true)
    count = 0
    for node in filter(filt, nodes(data))
        for tensor in f(node)
            count += g(tensor)
        end
    end
    return count
end

end
