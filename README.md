# Wheelie

This repo builds and uploads wheels for commonly used pip packages.

The wheel index is located at https://wheel-index.linuxserver.io
The wheels are downloaded from https://wheels.linuxserver.io

Only 2 files are user configurable:
- `distros.txt`: lists the distros the wheels are built with. Should be in the format of either `ubuntu:focal` or `alpine:3.13` (only ubuntu and alpine versions are supported).
- `packages.txt`: lists the packages for which the wheels are built.

After modifying the above two files, you can either wait until the scheduler runs (hourly) or manually trigger the github workflow `wheelie-scheduler.yml`

The only condition that wouldn't auto-trigger builds (when it really needs to) is if a new distro like `alpine-3.14` is added to `distros.txt` and that distro has a newer python version than the existing ones. The reason is because the wheels for multiple alpine versions all reside in the same index and the version checker can only check for the package version, but not the python version. It will likely see the existing package version for the previous distro (and earlier python version) and will skip the trigger. In that case manually triggering the `wheelie.yml` workflow should force rebuild of all wheels in `packages.txt` for all distros in `distros.txt`.
