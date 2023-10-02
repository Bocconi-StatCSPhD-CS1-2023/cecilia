#module HammingDist

function hammingdist(l1::T, l2::T) where T <: Union{AbstractVector, AbstractString}
    if length(l1) != length(l2)
        throw(ArgumentError("L1 and L2 have different length! len l1 = $(length(l1)) and len l2 = $(length(l2))"))
    end
    dist = 0
    #for i = 1:length(l1)
    #for i in eachindex(l1)   #problem for multibyte character like emoji as the index jumps of 4
        #if l1[i] != l2[i]
        #    dist += 1
        #end
    #end

    #for (a,b) in zip(l1,l2) #or use enumerate for i in enumerate(zip(l1,l2))
    #   if a != b
    #       dist += 1
    #   end
    #end

    #return sum([c1 != c2 for (c1,c2) in zip(a,b)]) #but it creates a vector of true and false
    #return sum(c1 != c2 for (c1,c2) in zip(a,b)) # so we use a GENERATOR! Using round brackets, no need to memory
    return count(t->t[1]!=t[2], zip(a,b))


    #short 



    return dist
end

#end


#signature: Tuple{T,T} where T<:Union{AbstractVector, String}

# for the prompt
#
# include("hamming.jl")
# methods(hamming_dist)

# per pulire la memoria:
# add Revise (all'inizio)
# using Revise
# includet("hamming.jl) (ha una T!!!)

