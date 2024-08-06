# TypedNamedTuples.jl

[![Build Status](https://github.com/sandyspiers/TypedNamedTuples.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/sandyspiers/TypedNamedTuples.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/sandyspiers/TypedNamedTuples.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/sandyspiers/TypedNamedTuples.jl)
[![Code Style: Blue](https://img.shields.io/badge/code%20style-blue-4495d1.svg)](https://github.com/invenia/BlueStyle)
[![Aqua](https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg)](https://github.com/JuliaTesting/Aqua.jl)

This package provides two macros, `@TypedNamedTuple` and `@MutableTypedNamedTuple`.
These are essentially used to define a new struct types that behave exactly like a named tuple would.
This allows you to do the following:

```julia
julia> using TypedNamedTuples

julia> @TypedNamedTuple ExampleType
ExampleType

julia> ex = ExampleType(a=2,b=3,c=:hello)
ExampleType(a = 2, b = 3, c = :hello)

julia> ex.a
2

julia> ex.c
:hello

julia> keys(ex)
(:a, :b, :c)

julia> values(ex)
(2, 3, :hello)

julia> f(ex::ExampleType) = ex.a * ex.b
f (generic function with 1 method)

julia> f(ex)
6
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
