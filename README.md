# Serhat's dotfiles

My personal dotfiles.

Don’t use my settings *AS IS*, unless you know what that entails.

If you want to give these dotfiles a try, you should first fork
this repository, review the code, and remove things you don’t want or need.

Always WIP.

## Screenshots

![LunarVim](https://user-images.githubusercontent.com/29136904/191624942-3d75ef87-35cf-434d-850e-3e7cd5ce2ad0.png)

<details>

<summary>Show More Screenshot</summary>

![Nvim](./images/nvim.png "Nvim")

![tmux](./images/tmux.png "tmux")

![Nvim](./images/nvim_split.png "Nvim Split")

![fzf](./images/fzf.png "fzf")

</details>


## On a new machine

```bash
# Base `install.sh` will call all necessary install scripts.
$ ./install.sh

# generate and add new SSH key
# https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

# Open NeoVim, it will automatically install all plugins.
$ nvim
```

### Post Install

There is no need to do anything. All covered by `install.sh` script.
