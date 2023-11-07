# adapted from https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/autoenv/autoenv.plugin.zsh
# and https://tech.serhatteker.com/post/2022-04/automate-python-virtualenv/

# Initialization: activate autoenv or report its absence
() {
local d autoenv_dir install_locations
if ! type autoenv_init >/dev/null; then
  # Check if activate.sh is in $PATH
  if (( $+commands[activate.sh] )); then
    autoenv_dir="${commands[activate.sh]:h}"
  fi

  # Locate autoenv installation
  if [[ -z $autoenv_dir ]]; then
    install_locations=(
      ~/.autoenv
      ~/.local/bin
      /usr/local/opt/autoenv
      /opt/homebrew/opt/autoenv
      /usr/local/bin
      /usr/share/autoenv-git
      ~/Library/Python/bin
      .venv/bin
      venv/bin
      env/bin
      .env/bin
    )
    for d ( $install_locations ); do
      if [[ -e $d/activate || -e $d/activate.sh ]]; then
        autoenv_dir=$d
        break
      fi
    done
  fi

  # Look for Homebrew path as a last resort
  if [[ -z "$autoenv_dir" ]] && (( $+commands[brew] )); then
    d=$(brew --prefix)/opt/autoenv
    if [[ -e $d/activate || -e $d/activate.sh ]]; then
      autoenv_dir=$d
    fi
  fi

  # Complain if autoenv is not installed
  if [[ -z $autoenv_dir ]]; then
    cat <<END >&2
-------- AUTOENV ---------
Could not locate autoenv installation.
Please check if autoenv is correctly installed.
In the meantime the autoenv plugin is DISABLED.
--------------------------
END
    return 1
  fi
  # Load autoenv
  if [[ -e $autoenv_dir/activate ]]; then
    source $autoenv_dir/activate
  else
    source $autoenv_dir/activate.sh
  fi
fi
}
[[ $? != 0 ]] && return $?

# The use_env call below is a reusable command to activate/create a new Python
# virtualenv, requiring only a single declarative line of code in your .env files.
# It only performs an action if the requested virtualenv is not the current one.

  # Logical conditions:
# 0. If not already in virtualenv:
# 0.1. If virtualenv already exists activate it,
# 0.2. If not create it with global packages, update pip then activate it
# 1. If already in virtualenv: just give info
#
# Usage:
# Without arguments it will create virtualenv named `.venv` with `python3.10` version
# $ ve
# or for a specific python version
# $ ve python3.9
# or for a specific python version and environment name;
# $ ve python3.9 ./.venv-diff
ve() {
    local py=${1:-python}
    local venv="${2:-./.venv}"

    local bin="${venv}/bin/activate"

    # If not already in virtualenv
    # $VIRTUAL_ENV is being set from $venv/bin/activate script
	  if [ -z "${VIRTUAL_ENV}" ]; then
        if [ ! -d ${venv} ]; then
            echo "Creating and activating virtual environment ${venv}"
            ${py} -m venv ${venv} #--system-site-package
            # echo "export PYTHON=${py}" >> ${bin}    # overwrite ${python} on .zshenv
            source ${bin}
            echo "Upgrading pip"
            ${py} -m pip install --upgrade pip
        else
            echo "Virtual environment  ${venv} already exists, activating..."
            source ${bin}
        fi
    else
        echo "Already in a virtual environment!"
    fi
}