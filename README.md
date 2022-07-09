# vim-fourmolu
This plugin provides an interface for https://github.com/fourmolu/fourmolu and https://github.com/tweag/ormolu in Vim

# Usage
The default behavior of this plugin formats a file when saving, but the `FourmoluFmt` command can be used to format source manually. Ranges are supported when using `FourmoluFmt` too. The plugin provides additional commands to enable, disable, or toggle formatting when saving a file using `FourmoluWriteOn`, `FourmoluWriteOff`, and `FourmoluWriteToggle`.

# Configuration
If you only want to format content manually setting the following variable to 0 will disable automatic formatting when saving your file:
```VimL
let g:fourmolu_write = 0
```
By default the plugin expects to find a fourmolu executable in your PATH but this can be changed by setting:
```VimL
let g:fourmolu_executable = "ormolu"
```

Any modifications to fourmolu's formatting should be set in fourmolu.yaml
