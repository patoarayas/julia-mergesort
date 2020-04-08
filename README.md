# julia-mergesort
Implementation of MergeSort in Julia.

Author:  Patricio Araya.

This program is part of HPC course at UCN. Implements MergeSort algorithm in sequential and parallel form.

# speed up analysis

![speedup graphic](/cluster-speed-up.png)

As the graphic shows there is a noticeable speed-up on the performance at more threads are used.

The graph shows 2 implementations of the algorithm. The parallel and a parallel implementation with a cutoff, this is if the size of the array to be sorted is below a number is sorted using a sequential algorithm.

One thing to notice is for the algorithm usage of memory there is a considerable overhead in execution time (and in memory usage) also there is a overhead in Garbage collection. (~30% of the duration of the program is GC).
