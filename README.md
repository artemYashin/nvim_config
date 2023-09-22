
# Installation
This config requires some software to be installed:

    Python 3.10+
    NodeJS 14.0+
    watchman
Prefered font: 

    JetBrainsMono Nerd Font
which can be downloaded here:
https://www.nerdfonts.com/font-downloads

After cloning repository into nvim directory, you need to open plugins file using **nvim** :

    nvim lua/plugins.lua
After opening plugins file, you need to save it:

    :w
Saving this file will start the process of downloading/updating all plugins listed here.

After successfull updating, you can quit nvim:

    :qa!
At this moment plugins should be already installed, and we just need to download corresponding language servers, which can be found here:

https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions#implemented-coc-extensions

Example command to install recommended language supports for svelte:

    :CocInstall coc-tsserver coc-html coc-json coc-css coc-pairs @softmotions/coc-svelte 
   **Configuration is done. Restart nvim to ensure that all plugins loaded correctly.**

# Custom keymapping
All custom keymaps can be found at **init.lua** file.

# Default keymaps of this configuration:
## Code Completions:
**SHIFT+t** - Shows type of hovered variable/function

**SPACE+c+a** - *Code Actions (as example import component that is not imported)*

**SPACE+r+n** - *Rename Symbol (variable, function name, interface name, and etc.)*

**SPACE+g+f** - *Go to References*

**SPACE+g+d** - *Go to Definition*

**SPACE+g+i** - *Go to implementation*

**CTRL+s** - *Open code completion suggestion box*

**SPACE+f+d** - *Go to current variable's type definition*
## Tabs:
**ALT + ,** - *Switch to the previous buffer (file)*

**ALT + .** - *Switch to the next buffer (file)*

**ALT + c** - *Close curent buffer (file)*
## File Explorer:
**SPACE + d** - *Toggle file explorer*
## Files Search (telescope)
**SPACE + f + f** - *Open file search*

**SPACE + f + g** - *Live grep*
