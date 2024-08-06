using TypedNamedTuples: TypedNamedTuples, @TypedNamedTuple, @MutableTypedNamedTuple
using Test
using Aqua

@testset "TypedNamedTuples.jl" begin
    @testset "Code quality (Aqua.jl)" begin
        Aqua.test_all(TypedNamedTuples)
    end

    @testset "@TypedNamedTuple" begin
        @TypedNamedTuple TestType
        @test TestType(;) isa TestType

        t = TestType(; a=4, b=rand, c=:hello)
        @test t.a == 4
        @test t.b == rand
        @test t.c == :hello
        @test t isa TestType

        @test_throws Exception t.d
        @test_throws Exception t.a = 0

        @test keys(t) == (:a, :b, :c)
        @test values(t) == (4, rand, :hello)

        @test Tuple(t) == (4, rand, :hello)
        @test NamedTuple(t) == (a=4, b=rand, c=:hello)

        @test all((_t for _t in t) .== [(:a, 4), (:b, rand), (:c, :hello)])
    end

    @testset "@MutableTypedNamedTuple" begin
        @MutableTypedNamedTuple MutTestType
        @test MutTestType(;) isa MutTestType

        t = MutTestType(; a=4, b=rand, c=:hello)
        @test t.a == 4
        @test t.b == rand
        @test t.c == :hello
        @test t isa MutTestType

        @test_throws Exception t.d

        t.a += 1
        @test t.a == 5
        t.b = max
        @test t.b == max
        t.c = 1.0
        @test t.c == 1.0
        t.d = pi
        @test t.d == pi

        @test keys(t) == (:a, :b, :c, :d)
        @test values(t) == (5, max, 1.0, pi)

        @test Tuple(t) == (5, max, 1.0, pi)
        @test NamedTuple(t) == (a=5, b=max, c=1.0, d=pi)

        @test all((_t for _t in t) .== [(:a, 5), (:b, max), (:c, 1.0), (:d, pi)])
    end
end
