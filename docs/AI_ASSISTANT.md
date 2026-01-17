# HackAI - Voice-Activated AI Assistant Guide

Complete guide for using the HackAI voice-activated AI assistant for security testing.

## Overview

HackAI is an intelligent voice assistant designed specifically for penetration testing and security research. It provides hands-free operation of security tools, command execution, and intelligent analysis of results.

## Features

- **Voice Activation**: Hotword detection ("Hey HackAI")
- **Natural Language Processing**: Understand security commands in plain English
- **Tool Integration**: Direct integration with all security tools
- **Offline Operation**: No internet required for basic functionality
- **Result Analysis**: AI-powered analysis of scan results
- **Report Generation**: Automatic report creation
- **Learning Mode**: Educational explanations of security concepts

## Initial Setup

### 1. First Launch

```bash
# Launch HackAI from app drawer or terminal
am start -n com.hackai.assistant/.MainActivity
```

### 2. Voice Training

Complete the voice training to improve recognition accuracy:

1. Open HackAI app
2. Go to Settings → Voice Training
3. Repeat the phrases shown
4. Test recognition with sample commands

### 3. Configure Activation Phrase

Default: "Hey HackAI"

To customize:
1. Settings → Activation Phrase
2. Choose from presets or create custom
3. Train the new phrase

### 4. Grant Permissions

Required permissions:
- Microphone (for voice input)
- Root access (for tool execution)
- Storage (for saving results)
- Location (for WiFi scanning)
- Network (for online features)

## Voice Commands

### Network Scanning

```
"Hey HackAI, scan the network"
"Hey HackAI, scan network for devices"
"Hey HackAI, discover hosts on 192.168.1.0/24"
"Hey HackAI, ping sweep the local network"
```

### Port Scanning

```
"Hey HackAI, scan ports on 192.168.1.1"
"Hey HackAI, scan all ports on target"
"Hey HackAI, quick scan 192.168.1.100"
"Hey HackAI, scan common ports"
```

### WiFi Analysis

```
"Hey HackAI, scan for WiFi networks"
"Hey HackAI, scan WiFi"
"Hey HackAI, list wireless networks"
"Hey HackAI, show available networks"
```

### WiFi Security Testing

```
"Hey HackAI, test WiFi security"
"Hey HackAI, crack WiFi password"
"Hey HackAI, WPS attack on [SSID]"
"Hey HackAI, capture handshake"
```

### Web Application Testing

```
"Hey HackAI, test website security"
"Hey HackAI, scan example.com for vulnerabilities"
"Hey HackAI, SQL injection test on [URL]"
"Hey HackAI, directory brute force [URL]"
```

### Packet Analysis

```
"Hey HackAI, capture packets"
"Hey HackAI, start packet capture"
"Hey HackAI, analyze captured packets"
"Hey HackAI, show packet summary"
```

### Password Testing

```
"Hey HackAI, crack password hash"
"Hey HackAI, brute force SSH on [target]"
"Hey HackAI, dictionary attack [service]"
```

### Information Gathering

```
"Hey HackAI, get network information"
"Hey HackAI, show device info"
"Hey HackAI, what's my IP address"
"Hey HackAI, show interface details"
```

### Tool Management

```
"Hey HackAI, list available tools"
"Hey HackAI, update all tools"
"Hey HackAI, check tool status"
"Hey HackAI, install [tool name]"
```

### Help & Learning

```
"Hey HackAI, help"
"Hey HackAI, what can you do"
"Hey HackAI, explain SQL injection"
"Hey HackAI, how do I use nmap"
```

## Advanced Features

### Custom Commands

Create custom voice commands:

1. Settings → Custom Commands
2. Add New Command
3. Define trigger phrase
4. Define action (shell command or tool)
5. Save and test

Example:
```
Trigger: "quick recon"
Action: nmap -sV -O --top-ports 100 $TARGET
```

### Command Chains

Execute multiple commands in sequence:

```
"Hey HackAI, scan network then port scan all hosts"
"Hey HackAI, capture handshake then crack with wordlist"
```

### Variable Substitution

Use variables in commands:

- `$TARGET` - Current target
- `$NETWORK` - Current network
- `$INTERFACE` - Active network interface
- `$OUTPUT` - Output directory

### Automated Workflows

Create automated security testing workflows:

1. Settings → Workflows
2. Create New Workflow
3. Add steps
4. Configure triggers
5. Activate

Example Workflow:
```yaml
name: "Quick Network Assessment"
steps:
  - Network discovery
  - Port scanning
  - Service enumeration
  - Vulnerability scan
  - Report generation
```

## Terminal Integration

Use HackAI from terminal:

```bash
# Basic command
hackai "scan network"

# With parameters
hackai scan --target 192.168.1.0/24

# Interactive mode
hackai -i

# Voice mode
hackai --voice
```

### CLI Options

```
hackai [options] [command]

Options:
  -v, --voice      Voice mode
  -i, --interactive    Interactive mode
  -t, --target TARGET  Set target
  -o, --output DIR     Output directory
  -q, --quiet      Quiet mode
  -h, --help       Show help

Commands:
  scan             Network scanning
  wifi             WiFi operations
  web              Web testing
  crack            Password cracking
  capture          Packet capture
  analyze          Result analysis
  report           Generate report
  update           Update tools
  status           Show status
```

## Result Analysis

HackAI automatically analyzes results and provides:

### Vulnerability Assessment

- Severity rating
- Exploitability score
- Remediation suggestions
- Related CVEs

### Network Mapping

- Network topology
- Host identification
- Service fingerprinting
- OS detection

### Report Generation

Automatic report formats:
- HTML
- PDF
- Markdown
- JSON
- XML

Access reports:
```bash
# View latest report
hackai report --view

# Generate custom report
hackai report --format pdf --output /sdcard/reports/
```

## Offline vs Online Mode

### Offline Mode (Default)

- All processing on-device
- No data sent to cloud
- Limited to pre-trained models
- Privacy-focused

### Online Mode

Enable for enhanced features:
- Advanced NLP
- Latest vulnerability data
- Cloud-based analysis
- Tool updates

Configure:
```
Settings → Online Features → Enable
```

## Privacy & Security

### Data Collection

HackAI respects privacy:
- No voice data stored by default
- No telemetry sent
- All processing local
- Optional cloud features

### Secure Storage

- Commands encrypted at rest
- Results encrypted (optional)
- Secure credential storage
- No logging of sensitive data

### Audit Log

View all executed commands:
```bash
hackai audit --show
hackai audit --export
```

## Troubleshooting

### Voice Recognition Issues

**Problem**: Commands not recognized

Solutions:
- Re-train voice model
- Check microphone permissions
- Reduce background noise
- Adjust sensitivity in settings
- Use wired headset microphone

### Tool Execution Failures

**Problem**: Commands don't execute

Solutions:
- Check root access: `su`
- Verify tool installation: `hackai status`
- Check permissions
- Review logs: `logcat | grep HackAI`

### Network Errors

**Problem**: Network operations fail

Solutions:
- Check WiFi connection
- Verify network interface: `ip link`
- Check monitor mode: `iwconfig`
- Restart network service

### Performance Issues

**Problem**: Slow response

Solutions:
- Close background apps
- Clear cache: Settings → Clear Cache
- Reduce voice buffer size
- Disable online features

## Best Practices

### 1. Clear Communication

- Speak clearly and at normal pace
- Use complete sentences
- Specify targets explicitly
- Confirm critical actions

### 2. Security Awareness

- Only test authorized targets
- Use in controlled environment
- Document all activities
- Follow legal requirements

### 3. Efficiency

- Learn common commands
- Use shortcuts for frequent tasks
- Create custom workflows
- Leverage command history

### 4. Organization

- Organize results by project
- Use meaningful target names
- Regular backup of data
- Tag and categorize scans

## Advanced Configuration

### config.yaml

Located at `/data/hackai/config.yaml`:

```yaml
# Voice Settings
voice:
  activation_phrase: "Hey HackAI"
  confidence_threshold: 0.8
  timeout: 5000
  language: en-US

# Tool Settings
tools:
  auto_update: false
  parallel_execution: true
  timeout: 300

# Output Settings
output:
  default_format: text
  save_raw: true
  auto_report: true
  directory: /sdcard/hackai/

# Network Settings
network:
  default_interface: wlan0
  monitor_mode: auto
  packet_buffer: 1000

# Privacy Settings
privacy:
  offline_mode: true
  save_commands: true
  encrypt_results: false
  anonymize_reports: true
```

## Integration with External Tools

### Metasploit Integration

```
"Hey HackAI, launch Metasploit console"
"Hey HackAI, search exploit for [service]"
"Hey HackAI, generate payload"
```

### Burp Suite Integration

```
"Hey HackAI, start proxy on port 8080"
"Hey HackAI, analyze proxy history"
```

### Custom Tool Integration

Add custom tools:
1. Place tool in `/data/hackai/tools/`
2. Create wrapper script
3. Register with HackAI
4. Define voice commands

## Resources

- [Command Reference](TOOLS.md)
- [Troubleshooting Guide](TROUBLESHOOTING.md)
- [API Documentation](API.md)
- [GitHub Repository](https://github.com/Gamer77nyh/legendary-adventure)

## Support

- Report issues: [GitHub Issues](https://github.com/Gamer77nyh/legendary-adventure/issues)
- Discussions: [GitHub Discussions](https://github.com/Gamer77nyh/legendary-adventure/discussions)
- Email: support@hackai.dev

---

**Remember**: Use responsibly and only on authorized systems!
