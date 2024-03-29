# neovim_config
## Sources
Good resources:
- directory structure: https://www.reddit.com/r/neovim/comments/kwvuje/dumb_question_but_how_do_you_structure_the_neovim/
- rust and nvim: https://rsdlt.github.io/posts/rust-nvim-ide-guide-walkthrough-development-debug/
- rust analyzer set up: https://rust-analyzer.github.io/manual.html#vimneovim
- rust-tools debugging info: https://github.com/simrat39/rust-tools.nvim/wiki/debugging 
- nvim-dap process attachment set up: https://github.com/mfussenegger/nvim-dap/wiki/Cookbook
- CodeLLDB: https://marketplace.visualstudio.com/items?itemName=vadimcn.vscode-lldb

## Directory Structure
```BASH
➜  nvim pwd
/Users/felixding/.config/nvim
➜  nvim tree -L 3 -I autoload/ -I plugged/
.
├── README.md
├── after
│   └── plugin <-- this constains modules that would be loaded _after_ initial set up is done _automatically_
│       ├── codeium-conf.lua
│       ├── dap-conf.lua
│       ├── goto-preview-conf.lua
│       ├── harpoon-conf.lua
│       ├── lsp-conf.lua
│       ├── neovim-tree.lua
│       ├── nvim-autopairs.lua
│       ├── nvim-treesitter-conf.lua
│       └── telescope-conf.lua
├── init.lua
├── lua
│   └── fd
│       ├── init.lua
│       ├── plugin-conf <-- for modules that would be used / referenced in after/plugin/
│       └── plugins.lua <-- for plugin declarations
├── mappings.vim
└── settings.vim
```

## Lsp set up
Neovim's lsp doc: https://neovim.io/doc/user/lsp.html

The summary is roughly the following:
- nvim supports LSP natively, which means it acts as a client to LSP servers (entities that understands the language that is currently attached i.e. they know how to lex and parse)
- LSP facilitates features like go-to-definition, find-references, hover, completion, rename, format, refactor, etc., using semantic whole-project analysis (unlike ctags).

Note that Nvim supports lsp natively and the package [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) is a plugin that allows you to easily configure the feature. 

#### Setting Up Language Server
Setting it up with lspconfig: https://neovim.io/doc/user/lsp.html#lsp-handler-configuration

For some explanation on lspconfig and its structure: https://github.com/neovim/nvim-lspconfig#suggested-configuration
- nvim-lspconfig does not set keybindings or enable completion by default
- refer to the above link for an example config

##### Setting up autocomplete
Auto complete is a separate area of concern and has nothing to do with language server. [See this articule here for more detail](https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion). 
The entity that is responsible for autocomplete take what is provided by the language server to perform its job.

Some important packages are: 
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp/): this is the main package that provides the capability of autocompleting
- [vsnip](https://github.com/hrsh7th/vim-vsnip): this is the snippet enigne that the autocomplete would rely on to display results. 

 copying the [sample recommended configuration](https://github.com/hrsh7th/nvim-cmp/#recommended-configuration) is a good start.

##### Hover functions
`[d` - this goes backwards and show the diagnostics in a floating window
`]d` - this does the same thing and go forward with it
`<Space>e` - show all the error diagnostics on this line in one floating window

##### rust_analyzer
Using rust-tools is probably the easiest thing to do here: https://github.com/simrat39/rust-tools.nvim
Note that you should not call `lsp['rust_analyzer'].setup` once you have used this. It will override it. 

##### ccls (this is not currently used, clangd is used instead)
There is a guide here: https://jdhao.github.io/2020/11/29/neovim_cpp_dev_setup/

Some stuff to install beforehand (all of which can be done via brew):
- ccls
- cmake
- clang (this is probably installed via brew)
- llvm (this is also probably installed via brew)

On Mac the server would have trouble finding std library. This is because it would attempt to look for these include files in `/usr/include`, which no longer exists. Instead do the following:
```bash
g++ -E -x c++ - -v < /dev/null
```
This will output the include directories that are sourced by the g++. 

To resolve this issue of not being able to find the right header file on mac, do the following:
- `mkdir build` and `cd build` and generate make files with `-DCMAKE_EXPORT_COMPILE_COMMANDS=1` to generate `compile_commands.json`
- include `compilationDatabaseDirectory` as specified [here](https://github.com/MaskRay/ccls/wiki/Customization#compilationdatabasedirectory) in init_options
- include `clang.extraArgs` as specified [here](https://github.com/MaskRay/ccls/issues/191#issuecomment-453809905) in init_options
- initialize at the project root by running `ccls --index .` (this allows for information to perform some actions such as hovering)

For cross platform compilation, you would run into some trouble. See https://github.com/MaskRay/ccls/issues/760. 

Here are the extraArgs that made it work for me:
```Lua
        clang = {
            extraArgs = {
                "-isystem",
                "/Library/Developer/CommandLineTools/usr/include/c++/v1",
                "-isystem",
                "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/c++/v1",
                "-isystem",
                "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/14.0.0/include",
                "-isystem",
                "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include",
                "-isystem",
                "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include",
                "-isystem"
                "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/System/Library/Frameworks"
            } -- https://github.com/MaskRay/ccls/issues/191#issuecomment-453809905
        },
```

Some projects require cross compilation. Because ccls actually use clang (and not gcc), it would not really understand how to find some of the header files for some compilation targets. 
In order to bypass that, include a `.ccls` in the project root directory that points to the include files:
```
%compile_commands.json -- this is to make sure %compile_commands.json is still sourced
-isystem
/opt/homebrew/Cellar/arm-none-eabi-gcc/10.3-2021.07/gcc/lib/gcc/arm-none-eabi/10.3.1/include/
-isystem
/opt/homebrew/Cellar/arm-none-eabi-gcc/10.3-2021.07/gcc/arm-none-eabi/include/
```

## Setting up Telescope
The main github page is actually quite clear on what there is to do: https://github.com/nvim-telescope/telescope.nvim

For the live grep function, you need to install ripgrep.

## Setting up nvim-tree
*Some useful shortcuts are*:
- `H` will toggle hidden file
- `u` (this is actually configurable) will traverse up directory

---
## Breadcrumbs
*omnifuncs?*
- https://vim.fandom.com/wiki/Omni_completion
- this is a vim function (but it's also available in nvim)
