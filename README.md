# TypedNamedTuples.jl

[![Build Status](https://github.com/sandyspiers/TypedNamedTuples.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/sandyspiers/TypedNamedTuples.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/sandyspiers/TypedNamedTuples.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/sandyspiers/TypedNamedTuples.jl)
[![Code Style: Blue](https://img.shields.io/badge/code%20style-blue-4495d1.svg)](https://github.com/invenia/BlueStyle)
[![Aqua](https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg)](https://github.com/JuliaTesting/Aqua.jl)

This package provides two macros, `@TypedNamedTuple` and `@MutableTypedNamedTuple`.
These macros create struct types that behave like named tuples but have enforced types. 
You can use them like regular named tuples (and even mutable ones), with the added benefit of type safety, making them useful for function extension and multiple dispatch.

For example:

```julia
julia> using TypedNamedTuples

julia> @TypedNamedTuple ExampleType;

julia> ex = ExampleType(a=2, b=1:10, c=:hello, d=false)
ExampleType(a = 2, b = 1:10, c = :hello, d = false)

julia> ex.a
2

julia> typeof(ex)
ExampleType

julia> keys(ex)
(:a, :b, :c, :d)

julia> values(ex)
(2, 1:10, :hello, false)

julia> get(ex, :a, nothing)
2

julia> f(ex::ExampleType) = ex.a
f (generic function with 1 method)

julia> f(ex)
2

julia> f(2)
ERROR: MethodError: no method matching f(::Int64)

Closest candidates are:
  f(::ExampleType)
   @ Main REPL[12]:1

Stacktrace:
 [1] top-level scope
   @ REPL[14]:1
```

In fact, we can do all the same as a mutable type:

```julia
julia> @MutableTypedNamedTuple MutType
MutType

julia> m = MutType(x=5)
MutType(x = 5,)

julia> m.x
5

julia> m.x *= 2
10

julia> print(m)
MutType(x = 10,)

julia> m.a = :hello
:hello

julia> m
MutType(x = 10, a = :hello)
```

As you can see, we can both modify elements _and_ and new ones!
Note that it is very expensive to mutate, so its best to do so sparingly.
If you have to mutate a lot, this is probably not the best tool to use.

