#module HammingDist

function hammingdist(l1::T, l2::T) where T <: Union{AbstractVector, AbstractString}
    if length(l1) != length(l2)
        throw(ArgumentError("L1 and L2 have different length! len l1 = $(length(l1)) and len l2 = $(length(l2))"))
    end
    return count(t->t[1]!=t[2], zip(a,b))
end


