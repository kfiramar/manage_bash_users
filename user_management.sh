#!/bin/bash

# Ensure the script is run as root
ensure_root() {
    if [ "$(id -u)" != "0" ]; then
        echo "This script must be run as root. Please use sudo or log in as the root user." 1>&2
        main_menu
    fi
}

# Function to create a new user
create_user() {
    read -p "Enter the username: " username
    # Check if user already exists
    if getent passwd "$username" > /dev/null 2>&1; then
        echo "User $username already exists!"
        main_menu
    fi

    # Create the user with options
    useradd -m -c "$username" -s "/bin/bash" "$username"
    if [ $? -ne 0 ]; then
        echo "Failed to create user $username."
        main_menu
    fi

    # Set the user password
    echo "Set the password for $username:"
    passwd "$username"
    if [ $? -ne 0 ]; then
        echo "Failed to set password for $username."
        main_menu
    fi

    # Ask if the user should have sudo privileges
    read -p "Should this user have sudo privileges? (y/n): " addsudo
    if [[ "$addsudo" == "y" ]]; then
        usermod -aG sudo "$username"
        if [ $? -ne 0 ]; then
            echo "Failed to add $username to sudo group."
            main_menu
        fi
    else
        read -p "Enter the group to add the user to: " group
        usermod -aG "$group" "$username"
        if [ $? -ne 0 ]; then
            echo "Failed to add $username to $group group."
            main_menu
        fi
    fi
    echo "User $username added successfully."
}

# Function to delete a user
delete_user() {
    read -p "Enter the username to delete: " username
    if getent passwd "$username" > /dev/null 2>&1; then
        read -p "Are you sure you want to delete $username? (y/n): " confirm
        if [[ "$confirm" == "y" ]]; then
            userdel -r "$username"
            if [ $? -ne 0 ]; then
                echo "Failed to delete $username."
                main_menu
            fi
            echo "User $username has been deleted along with their home directory."
        else
            echo "User deletion cancelled."
        fi
    else
        echo "User $username does not exist!"
    fi
}

# Function to create a group
create_group() {
    read -p "Enter the group name to create: " groupname
    if getent group "$groupname" > /dev/null 2>&1; then
        echo "Group $groupname already exists!"
    else
        groupadd "$groupname"
        if [ $? -ne 0 ]; then
            echo "Failed to create group $groupname."
            main_menu
        fi
        echo "Group $groupname created successfully."
    fi
}

# Function to delete a group
delete_group() {
    read -p "Enter the group name to delete: " groupname
    if getent group "$groupname" > /dev/null 2>&1; then
        read -p "Are you sure you want to delete the group $groupname? (y/n): " confirm
        if [[ "$confirm" == "y" ]]; then
            groupdel "$groupname"
            if [ $? -ne 0 ]; then
                echo "Failed to delete group $groupname."
                main_menu
            fi
            echo "Group $groupname has been deleted."
        else
            echo "Group deletion cancelled."
        fi
    else
        echo "Group $groupname does not exist!"
    fi
}

# Main menu function
main_menu() {
    ensure_root
    echo "User Management Script"
    echo "1. Create a new user"
    echo "2. Delete a user"
    echo "3. Create a group"
    echo "4. Delete a group"
    echo "5. Exit"
    read -p "Select an option: " option
    case $option in
        1) create_user ;;
        2) delete_user ;;
        3) create_group ;;
        4) delete_group ;;
        5) exit 0 ;;
        *) echo "Invalid option selected." ;;
    esac
    main_menu  # Always return to the main menu
}

# Run the main menu
main_menu
