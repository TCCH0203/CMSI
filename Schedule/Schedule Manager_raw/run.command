#!/bin/bash
cd "$(dirname "$0")"

# ============================
# FIND PYTHON
# ============================
if command -v python3 &>/dev/null; then
    PYTHON=python3
elif command -v python &>/dev/null; then
    PYTHON=python
else
    echo ""
    echo "Python not found. Attempting to install automatically..."

    # Try Homebrew
    if command -v brew &>/dev/null; then
        echo "Installing Python via Homebrew..."
        brew install python
    else
        echo "Homebrew not found. Installing Homebrew first..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        # Add homebrew to PATH for this session
        if [ -f "/opt/homebrew/bin/brew" ]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        elif [ -f "/usr/local/bin/brew" ]; then
            eval "$(/usr/local/bin/brew shellenv)"
        fi

        if command -v brew &>/dev/null; then
            echo "Installing Python via Homebrew..."
            brew install python
        else
            echo ""
            echo "Could not install Homebrew automatically."
            echo "Please install Python manually from: https://www.python.org/downloads/"
            echo ""
            read -p "Press Enter to exit..."
            exit 1
        fi
    fi

    # Re-check after install
    if command -v python3 &>/dev/null; then
        PYTHON=python3
    elif command -v python &>/dev/null; then
        PYTHON=python
    else
        echo ""
        echo "Python was installed but could not be detected."
        echo "Please close this window and run run.command again."
        read -p "Press Enter to exit..."
        exit 1
    fi
fi

echo "Python found: $($PYTHON --version)"

# ============================
# FIND / INSTALL PIP
# ============================
$PYTHON -m pip --version &>/dev/null
if [ $? -ne 0 ]; then
    echo "pip not found. Installing pip..."
    $PYTHON -m ensurepip --upgrade 2>/dev/null

    # If ensurepip fails, try get-pip.py
    if [ $? -ne 0 ]; then
        echo "Downloading get-pip.py..."
        curl -fsSL https://bootstrap.pypa.io/get-pip.py -o /tmp/get-pip.py
        $PYTHON /tmp/get-pip.py
    fi
fi

# ============================
# INSTALL LIBRARIES
# ============================
echo "Installing required libraries..."
$PYTHON -m pip install flask docxtpl pandas openpyxl python-docx

# ============================
# LAUNCH APP
# ============================
echo ""
echo "Starting app..."
$PYTHON app.py
