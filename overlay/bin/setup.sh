#!/bin/bash -eu

SNAP_INSTANCE_NAME="$(readlink -f $0 | cut -f 3 -d /)"

# For access to Docker Daemon
snap connect $SNAP_INSTANCE_NAME:docker docker:docker-daemon
# For access to Docker CLI
snap connect $SNAP_INSTANCE_NAME:docker-executables docker:docker-executables
