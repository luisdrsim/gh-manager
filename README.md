# 🐙 ghm — GitHub Account Manager

A terminal CLI for managing multiple GitHub accounts via the [`gh`](https://cli.github.com/) CLI. Switch between accounts, inspect tokens, assign accounts to directories, and more — all from an interactive menu or directly from the command line.

## Features

- Interactive TUI menu with all operations in one place
- Switch between authenticated accounts instantly
- Inspect token scopes and validity per account
- Add or remove GitHub accounts
- Assign an account to a directory via `.envrc` + [direnv](https://direnv.net/)
- Works as a direct subcommand: `ghm switch <username>`

## Languages

`ghm` detects the language automatically from your system locale (`$LANG`). Supported languages:

| Code | Language   |
|------|------------|
| `en` | English    |
| `es` | Español    |
| `fr` | Français   |
| `de` | Deutsch    |
| `pt` | Português  |
| `it` | Italiano   |

Override the language at any time with the `GHM_LANG` environment variable:

```bash
GHM_LANG=fr ghm          # use French for this run
export GHM_LANG=es        # set Spanish as default in your shell
```

## Requirements

- macOS or Linux
- [`gh`](https://cli.github.com/) — GitHub CLI (`brew install gh`)
- _(optional)_ [`direnv`](https://direnv.net/) — for the `.envrc` feature (`brew install direnv`)

## Installation

### Via Homebrew

```bash
brew install lcajigasm/gh-manager/ghm
```

### From source

```bash
git clone https://github.com/lcajigasm/gh-manager.git
cd gh-manager
make install
```

## Usage

```
ghm                    → Opens the interactive menu
ghm status             → Shows the active account and full list
ghm switch             → Interactive account switcher
ghm switch <username>  → Switch directly to a specific account
ghm version            → Show installed version
ghm help               → Show help
```

### Interactive menu

Running `ghm` without arguments opens the main menu:

```
  🐙 gh-manager  ·  GitHub CLI · Gestión de cuentas
  ──────────────────────────────────────────────────
  👤  Cuenta activa:  myuser   (2 cuentas autenticadas)
  ──────────────────────────────────────────────────

  ¿Qué quieres hacer?

  ── Cuentas ───────────────────────────────────────
    1)  📊  Ver estado detallado de las cuentas
    2)  🔄  Cambiar cuenta activa
    3)  ➕  Añadir nueva cuenta
    4)  🚪  Cerrar sesión de una cuenta

  ── Herramientas ──────────────────────────────────
    5)  🔑  Ver / copiar token de una cuenta
    6)  🔁  Comprobar y refrescar autenticación
    7)  📁  Asignar cuenta a directorio (.envrc)

  ──────────────────────────────────────────────────
    0)  👋  Salir
```

### Quick status

```bash
$ ghm status

  🐙 gh-manager · Estado rápido
  ──────────────────────────────────────────────────
  👤  Cuenta activa:  myuser

  Cuentas autenticadas:
    ○  work-account
    ●  myuser  (activa)
```

### Direct switch

```bash
ghm switch work-account
```

## Per-directory account assignment

The `.envrc` feature (option `7` in the menu) writes `export GH_USER=<account>` to a `.envrc` file in the current directory. With `direnv` installed and hooked into your shell, the right GitHub account activates automatically when you `cd` into that directory.

**Setup direnv** (if not already done):

```bash
brew install direnv
# Add to ~/.zprofile or ~/.zshrc:
eval "$(direnv hook zsh)"
```

## Development

### Local install / uninstall

```bash
make install    # copies bin/ghm to /usr/local/bin
make uninstall  # removes it
```

### Lint

```bash
make lint       # runs shellcheck on bin/ghm
```

### Release

```bash
make release TAG=v1.2.0
```

This will:
1. Run `shellcheck` lint
2. Create and push the git tag
3. Publish a GitHub release with auto-generated notes
4. Fetch the release tarball and compute its SHA256
5. Update `Formula/ghm.rb` with the new URL, SHA256, and version

After releasing, commit and push the updated formula:

```bash
git add Formula/ghm.rb
git commit -m "chore: bump formula to v1.2.0"
git push
```

## License

MIT
