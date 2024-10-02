import time

def consume_ram():
    data = []
    chunk_size = 100 * 1024 * 1024  # 100 MB
    while True:
        data.append(' ' * chunk_size)
        total_mb = len(data) * chunk_size / (1024 * 1024)
        print(f"RAM consumed: {total_mb:.2f} MB")
        time.sleep(0.1)  # Short delay to allow for interrupt

if __name__ == '__main__':
    print("Starting RAM consumption. Press Ctrl+C to stop.")
    try:
        consume_ram()
    except KeyboardInterrupt:
        print("\nRAM consumption stopped.")
