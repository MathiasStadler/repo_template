# update rust add another to last_version

## show which version is on start

## show running version

```bash
rustup show
```

## Switch between the installed version stable or nightly

```bash
#switch to stable
rustup override set stable

#switch to nightly
rustup override set nightly
```

## [update rustup self system wide](https://rust-lang.github.io/rustup/basics.html)

```bash
rustup self update
```

## [update rust toolchain system wide](https://rust-lang.github.io/rustup/basics.html)

```bash
rustup update
```

## Update all project dependencies

### [Install cargo-edit](https://crates.io/crates/cargo-edit)

```bash
cargo add cargo-edit
```

### Show all new cargo installed commands

```bash
cargo --list
```

### Update all project dependencies

```bash
cargo update
# or with more information
cargo update --verbose
```

### Upgrade all dependencies for the current crate

```bash
cargo upgrade
# or with more information
cargo upgrade --verbose
```


## build the project with the new rust version and with the new updates crates

```bash
cargo build
# # or with more information
cargo build --verbose
```

## remove manual project dependency

```bash
cargo remove tarpaulin
```

## remove automatic unused project dependency
