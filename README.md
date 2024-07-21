# moshi
A work in progress mkosi configuration around Arch Linux with the following goals:

- **Bleeding Edge:** Using CachyOS and Arch as a base to have the latest and greatest.
- **Modern:** Uses some of the newest best practices, such as using UKIs and containers.
- **Secure:** Secure Boot, Encrypted, TPM... All that goodness.
- **Legacy Free:** No GRUB, no BIOS support. By design.

#### Thanks
This repository takes insipration from or gives credits to the following projects and resources:

- [CachyOS Settings - Embedded into this configuration](https://github.com/CachyOS/CachyOS-Settings) - Many of the settings here act as a baseline for this image.

### Getting Started

#### Create incremental builds

If you would like to make a lot of changes, incremental builds are a good idea.

```sh
# Generate the default image
mkosi build --output=default
# Make some changes, then use an incremental build
mkosi -i boot
```

#### Generate or set a password for root

```sh
# For a consistent root password, set the hash
$ touch mkosi.rootpw
$ chmod 600 mkosi.rootpw
$ echo -n hashed: >>mkosi.rootpw
$ openssl passwd -6 >>mkosi.rootpw

# Or, if its one time only, consider setting it within the build image
systemd-nspawn --Image mkosi.output/default
passwd
```

#### Generate a basic image, with timestamp

```sh
mkosi -f --image-version=$(date --utc +%Y-%m-%d)
```

#### Generate a image based on the hash of the repository

```sh
mkosi -f --image-version=$(git rev-parse --short=10 HEAD)-$(date --utc +%Y-%m-%d)
```

On bootup, the image will prompt you to create a user, managed by `systemd-homed`. If you already have a `homed` user, copying it to the image should 'just work'. Likewise if you flash an image to bare metal and plug in a `homed` drive!

```sh
# Example for how to generate a systemd-homed user. Image path could be a USB key!
losetup --find --show --sector-size=4096 nurah.img
homectl create nurah --real-name="Nurah Wolfo" --email-address=nurah@wolfo.tech --shell=/usr/bin/fish --member-of=wheel,libvirt --storage=luks --luks-discard=true --luks-offline-discard=true --uid=60069 --ssh-authorized-keys="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGkFuzdCzeJ2B2KuUmRUTXErvo67RynDL/2/mBq9r+SW Nurah Wolfo <nurah@wolfo.tech> - Primary" --password-hint="Eat my butt" --fs-type=btrfs --image-path /dev/loop0
```

#### Create EFI entry to boot

If flashed to bare metal, or used as a VM, consider asking the UEFI to boot the UKI directly, instead of the boot loader.

```sh
efibootmgr -c -d /dev/nvme0n1p1 -p 1 -L "Moshi" -l '\EFI\Linux\moshi.efi'
```

### Packages

This project contains a lot of packages that I generally like. Some of them are called out below!

- [bat - A cat clone with wings](https://github.com/sharkdp/bat)
- [eza - A modern replacement for ls](https://github.com/eza-community/eza)
- [fastfetch - A feature-rich and performance oriented system information tool](https://github.com/fastfetch-cli/fastfetch)
- [neovim - Vim-fork focused on extensibility and usability](https://github.com/neovim/neovim)
- [plymouth - Pretty boot screens](https://gitlab.freedesktop.org/plymouth/plymouth)
- [yazi - Blazing fast terminal file manager](https://github.com/sxyazi/yazi)

#### Issues Tracked
- None for now!
