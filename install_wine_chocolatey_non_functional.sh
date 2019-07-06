#!/bin/bash
./install_lib_bash.sh

function include_dependencies {
    local my_dir="$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )"  # this gives the full path, even for sourced scripts
    source "${my_dir}/lib_bash/lib_color.sh"
    source "${my_dir}/lib_bash/lib_retry.sh"
    source "${my_dir}/lib_bash/lib_helpers.sh"
    source "${my_dir}/lib_wine.sh"
}
include_dependencies  # me need to do that via a function to have local scope of my_dir

wine_drive_c_dir=${WINEPREFIX}/drive_c
powershell_install_dir=${wine_drive_c_dir}/windows/system32/powershell

cd ${powershell_install_dir}
# wine ${powershell_install_dir}/pwsh -ExecutionPolicy unrestricted get-executionpolicy
# wine ${powershell_install_dir}/pwsh.exe -NoProfile -InputFormat None -ExecutionPolicy unrestricted -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
# wine ${powershell_install_dir}/pwsh.exe -NoProfile -ExecutionPolicy Bypass -Command "((new-object net.webclient).DownloadFile('https://chocolatey.org/install.ps1','install.ps1'))"
wget --no-check-certificate -O install.ps1 https://chocolatey.org/install.ps1
wine ${powershell_install_dir}/pwsh.exe -NoProfile -ExecutionPolicy Bypass -Command "& 'install.ps1' %*"