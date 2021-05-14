# Wheelie

This repo builds and uploads wheels for pip packages commonly used in linuxserver.io images.

The wheel index is located at https://wheel-index.linuxserver.io
The wheels are downloaded from https://wheels.linuxserver.io

Only 2 files are user configurable:
- `distros.txt`: lists the distros the wheels are built with. Should be in the format of either `ubuntu:focal` or `alpine:3.13` (only ubuntu and alpine versions are supported).
- `packages.txt`: lists the packages for which the wheels are built.

After modifying the above two files, you can either wait until the scheduler runs (hourly) or manually trigger the github workflow `wheelie-scheduler.yml`
