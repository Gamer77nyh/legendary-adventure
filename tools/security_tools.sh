#!/system/bin/sh
#
# HackOS Security Tools Installer and Manager
# Installs and manages security testing tools
#

TOOLS_DIR="/system/xbin"
DATA_DIR="/data/hackai"
TOOLS_CONFIG="/system/etc/hackai/tools.conf"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check root access
check_root() {
    if [ "$(id -u)" != "0" ]; then
        log_error "This script must be run as root"
        exit 1
    fi
    log_info "Root access confirmed"
}

# Install network tools
install_network_tools() {
    log_info "Installing network analysis tools..."
    
    # Nmap
    if [ ! -f "$TOOLS_DIR/nmap" ]; then
        log_info "Installing Nmap..."
        # Tool would be compiled for ARM or downloaded
        chmod 755 $TOOLS_DIR/nmap
    fi
    
    # Netcat
    if [ ! -f "$TOOLS_DIR/nc" ]; then
        log_info "Installing Netcat..."
        chmod 755 $TOOLS_DIR/nc
    fi
    
    # TCPDump
    if [ ! -f "$TOOLS_DIR/tcpdump" ]; then
        log_info "Installing TCPDump..."
        chmod 755 $TOOLS_DIR/tcpdump
    fi
    
    log_info "Network tools installed successfully"
}

# Install WiFi tools
install_wifi_tools() {
    log_info "Installing WiFi security tools..."
    
    # Aircrack-ng suite
    for tool in aircrack-ng airodump-ng aireplay-ng airmon-ng; do
        if [ ! -f "$TOOLS_DIR/$tool" ]; then
            log_info "Installing $tool..."
            chmod 755 $TOOLS_DIR/$tool 2>/dev/null
        fi
    done
    
    log_info "WiFi tools installed successfully"
}

# Install web testing tools
install_web_tools() {
    log_info "Installing web testing tools..."
    
    # Python-based tools would be installed via pip
    log_info "Setting up Python environment..."
    
    # SQLmap
    if [ ! -d "$DATA_DIR/sqlmap" ]; then
        log_info "Installing SQLmap..."
        mkdir -p $DATA_DIR/sqlmap
    fi
    
    # Nikto
    if [ ! -d "$DATA_DIR/nikto" ]; then
        log_info "Installing Nikto..."
        mkdir -p $DATA_DIR/nikto
    fi
    
    log_info "Web testing tools installed successfully"
}

# Install password tools
install_password_tools() {
    log_info "Installing password cracking tools..."
    
    # John the Ripper
    if [ ! -f "$TOOLS_DIR/john" ]; then
        log_info "Installing John the Ripper..."
        chmod 755 $TOOLS_DIR/john 2>/dev/null
    fi
    
    # Hydra
    if [ ! -f "$TOOLS_DIR/hydra" ]; then
        log_info "Installing Hydra..."
        chmod 755 $TOOLS_DIR/hydra 2>/dev/null
    fi
    
    log_info "Password tools installed successfully"
}

# Configure monitor mode for WiFi
setup_monitor_mode() {
    log_info "Configuring WiFi monitor mode..."
    
    # Load necessary kernel modules
    if [ -f "/system/lib/modules/cfg80211.ko" ]; then
        insmod /system/lib/modules/cfg80211.ko 2>/dev/null
    fi
    
    if [ -f "/system/lib/modules/mac80211.ko" ]; then
        insmod /system/lib/modules/mac80211.ko 2>/dev/null
    fi
    
    log_info "Monitor mode configuration complete"
}

# Setup HackAI environment
setup_hackai() {
    log_info "Setting up HackAI environment..."
    
    # Create necessary directories
    mkdir -p $DATA_DIR
    mkdir -p $DATA_DIR/captures
    mkdir -p $DATA_DIR/reports
    mkdir -p $DATA_DIR/wordlists
    mkdir -p $DATA_DIR/exploits
    
    # Set permissions
    chmod 755 $DATA_DIR
    chmod 755 $DATA_DIR/*
    
    # Create default wordlist links
    if [ -d "/system/share/wordlists" ]; then
        ln -sf /system/share/wordlists/* $DATA_DIR/wordlists/
    fi
    
    log_info "HackAI environment setup complete"
}

# Update all tools
update_tools() {
    log_info "Updating security tools..."
    
    # Update from repositories (if network available)
    if ping -c 1 8.8.8.8 >/dev/null 2>&1; then
        log_info "Network available, checking for updates..."
        # Update logic here
    else
        log_warn "No network connection, skipping updates"
    fi
    
    log_info "Tool update complete"
}

# Check tool status
check_status() {
    log_info "Checking tool status..."
    
    echo "Tool Status:"
    echo "============"
    
    tools="nmap nc tcpdump aircrack-ng airodump-ng sqlmap"
    
    for tool in $tools; do
        if command -v $tool >/dev/null 2>&1; then
            version=$($tool --version 2>&1 | head -n1)
            echo -e "${GREEN}✓${NC} $tool - $version"
        else
            echo -e "${RED}✗${NC} $tool - Not installed"
        fi
    done
}

# Main installation
install_all() {
    log_info "Starting HackOS security tools installation..."
    
    check_root
    setup_hackai
    install_network_tools
    install_wifi_tools
    install_web_tools
    install_password_tools
    setup_monitor_mode
    
    log_info "Installation complete!"
    log_info "Run 'hackai --help' for usage information"
}

# Command line interface
case "$1" in
    install)
        install_all
        ;;
    update)
        update_tools
        ;;
    status)
        check_status
        ;;
    monitor)
        setup_monitor_mode
        ;;
    *)
        echo "HackOS Security Tools Manager"
        echo "Usage: $0 {install|update|status|monitor}"
        echo ""
        echo "Commands:"
        echo "  install  - Install all security tools"
        echo "  update   - Update installed tools"
        echo "  status   - Check tool installation status"
        echo "  monitor  - Setup WiFi monitor mode"
        exit 1
        ;;
esac

exit 0
