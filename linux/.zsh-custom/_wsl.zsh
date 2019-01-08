# These customizations are only added when running under Windows Subsystem for Linux
# Under WSL, /proc/sys/kernel/osrelease looks something like: 4.4.0-43-Microsoft

if [ -d /proc/sys/kernel ] && grep -q Microsoft /proc/sys/kernel/osrelease; then

  # Aliases
  alias explorer="explorer.exe"


  function wslexpose() {
    echo "@echo off\r\nwsl.exe $1 %*" > /mnt/c/tools/wsl/$1.bat
  }



  # Convert the scratch path on Linux to a Windows path for VS Code
  function scratch-hook() {
    local FILE=$1
    echo $(wslpath -w $(readlink -f $FILE) | sed -e 's/\\/\\\\\\\\/g')
  }

fi
