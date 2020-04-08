for n in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
do
  export JULIA_NUM_THREADS=$n
  julia ./mergesort.jl >> cluster_log_20M
done
