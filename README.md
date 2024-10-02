# RAM Monitor and Kill Service

This project provides a system service that monitors RAM usage and automatically kills the process using the most RAM when total usage exceeds 90%. It also sends a desktop notification to inform the user about the killed process.

## Prerequisites

- Ubuntu or Debian-based system (for the installation script)
- `systemd` for service management
- `libnotify-bin` package for desktop notifications (installed by the script)

## Installation

1. **Clone this repository:**
   ```sh
   git clone https://github.com/chukfinley/ram-eater-kill.git
   cd ram-eater-kill
   ```

2. **Run the installation script as root:**
   ```sh
   sudo ./install.sh
   ```

This script will:
- Install necessary packages
- Copy the RAM monitor script to `/usr/local/bin`
- Set up the systemd service
- Enable and start the service

## Usage

The service will start automatically on system boot. You can manually manage it with these commands:

- **Check status:** `sudo systemctl status ram_monitor.service`
- **Stop the service:** `sudo systemctl stop ram_monitor.service`
- **Start the service:** `sudo systemctl start ram_monitor.service`
- **Disable autostart:** `sudo systemctl disable ram_monitor.service`
- **Enable autostart:** `sudo systemctl enable ram_monitor.service`

## How it works

1. The script runs as a systemd service, checking RAM usage every minute.
2. If RAM usage exceeds 90%, it identifies the process using the most RAM.
3. The identified process is terminated, and a desktop notification is sent.
4. The action is logged using the system logger.
5. The script continues monitoring after each check or action.

## Logs

You can view the logs of the killed processes by checking the system log:
```sh
grep "RAM Monitor" /var/log/syslog
```

## Caution

Use this service with care, as it may kill important processes. Consider adjusting the RAM usage threshold or adding a whitelist for critical processes if needed.

## Uninstallation

To uninstall the service:

1. **Stop and disable the service:**
   ```sh
   sudo systemctl stop ram_monitor.service
   sudo systemctl disable ram_monitor.service
   ```

2. **Remove the service file and script:**
   ```sh
   sudo rm /etc/systemd/system/ram_monitor.service
   sudo rm /usr/local/bin/ram_monitor.sh
   ```

3. **Reload systemd:**
   ```sh
   sudo systemctl daemon-reload
   ```

## Contributing

Contributions are welcome! Please open an issue or submit a pull request with your changes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Acknowledgments

Thanks to all contributors and the open-source community for their invaluable support.

---
