import Base.Threads.@spawn


function secuential_mergesort!(arr)

    if length(arr) == 1

        return arr
    end

    # dividir
    med = length(arr)÷ 2
    fin = length(arr)

    izq = secuential_mergesort!(copy(arr[1:med]))
    der = secuential_mergesort!(copy(arr[med+1:fin]))

    #merge
    temp = Array{Int}(undef,fin)

    i = 1
    j = 1
    for k in 1:length(temp)

        if (j > length(der)) || i <= length(izq) && izq[i] < der[j]
            temp[k] = izq[i]
            i+=1
        else
            temp[k] = der[j]
            j+=1
        end
    end

   return temp

end

function parallel_mergesort!(arr)

    if length(arr) == 1

        return arr
    end

    # dividir
    med = length(arr)÷ 2
    fin = length(arr)


    izqTask = Threads.@spawn parallel_mergesort!(copy(arr[1:med]))
    derTask = Threads.@spawn parallel_mergesort!(copy(arr[med+1:fin]))

    izq = fetch(izqTask)
    der = fetch(derTask)

    #merge
    temp = Array{Int}(undef,fin)

    i = 1
    j = 1

    for k in 1:length(temp)

        if (j > length(der)) || i <= length(izq) && izq[i] < der[j]
            temp[k] = izq[i]
            i+=1
        else
            temp[k] = der[j]
            j+=1
        end
    end

   return temp

end


arr = rand(Int,1000000)

#@time secuential = secuential_mergesort!(copy(arr))
print(Threads.nthreads())
@time parallel = parallel_mergesort!(copy(arr))
