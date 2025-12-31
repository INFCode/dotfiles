# scripts

These scripts initialize a fresh system. They do **not** parse chezmoi config; you should use chezmoi templates to decide which scripts to run on which hosts.

## Usage

Run the scripts from this repository:

```bash
./scripts/deps/common.sh

# then pick ONE platform deps checker:
./scripts/deps/arch.sh
# ./scripts/deps/debian.sh
# ./scripts/deps/rhel.sh
# ./scripts/deps/darwin.sh

# if your platform needs a bootstrap package manager, run it after deps checks:
./scripts/pkgmgr/ensure-paru.sh   # Arch
./scripts/pkgmgr/ensure-brew.sh   # macOS
```

## Principles

- Each script is atomic: one script does one thing.
- Dependency-check scripts fail fast and require you to install missing prerequisites manually.
- Package-manager scripts check first; they only install when missing.


