# Changelog

## v1.5 — 2025-09-28

Highlights
- Serial support: merge upstream `serial-support` adding CC13XX/CC26XX and Launchpad serial modes.
- USB robustness: improved repeated-run behavior under Docker and Linux.
- CI/CD: automated Docker builds for edge and releases; PR multi-arch checks.

Details
- Add serial sniffer support (from upstream):
  - New options: `-s` (serial mode), `-p <path>` (serial device path).
  - Keep original FCS (`-k`), dump to file (`-f`), hourly (`-h`) / daily (`-d`) rotation.
  - Channel can be specified in hex (e.g. `-c 0x0B`).
- Improve libusb handling for repeated runs:
  - Skip redundant `libusb_set_configuration` when already configured.
  - Enable `libusb_set_auto_detach_kernel_driver` where available.
  - Add retry loop for `libusb_claim_interface` on BUSY with kernel detach and 100 ms backoff; reset device and reapply config on the 3rd attempt.
  - Better error messages including `libusb_error_name`.
- Docker/CI:
  - Publish `pastukhov/whsniff:edge` on pushes to `master`.
  - Publish release images on tags/releases: `vX.Y[.Z]`, `vX`, and `latest`.
  - PR workflow builds for `linux/amd64` and `linux/arm64` and runs a smoke check.
- Repository hygiene:
  - Remove tracked binaries; add `.gitignore` to prevent re-adding build artifacts.

Notes
- Linux/macOS builds require `libusb-1.0-0-dev` (Linux) / `libusb` (macOS).
- Docker run example: `docker run --rm --privileged --device /dev/bus/usb:/dev/bus/usb pastukhov/whsniff:v1.5 -c 11`.
- For CC2531 permissions, see ReadMe udev instructions.

