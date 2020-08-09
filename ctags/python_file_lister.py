#!/usr/bin/env python3
import os
import sys


def better_listdir(dirpath):
    """
    Generator yielding (filename, filepath) tuples for every
    file in the given directory path.
    """
    # First clean up dirpath to absolutize relative paths and
    # symbolic path names (e.g. `.`, `..`, and `~`)
    dirpath = os.path.abspath(os.path.expanduser(dirpath))

    for filename in os.listdir(dirpath):
        yield os.path.join(dirpath, filename)


files_path = [d for d in sys.path if os.path.isdir(d)]
files = [f for d in files_path for f in better_listdir(d) if os.path.isfile(f)]

print("\n".join("{}".format(f) for f in files))
