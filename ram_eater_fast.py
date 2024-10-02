import multiprocessing
import ctypes

def consume_ram():
    # Consume RAM aggressively
    data = []
    while True:
        # Allocate ~100 MB at a time
        data.append(' ' * 100 * 1024 * 1024)

if __name__ == '__main__':
    # Get the number of CPU cores
    num_cores = multiprocessing.cpu_count()

    # Create a process for each core
    processes = []
    for _ in range(num_cores):
        p = multiprocessing.Process(target=consume_ram)
        p.start()
        processes.append(p)

    # Wait for all processes to finish (which they won't unless terminated)
    for p in processes:
        p.join()
