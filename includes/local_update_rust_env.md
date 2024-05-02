<details>
    <summary>Update local rust/cargo env to newest stand</summary>

## project setup for easy to used

### update rust of latest stable version

```bash
rustup update
```

### update all rust extension

#### install cargo-update

```bash
cargo install cargo-update
```

#### Self-update of cargo-update

- cargo-update will update itself seamlessly on Linux and Windows.

```bash
cargo update
```

#### update all extension

```bash
cargo install update -- -a
```

- error: there is nothing to install in `update v0.0.0`, because it has no binaries
Where there is nothing, nothing can be updated

### check all necessary plugins installed

```bash
ls -la  ~/.cargo/bin/
```

### check cargo-edit

#### check is already installed and with which version

```bash
cargo install --list |grep cargo-edit
```

#### install cargo install /w command cargo add

```bash
cargo install cargo-edit
```

#### update any/all packages of akt project

```bash
cargo update
```

## rust switch from stable to nightly and back [found here](https://stackoverflow.com/questions/58226545/how-to-switch-between-rust-toolchains)

### find out which version is on start

```bash
rustc --version
```

### switch to nightly

```bash
rustup override set nightly
```

### switch to stable

```bash
rustup override set stable
```

</details>
