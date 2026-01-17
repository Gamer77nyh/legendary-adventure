# HackOS - Custom Android ROM for Tecno Pop 2F

A custom Android ROM built for penetration testing and security research with an integrated AI assistant.

## Overview

HackOS transforms your Tecno Pop 2F into a mobile hacking platform with:

- **Pre-installed Security Tools**: Comprehensive suite of penetration testing and security tools
- **AI Assistant**: Voice-activated AI assistant (HackAI) for hands-free operation
- **Root Access**: Full system access for advanced operations
- **Custom Kernel**: Optimized for security tools and performance
- **Privacy Features**: Enhanced privacy and security hardening

## Features

### Security Tools
- **Network Analysis**: Nmap, Netcat, Wireshark (tshark)
- **WiFi Security**: Aircrack-ng, Reaver, Pixie-Dust
- **Web Testing**: SQLmap, Nikto, DirBuster
- **Password Tools**: John the Ripper, Hashcat, Hydra
- **Exploitation**: Metasploit (msfvenom), BeEF
- **Forensics**: Binwalk, Foremost, Volatility
- **MITM Tools**: Ettercap, BetterCAP, SSLstrip
- **Social Engineering**: SET (Social Engineering Toolkit)

### AI Assistant (HackAI)
- Voice-activated commands
- Tool execution assistance
- Network scan interpretation
- Report generation
- Learning mode for security concepts
- Integration with all security tools

### System Features
- Based on LineageOS 14.1 (Android 7.1.2)
- Full root access via Magisk
- Custom recovery (TWRP)
- OTA updates support
- Battery optimization
- Performance tuning

## Device Specifications (Tecno Pop 2F)

- **Model**: Tecno Pop 2F (B1F)
- **SoC**: MediaTek MT6580 (Quad-core 1.3 GHz Cortex-A7)
- **GPU**: Mali-400 MP2
- **RAM**: 1GB
- **Storage**: 16GB (expandable)
- **Display**: 5.5" 480x960 (qHD)
- **Android Version**: 8.1 Oreo (Go Edition) → HackOS 7.1.2

## Prerequisites

### Hardware Requirements
- Tecno Pop 2F device
- USB cable
- Computer (Linux recommended, Windows/macOS supported)
- Minimum 8GB free disk space
- 100GB+ for building from source

### Software Requirements
- ADB and Fastboot tools
- Python 3.8+
- Java JDK 8
- Git
- Build essentials (for building from source)

## Installation

### Quick Installation (Pre-built ROM)

1. **Unlock Bootloader**
   ```bash
   adb reboot bootloader
   fastboot oem unlock
   ```

2. **Install Custom Recovery**
   ```bash
   fastboot flash recovery twrp-3.7.0-pop2f.img
   ```

3. **Flash ROM**
   ```bash
   adb reboot recovery
   # In TWRP: Wipe > Format Data
   # Then: Install > Select HackOS-pop2f-*.zip
   # Install > Select gapps-mini-*.zip (optional)
   # Reboot System
   ```

### Building from Source

See [`docs/BUILD.md`](docs/BUILD.md) for detailed build instructions.

## First Boot Setup

1. **Initial Configuration**
   - Select language and region
   - Skip/configure WiFi
   - Skip Google account (recommended)
   - Enable developer options

2. **Grant Root Access**
   - Open Magisk Manager
   - Grant root to HackAI and security tools

3. **Configure AI Assistant**
   - Open HackAI app
   - Complete voice training
   - Set activation phrase ("Hey HackAI")
   - Configure tool preferences

4. **Update Tools**
   ```bash
   hackai update-all
   ```

## Usage

### AI Assistant Commands

```
"Hey HackAI, scan network for devices"
"Hey HackAI, crack WiFi password"
"Hey HackAI, run SQL injection test on [target]"
"Hey HackAI, generate reverse shell"
"Hey HackAI, analyze packet capture"
```

### Terminal Access

```bash
# Launch HackOS terminal
hackai terminal

# Run tools directly
nmap -sV 192.168.1.0/24
sqlmap -u "http://target.com?id=1" --batch
aircrack-ng capture.cap -w wordlist.txt
```

### Tool Management

```bash
# Update all tools
hackai update-all

# Install additional tools
hackai install [tool-name]

# List available tools
hackai list-tools

# Check tool status
hackai status
```

## Documentation

- [Build Guide](docs/BUILD.md) - Complete guide for building from source
- [Device Configuration](docs/DEVICE_CONFIG.md) - Device-specific setup
- [Tool Reference](docs/TOOLS.md) - Complete security tools documentation
- [AI Assistant Guide](docs/AI_ASSISTANT.md) - HackAI configuration and usage
- [Troubleshooting](docs/TROUBLESHOOTING.md) - Common issues and solutions
- [Development](docs/DEVELOPMENT.md) - Contributing and development guide

## Security & Legal

### Important Disclaimers

⚠️ **WARNING**: This ROM is designed for **authorized security testing only**.

- Only use on networks and systems you own or have explicit permission to test
- Unauthorized access to computer systems is illegal
- Use responsibly and ethically
- Follow all applicable laws and regulations
- The developers are not responsible for misuse

### Privacy & Security

- All AI processing can be configured for offline operation
- No telemetry or data collection
- Optional encrypted storage
- Secure boot chain (where hardware supports)
- Regular security updates

## Support

- **Issues**: [GitHub Issues](https://github.com/Gamer77nyh/legendary-adventure/issues)
- **Discussions**: [GitHub Discussions](https://github.com/Gamer77nyh/legendary-adventure/discussions)
- **Wiki**: [Project Wiki](https://github.com/Gamer77nyh/legendary-adventure/wiki)

## Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details.

## License

This project is licensed under the Apache License 2.0 - see [LICENSE](LICENSE) for details.

## Acknowledgments

- LineageOS Team
- AOSP Project
- Kali NetHunter Project
- Magisk Developer
- All open-source security tool developers

## Roadmap

- [ ] Initial release (v1.0)
- [ ] Enhanced AI capabilities
- [ ] Support for more devices
- [ ] Advanced exploit frameworks
- [ ] Cloud sync for reports
- [ ] Team collaboration features
- [ ] Advanced kernel hardening

## Disclaimer

This is an educational and research project. Use it responsibly and legally. The maintainers are not responsible for any misuse or damage caused by this software.

---

**Version**: 1.0.0-beta  
**Last Updated**: 2026-01-17  
**Status**: Active Development
