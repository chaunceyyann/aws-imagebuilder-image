#!/usr/bin/env python3
import argparse
import logging
import os
import sys

import yaml

# Add the app directory to the path to import logger_utils
sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))

try:
    from utils.logger_utils import setup_logger
except ImportError:
    # Fallback to basic logging if logger_utils is not available
    def setup_logger(name="validator", level=logging.INFO, force=True):
        logger = logging.getLogger(name)
        if not logger.handlers or force:
            logger.setLevel(level)
            handler = logging.StreamHandler()
            formatter = logging.Formatter(
                "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
            )
            handler.setFormatter(formatter)
            logger.addHandler(handler)
        return logger


def parse_args():
    parser = argparse.ArgumentParser(description="Validate YAML file syntax.")
    parser.add_argument(
        "--file",
        nargs="+",
        required=True,
        help=(
            "YAML files to validate (shell globbing is fine, " "e.g. image-recipes/*)"
        ),
    )
    parser.add_argument(
        "--verbose", "-v", action="store_true", help="Enable verbose logging"
    )
    return parser.parse_args()


def validate_file(path, logger):
    try:
        with open(path) as f:
            data = yaml.safe_load(f)
        logger.debug(f"Parsed YAML for {path}: {data!r}")
        if data is None:
            # Accept empty files as valid
            return []
        if not isinstance(data, dict):
            logger.debug(f"YAML root is not a mapping for {path}")
            return [f"YAML root must be a mapping (dict), got {type(data).__name__}"]
        return []
    except FileNotFoundError:
        logger.debug(f"File not found: {path}")
        return [f"File not found: {path}"]
    except Exception as e:
        logger.debug(f"Exception for {path}: {e}")
        return [f"YAML syntax error: {e}"]


def main():
    args = parse_args()

    # Set up logger based on verbosity
    level = logging.DEBUG if args.verbose else logging.INFO
    logger = setup_logger("validator", level=level, force=True)

    overall_fail = False

    for filepath in args.file:
        if os.path.isdir(filepath):
            continue

        logger.info(f"=== Validating: {filepath} ===")
        errors = validate_file(filepath, logger)
        if errors:
            overall_fail = True
            for e in errors:
                logger.error(f"ERROR: {e}")
        else:
            logger.info("OK - Valid YAML format")

    sys.exit(1 if overall_fail else 0)


if __name__ == "__main__":
    main()
