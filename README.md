# A Simple Metropolis Hastings Algorithm in Julia

Implements a simple metropolis hastings algorithm efficiently using Julia.
Currently single core for testing/comparing with Python speeds.
Will add multiple chains/multiprocessing in the future.
Intended as an experimental project, not for production use.

## Installation/Usage

1. Clone the repository

```git clone https://github.com/fhorrobin/mcmcjulia.jl```

2. Enter the folder

```cd mcmcjulia.jl```

3. Run Julia (with optimizations for best performance, and with -i to make it interactive and show the plots)

```julia -O3 --math-mode=fast --check-bounds=no --project -i main.jl```

Note: Compiling plots takes a few seconds so if you use it with the plotting it will take ~5 seconds to run. Remove the plotting commands to get it to < 1 second.
