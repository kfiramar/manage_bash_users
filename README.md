# Linux User Management Script

A Bash script for managing users and groups in Linux systems with an interactive menu interface. This script provides a simple and safe way to perform common user management tasks such as creating/deleting users and groups.

## Features

- Create new users with customizable options
- Delete existing users and their home directories
- Create new groups
- Delete existing groups
- Interactive menu interface
- Built-in security checks
- Sudo privileges management
- Custom group assignment options

## Requirements

- Linux operating system
- Root privileges (sudo access)
- Bash shell

## Installation

1. Download the script:
```bash
wget https://raw.githubusercontent.com/kfiramar/manage_bash_users/main/user_management.sh
```

2. Make the script executable:
```bash
chmod +x user_management.sh
```

## Usage

Run the script with sudo privileges:

```bash
sudo ./user_management.sh
```

### Main Menu Options

1. **Create a new user**
   - Prompts for username
   - Creates user with home directory
   - Sets user password
   - Option to add sudo privileges
   - Alternative group assignment

2. **Delete a user**
   - Prompts for username
   - Confirmation required
   - Removes user and home directory

3. **Create a group**
   - Prompts for group name
   - Checks for existing groups

4. **Delete a group**
   - Prompts for group name
   - Confirmation required
   - Removes group from system

5. **Exit**
   - Safely exits the script

## Security Features

- Root privilege verification
- Existence checks for users and groups
- Confirmation prompts for destructive actions
- Error handling for all operations
- Safe password setting process

## Error Handling

The script includes comprehensive error handling for:
- Failed user creation
- Failed password setting
- Failed group operations
- Invalid inputs
- Insufficient privileges

## Examples

### Creating a New User with Sudo Privileges
```bash
$ sudo ./user_management.sh
1  # Select option 1
john  # Enter username
Password123  # Enter password
y  # Add sudo privileges
```

### Creating a New User without Sudo Privileges
```bash
$ sudo ./user_management.sh
1  # Select option 1
jane  # Enter username
Password456  # Enter password
n  # Don't add sudo privileges
users  # Add to regular users group
```

## Limitations

- Only works on Linux systems with standard user management commands
- Requires root privileges
- Does not support batch operations
- Limited to basic user/group management tasks

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a new Pull Request

## License

This script is released under the MIT License. See the LICENSE file for details.

## Author

Kfir Amar
kfira2002@gmail.com

## Version History

- 1.0.0 (2024-11-25)
  - Initial release
  - Basic user and group management features
  - Interactive menu interface

## Acknowledgments

- Inspired by Linux system administration best practices
- Thanks to the Linux user management community

## Support

For support, please open an issue in the GitHub repository or contact the author directly.

## Best Practices

When using this script:
- Always backup important system files before making user management changes
- Use strong passwords for new users
- Be cautious when deleting users and groups
- Keep track of sudo privilege assignments
- Regularly audit user and group assignments
