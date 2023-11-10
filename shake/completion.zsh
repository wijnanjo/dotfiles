function _shake {
    compadd $(./Shakefile _targets)
}

compdef _shake shake
compdef _shake Shakefile
