function prob(tgt::Int64, n::Int64)
    mem = zeros(n)
    for i = 1:tgt
        if i <= n
            j = i%n + 1 # everything is translated of 1 to the right
            mem[j] = sum(mem)/n + 1/n
        else 
            j = i%n + 1
            mem[j] = sum(mem)/n
        end
    end
    k = tgt%n + 1
    return mem[k]
end


