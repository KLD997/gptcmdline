#!/bin/sh
  
# Use to check if a command is installed
command_exists() {
    command -v "$1" &> /dev/null
}

# Check if jq is installed, and if not, install it
if ! command_exists "jq"; then
    echo "jq is not installed. Installing now..."

    # FreeBSD doas
    if command_exists "pkg" && command_exists "doas"; then
        doas pkg update -y
        doas pkg install jq
    else
		#FreeBSD sudo
        if command_exists "pkg" && command_exists "sudo";then
            sudo pkg update -y
            sudo pkg install jq
        else
            # Debian doas
        	if command_exists "apt" && command_exists "doas"; then
                doas apt update -y
                doas apt install jq
        	else
                # Debian sudo
                if command_exists "apt" && command_exists "sudo";then
                    sudo apt update -y
                    sudo apt install jq
                else
            	    echo "pkg or apt not found. Please install jq manually or using an appropriate package manager for your system."
            	    exit 1
                fi
            fi
        fi
    fi
fi

# Check if ZSH is installed, and if not install it
if ! command_exists "zsh";then
    echo "zsh is not installed. Installing now..."

    # FreeBSD doas
    if command_exists "pkg" && command_exists "doas"; then
        doas pkg update -y
        doas pkg install zsh
    else
		#FreeBSD sudo
        if command_exists "pkg" && command_exists "sudo";then
            sudo pkg update -y
            sudo pkg install zsh
        else
            # Debian doas
        	if command_exists "apt" && command_exists "doas"; then
                doas apt update -y
                doas apt install zsh
        	else
                # Debian sudo
                if command_exists "apt" && command_exists "sudo";then
                    sudo apt update -y
                    sudo apt install zsh
                else
            	    echo "pkg or apt not found. Please install jq manually or using an appropriate package manager for your system."
            	    exit 1
                fi
            fi
        fi
    fi
fi


# Make orb executable
chmod +x orb

# Move orb to /usr/bin
if command_exists "doas";then
    doas cp orb /usr/bin/
else
    if command_exists "sudo";then
        sudo cp orb /usr/bin/
    fi
fi

# Create local .orb and move files
mkdir $HOME/.orb/
mv orb /$HOME/.orb/
mv LICENSE $HOME/.orb/
mv README.md $HOME/.orb/
mv install.sh $HOME/.orb/
