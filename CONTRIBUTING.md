# Contributing to HackOS

Thank you for your interest in contributing to HackOS! This document provides guidelines and instructions for contributing.

## Code of Conduct

### Our Pledge

We are committed to providing a welcoming and inclusive environment for all contributors, regardless of experience level, background, or identity.

### Expected Behavior

- Be respectful and professional
- Accept constructive criticism gracefully
- Focus on what is best for the community
- Show empathy towards others

### Unacceptable Behavior

- Harassment, discrimination, or offensive comments
- Personal attacks or trolling
- Publishing others' private information
- Other unprofessional conduct

## How to Contribute

### Reporting Bugs

Before creating a bug report:
1. Check existing issues to avoid duplicates
2. Verify the bug on the latest version
3. Collect relevant information (logs, device info, steps to reproduce)

When creating a bug report, include:
- Clear, descriptive title
- Detailed description of the issue
- Steps to reproduce
- Expected vs actual behavior
- Screenshots or logs
- Device information
- ROM version

### Suggesting Features

Feature requests are welcome! Please:
1. Check if the feature already exists or is planned
2. Clearly describe the feature and its benefits
3. Provide use cases
4. Consider implementation complexity

### Pull Requests

#### Before Submitting

1. **Fork the repository**
   ```bash
   git clone https://github.com/Gamer77nyh/legendary-adventure.git
   cd legendary-adventure
   ```

2. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make your changes**
   - Follow coding standards
   - Write clear commit messages
   - Test your changes thoroughly
   - Update documentation as needed

4. **Commit your changes**
   ```bash
   git add .
   git commit -m 'feat: add amazing feature'
   ```

5. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

6. **Open a Pull Request**
   - Use a clear, descriptive title
   - Reference any related issues
   - Describe your changes in detail
   - Include testing performed

#### Pull Request Guidelines

- **One feature per PR**: Keep PRs focused on a single feature or fix
- **Follow conventions**: Use existing code style and patterns
- **Write tests**: Include tests for new features
- **Update docs**: Update relevant documentation
- **Sign commits**: Use GPG signing for commits (recommended)
- **Pass CI**: Ensure all CI checks pass

## Coding Standards

### General Principles

- Write clean, readable, maintainable code
- Follow DRY (Don't Repeat Yourself)
- Keep functions small and focused
- Use meaningful variable and function names
- Comment complex logic
- Optimize for readability first, performance second

### Language-Specific Guidelines

#### Java (Android Apps)

```java
// Class names: PascalCase
public class CommandProcessor {
    
    // Constants: UPPER_SNAKE_CASE
    private static final String TAG = "HackAI";
    
    // Variables: camelCase
    private Context context;
    
    // Methods: camelCase
    public String processCommand(String input) {
        // Implementation
    }
}
```

#### Shell Scripts

```bash
#!/bin/bash
# Use bash shebang
# Functions: snake_case

install_tools