#!/bin/sh

# jqの存在を確認
if ! command -v jq >/dev/null 2>&1; then
    echo "jq is not installed. Trying to install it now..."

    # OSを判別
    if [ "$(uname)" == "Darwin" ]; then
        # MacOS
        brew install jq
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        # Linux
        if [ -f /etc/os-release ]; then
            . /etc/os-release
            OS=$NAME
        else
            echo "Cannot determine the distribution. Please install jq manually."
            exit 1
        fi

        case $OS in
            "Ubuntu"*)
                sudo apt-get update
                sudo apt-get install -y jq
                ;;
            "Red Hat Enterprise Linux"*)
                sudo yum install -y jq
                ;;
            "CentOS"*)
                sudo yum install -y jq
                ;;
            *)
                echo "This Linux distribution is not supported in this script. Please install jq manually."
                exit 1
                ;;
        esac
    else
        echo "This OS is not supported in this script. Please install jq manually."
        exit 1
    fi
else
    echo "jq is already installed."
fi


chmod +x wait-for-it.sh

cd ./node_backend
pwd
chmod +x node_ini.sh
sh node_ini.sh

cd ..
pwd

cd ./react_frontend
pwd
chmod +x react_ini.sh
sh react_ini.sh