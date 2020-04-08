import Base.Threads.@spawn


function secuential_mergesort!(arr)

    if length(arr) == 1

        return arr
    end

    # dividir
    med = length(arr) ÷ 2
    fin = length(arr)


    izq = secuential_mergesort!(arr[1:med])
    der = secuential_mergesort!(arr[med+1:fin])

    #merge
    temp = Array{Int}(undef, fin)

    i = 1
    j = 1
    for k = 1:length(temp)
        if (j > length(der)) || i <= length(izq) && izq[i] < der[j]
            temp[k] = izq[i]
            i += 1
        else
            temp[k] = der[j]
            j += 1
        end
    end

    return temp

end

function parallel_mergesort!(arr)

    if length(arr) == 1

        return arr
    end

    # dividir
    med = length(arr) ÷ 2
    fin = length(arr)


    izqTask = Threads.@spawn parallel_mergesort!(arr[1:med])
    derTask = Threads.@spawn parallel_mergesort!(arr[med+1:fin])

    izq = fetch(izqTask)
    der = fetch(derTask)

    #merge
    temp = Array{Int}(undef, fin)

    i = 1
    j = 1

    for k = 1:length(temp)
        if (j > length(der)) || i <= length(izq) && izq[i] < der[j]
            temp[k] = izq[i]
            i += 1
        else
            temp[k] = der[j]
            j += 1
        end
    end

    return temp

end

function cutoff_parallel_mergesort!(arr)

    if length(arr) == 1

        return arr
    end

    # if largo array es < a 10000 ordenar secuencial
    if (length(arr) < 100000)
        return secuential_mergesort!(arr)
    end

    # dividir
    med = length(arr) ÷ 2
    fin = length(arr)


    izqTask = Threads.@spawn parallel_mergesort!(arr[1:med])
    derTask = Threads.@spawn parallel_mergesort!(arr[med+1:fin])

    izq = fetch(izqTask)
    der = fetch(derTask)

    #merge
    temp = Array{Int}(undef, fin)

    i = 1
    j = 1

    for k = 1:length(temp)
        if (j > length(der)) || i <= length(izq) && izq[i] < der[j]
            temp[k] = izq[i]
            i += 1
        else
            temp[k] = der[j]
            j += 1
        end
    end

    return temp

end


size = 20000000

arr = rand(Int, size)
println("Array size: ", size)
#arr = [1, 9, 2, 8, 3, 7, 6, 4, 5, 5]
#println("ORIGINAL: ", arr)

println("Sequential:")
@time sequential = secuential_mergesort!(copy(arr))
#println("RESULT: ", secuential)

println("Parallel:")
print(Threads.nthreads())
@time parallel = parallel_mergesort!(copy(arr))

println("Parallel with cutoff:")
print(Threads.nthreads())
@time parallel = cutoff_parallel_mergesort!(copy(arr))
