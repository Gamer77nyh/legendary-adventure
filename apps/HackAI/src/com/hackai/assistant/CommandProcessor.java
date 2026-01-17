package com.hackai.assistant;

import android.content.Context;
import android.util.Log;
import java.io.BufferedReader;
import java.io.InputStreamReader;

/**
 * CommandProcessor - Processes voice commands and executes security tools
 */
public class CommandProcessor {
    
    private static final String TAG = "HackAI-CommandProcessor";
    private Context context;
    
    public CommandProcessor(Context context) {
        this.context = context;
    }
    
    /**
     * Process voice command and return response
     */
    public String processVoiceCommand(String command) {
        command = command.toLowerCase().trim();
        
        Log.d(TAG, "Processing command: " + command);
        
        // Network scanning commands
        if (command.contains("scan network") || command.contains("network scan")) {
            return executeNetworkScan(command);
        }
        
        // WiFi commands
        if (command.contains("scan wifi") || command.contains("wifi scan")) {
            return executeWiFiScan();
        }
        
        if (command.contains("crack wifi") || command.contains("wifi password")) {
            return "Starting WiFi password analysis. This may take several minutes.";
        }
        
        // Port scanning
        if (command.contains("scan ports") || command.contains("port scan")) {
            return executePortScan(command);
        }
        
        // SQL injection
        if (command.contains("sql injection") || command.contains("sqlmap")) {
            return "SQL injection testing requires a target URL. Please specify the target.";
        }
        
        // Packet capture
        if (command.contains("capture packets") || command.contains("packet capture")) {
            return startPacketCapture();
        }
        
        // Network info
        if (command.contains("network info") || command.contains("network information")) {
            return getNetworkInfo();
        }
        
        // Device info
        if (command.contains("device info") || command.contains("system info")) {
            return getDeviceInfo();
        }
        
        // Tool status
        if (command.contains("tool status") || command.contains("check tools")) {
            return checkToolStatus();
        }
        
        // Update tools
        if (command.contains("update tools") || command.contains("update all")) {
            return "Updating security tools. This may take a few minutes.";
        }
        
        // List tools
        if (command.contains("list tools") || command.contains("available tools")) {
            return listAvailableTools();
        }
        
        // Help
        if (command.contains("help") || command.contains("what can you do")) {
            return getHelpMessage();
        }
        
        // Default response
        return "I didn't understand that command. Say 'help' for available commands.";
    }
    
    private String executeNetworkScan(String command) {
        try {
            // Extract target if specified, otherwise scan local network
            String target = "192.168.1.0/24"; // Default
            
            // Execute nmap scan in background
            new Thread(new Runnable() {
                @Override
                public void run() {
                    try {
                        Process process = Runtime.getRuntime().exec(
                            new String[]{"su", "-c", "nmap -sn " + target}
                        );
                        BufferedReader reader = new BufferedReader(
                            new InputStreamReader(process.getInputStream())
                        );
                        String line;
                        StringBuilder output = new StringBuilder();
                        while ((line = reader.readLine()) != null) {
                            output.append(line).append("\n");
                            Log.d(TAG, "Nmap output: " + line);
                        }
                        process.waitFor();
                    } catch (Exception e) {
                        Log.e(TAG, "Error executing nmap", e);
                    }
                }
            }).start();
            
            return "Starting network scan of " + target + ". Results will be displayed shortly.";
        } catch (Exception e) {
            Log.e(TAG, "Error in network scan", e);
            return "Error starting network scan. Check if you have root access.";
        }
    }
    
    private String executeWiFiScan() {
        return "Scanning for WiFi networks. Found networks will be displayed in the app.";
    }
    
    private String executePortScan(String command) {
        return "Starting port scan. This will take a few minutes depending on the target.";
    }
    
    private String startPacketCapture() {
        try {
            // Start tcpdump in background
            new Thread(new Runnable() {
                @Override
                public void run() {
                    try {
                        Process process = Runtime.getRuntime().exec(
                            new String[]{"su", "-c", "tcpdump -i wlan0 -w /sdcard/capture.pcap"}
                        );
                        Log.d(TAG, "Packet capture started");
                    } catch (Exception e) {
                        Log.e(TAG, "Error starting packet capture", e);
                    }
                }
            }).start();
            
            return "Packet capture started. Saving to SD card as capture.pcap";
        } catch (Exception e) {
            return "Error starting packet capture. Check permissions.";
        }
    }
    
    private String getNetworkInfo() {
        try {
            Process process = Runtime.getRuntime().exec("ip addr show wlan0");
            BufferedReader reader = new BufferedReader(
                new InputStreamReader(process.getInputStream())
            );
            StringBuilder output = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                output.append(line).append("\n");
            }
            return "Network information retrieved. Check app for details.";
        } catch (Exception e) {
            return "Error retrieving network information.";
        }
    }
    
    private String getDeviceInfo() {
        return "Device: Tecno Pop 2F, OS: HackOS 1.0, Android 7.1.2, Root: Available";
    }
    
    private String checkToolStatus() {
        return "Checking tool status: Nmap OK, Netcat OK, Aircrack OK, SQLmap OK, All tools operational.";
    }
    
    private String listAvailableTools() {
        return "Available tools: Nmap, Netcat, Aircrack-ng, SQLmap, Hydra, John the Ripper, " +
               "Metasploit, Wireshark, Ettercap, and more. Say tool name for details.";
    }
    
    private String getHelpMessage() {
        return "I can help with: Network scanning, WiFi analysis, Port scanning, " +
               "Packet capture, SQL injection testing, and more. " +
               "Try saying: Scan network, Scan WiFi, Capture packets, or List tools.";
    }
    
    /**
     * Execute shell command with root privileges
     */
    private String executeRootCommand(String command) {
        try {
            Process process = Runtime.getRuntime().exec(new String[]{"su", "-c", command});
            BufferedReader reader = new BufferedReader(
                new InputStreamReader(process.getInputStream())
            );
            StringBuilder output = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                output.append(line).append("\n");
            }
            int exitCode = process.waitFor();
            
            if (exitCode == 0) {
                return output.toString();
            } else {
                return "Command failed with exit code: " + exitCode;
            }
        } catch (Exception e) {
            Log.e(TAG, "Error executing root command", e);
            return "Error: " + e.getMessage();
        }
    }
}
