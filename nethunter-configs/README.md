# Kali NetHunter Kernel Configuration

This directory contains kernel configuration options (CONFIG_ flags) to enable Kali NetHunter features without requiring source code patches.

## What This Includes

These kernel config options enable NetHunter support for:
- Bluetooth adapters (various protocols)
- MAC80211 wireless stack with monitor mode
- USB WiFi drivers (Atheros, MediaTek, Ralink, Realtek, ZyDAS)
- USB Ethernet adapters
- Android Binder IPC

## Files

- `nethunter_defconfig` - All NetHunter kernel config options
- `../scripts/merge-nethunter-config.sh` - Script to merge into existing defconfig

## Usage

### Method 1: Manual Merge (Local Build)

After fetching kernel source and running `make defconfig`:

```bash
./scripts/merge-nethunter-config.sh path/to/kernel/.config
```

Then continue with your normal build process.

### Method 2: GitHub Actions Integration

To integrate into your OnePlus kernel GitHub Actions workflow:

1. Add the config merge step after kernel source is synced
2. The merge should happen before `make olddefconfig`
3. Example workflow step:

```yaml
- name: Merge NetHunter Config
  run: |
    cd kernel_platform/common
    ../../scripts/merge-nethunter-config.sh arch/arm64/configs/your_defconfig
    make olddefconfig
```

## Config Options Included

**General:**
- System V IPC
- Loadable module support

**Bluetooth:**
- HCI USB driver
- Broadcom, Realtek protocol support
- HCI UART driver
- Various USB Bluetooth drivers

**Wireless Stack (MAC80211):**
- cfg80211 wireless extensions
- Generic IEEE 802.11 Networking Stack
- Mesh networking support

**USB WiFi Drivers:**
- Atheros/Qualcomm (ATH9K_HTC, ATH6KL, CARL9170)
- MediaTek (MT7601U)
- Ralink (RT2500, RT73, RT2800 series)
- Realtek (RTL8187, RTL8192CU, RTL8XXXU)
- ZyDAS (ZD1211RW)

**USB Ethernet:**
- RTL8150, RTL8152

## Compatibility

These config options work with kernel versions that include the respective drivers in-tree. For kernel 6.1+ (OnePlus 12):

✅ **Works:**
- Most Atheros drivers
- MediaTek drivers (except MT7601U has limitations)
- Ralink drivers
- Realtek 8187
- Bluetooth drivers

⚠️ **Limited:**
- MT7601U - No packet injection support
- Some older Realtek drivers may be deprecated

❌ **Not in kernel 6.1:**
- RTL8812AU/8821AU/8814AU - Requires kernel 6.14+ or out-of-tree drivers

## Notes

- These are CONFIG_ flags only, no source code modifications
- Drivers must be present in the kernel source tree
- Some features may require additional firmware files
- Monitor mode and packet injection depend on driver capabilities

## References

- [Kali NetHunter Kernel Config - General](https://www.kali.org/docs/nethunter/nethunter-kernel-2-config-1/)
- [Kali NetHunter Kernel Config - Network](https://www.kali.org/docs/nethunter/nethunter-kernel-3-config-2/)
- [Kali NetHunter Kernel Config - WiFi](https://www.kali.org/docs/nethunter/nethunter-kernel-4-config-3/)
