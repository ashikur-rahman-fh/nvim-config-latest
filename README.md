# NeoVim Configuration

## Setup

### System Requirement
- npm
- gcc
- make
- ripgrep

### Installation
#### Download
Clone the repository inside `~/.config/nvim` directory.
```
cd ~/.config/nvim
git clone https://github.com/ashikur-rahman-fh/nvim-config-latest.git .
```

#### Fresh Installation
```
make clean
make install
```

#### Normal Installation
```
make install
```

### Plugin support
- Packer - Package Management
- Telescope - File Search
- TreeSitter - Syntax Highlighting
- UndoTree - File Edit History
- NvimTree - File Tree
- LSP - Language Server for Completion
