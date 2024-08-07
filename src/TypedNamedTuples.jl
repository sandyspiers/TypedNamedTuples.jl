module TypedNamedTuples

export @TypedNamedTuple, @MutableTypedNamedTuple

# # TypedNamedTuples

abstract type TypedNamedTuple end

_nt(tnt::TypedNamedTuple) = getfield(tnt, :_nt)
Base.getproperty(tnt::TypedNamedTuple, sym::Symbol) = getfield(_nt(tnt), sym)
Base.get(tnt::TypedNamedTuple, sym::Symbol, default) = get(_nt(tnt), sym, default)

Base.keys(tnt::TypedNamedTuple) = keys(_nt(tnt))
Base.values(tnt::TypedNamedTuple) = values(_nt(tnt))

Base.Tuple(tnt::TypedNamedTuple) = values(tnt)
Base.NamedTuple(tnt::TypedNamedTuple) = NamedTuple(zip(keys(tnt), values(tnt)))

Base.iterate(tnt::TypedNamedTuple) = iterate(zip(keys(tnt), values(tnt)))
Base.iterate(tnt::TypedNamedTuple, state) = iterate(zip(keys(tnt), values(tnt)), state)
Base.length(tnt::TypedNamedTuple) = minimum(length.([keys(tnt), values(tnt)]))

Base.show(io::IO, tnt::TypedNamedTuple) = print(io, typeof(tnt), NamedTuple(tnt))

macro TypedNamedTuple(type_name)
    return quote
        struct $(esc(type_name)) <: TypedNamedTuple
            _nt::NamedTuple
        end
        function $(esc(type_name))(; kwargs...)
            return $(esc(type_name))(NamedTuple{keys(kwargs)}(values(kwargs)))
        end
    end
end

# # MutableTypedNamedTuple

abstract type MutableTypedNamedTuple <: TypedNamedTuple end

function Base.setproperty!(mtnt::MutableTypedNamedTuple, sym::Symbol, val)
    return setfield!(mtnt, :_nt, merge(_nt(mtnt), NamedTuple{(sym,)}((val,))))
end

macro MutableTypedNamedTuple(type_name)
    return quote
        mutable struct $(esc(type_name)) <: MutableTypedNamedTuple
            _nt::NamedTuple
        end
        function $(esc(type_name))(; kwargs...)
            return $(esc(type_name))(NamedTuple{keys(kwargs)}(values(kwargs)))
        end
    end
end

end
