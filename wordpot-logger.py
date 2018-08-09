#!/usr/bin/env python

# Modified from upstream logger function, to write to stdout.

import logging
import logging.handlers
import os
import sys

LOGGER = logging.getLogger('wordpot-logger')

def logging_setup():
    # Formatter
    formatter = logging.Formatter('%(asctime)s - %(message)s')

    fh = logging.StreamHandler(sys.stdout)
    fh.setFormatter(formatter)

    # Add handlers
    LOGGER.addHandler(fh)

    # Set level
    LOGGER.setLevel(logging.INFO)
    return True
