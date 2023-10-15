using Statistics
using Random
using SparseArrays
using LinearAlgebra



function sinkhorn(a, b, M, lambda, maxit) 
# the function outputs the smoothed optimal transport (minimize (P,M) - lambda H(P))
# between the distributions (a,b) and cost matrix M
####  INPUT  ####
#   a is a d1 x 1 column vector in the probability simplex (nonnegative, summing to one).
#   b is a d2 x 1 column vector in the probability simplex.
#   M is the d1 x d2 matrix of pairwise distances between bins described in a and bins in b.
#   lambda is the coefficient that regularize the problem
#   maxit: maximal number of Sinkhorn fixed point iterations.
#   
#### OUTPUT ####
#   T is the d1 x d2 matrix smoothed optimal transport between (a,b).
####################################################################

    n = length(a)
    m = length(b)
    if size(M) != (n,m) 
        throw(ArgumentError("Distance matrix M has size not matching a and b"))
    end

    K = exp.(- lambda*M)
    cont = 0        # fixed point counter
    v= ones(m)/m   # initialization of starting point
    
    #### Fixed point loop
    # the iteration is u=a./(K*(b./(K'*u)))
    # as stopping Criterion it checks whether the difference between the marginals 
    # of the current optimal transport and the theoretical marginals are satisfied.
    tolerance=.8e-19;
   
    while cont < maxit
        u = a./(K*v)
        v = b./(K'*u)
        cr = norm(sum(abs.(v.*(K'*u)-b)),Inf) # check the marginal difference 
        P=Diagonal(u)*K*Diagonal(v)

        println(sum(P.*M))
        if cr < tolerance || isnan(cr)
            break;
        end
        cont += 1
    end
    return P
end



lambda=0.1;
maxit=10;

Random.seed!(1) ;
d1=120; 
d2=100;
N=1;
M=rand(d1,d2); 
M=M/median(M[:]); # normalize to get unit median.
K=exp.(-lambda*M);
a=Vector(sprand(d1,.8)); a=a/sum(a); 
b=Vector(sprand(d2,.8)); b./= sum(b, dims=1) ; 

P=sinkhorn(a,b, M, lambda, maxit); # running with VERBOSE


