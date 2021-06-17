# Wheelie

This repo builds and uploads wheels for pip packages commonly used in linuxserver.io images.

The wheel index is located at https://wheel-index.linuxserver.io
The wheels are downloaded from https://wheels.linuxserver.io

Only 2 files are user configurable:
- `distros.txt`: lists the distros the wheels are built with. Should be in the format of either `ubuntu:focal` or `alpine:3.14` (only ubuntu and alpine versions are supported).
- `packages.txt`: lists the packages for which the wheels are built.

After modifying the above two files, you can either wait until the scheduler runs (hourly) or manually trigger the github workflow `wheelie-scheduler.yml`

If adding a new package to `packages.txt` please make sure the Dockerfile has all the necessary dependencies installed, by testing locally first. To do that, follow the steps below:
- Clone the repo: `git clone https://github.com/aptalca/wheels.git`
- Enter the folder: `cd wheels`
- Test all the distros (may need to use the arm32v7 versions if amd64 already has prebuilt wheels in pypi):
  - `docker build --build-arg DISTRO=alpine --build-arg DISTROVER=3.14 --build-arg ARCH=amd64 --build-arg PACKAGES=gevent .`
  - `docker build --build-arg DISTRO=alpine --build-arg DISTROVER=3.13 --build-arg ARCH=amd64 --build-arg PACKAGES=gevent .`
  - `docker build --build-arg DISTRO=ubuntu --build-arg DISTROVER=focal --build-arg ARCH=arm32v7 --build-arg PACKAGES=gevent .`
  - `docker build --build-arg DISTRO=ubuntu --build-arg DISTROVER=bionic --build-arg ARCH=arm32v7 --build-arg PACKAGES=gevent .`
- If the build fails (or if it downloads a prebuilt wheel instead of building), you can add the necessary dependencies to the Dockerfile and/or change the arch, and test again (build cache should save some time).
- Once confirmed, you can commit your changes to this repo and let the scheduler trigger in the next hourly.
