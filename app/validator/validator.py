#!/usr/bin/env python3
import argparse
import sys
import yaml
import os


def parse_args():
    parser = argparse.ArgumentParser(
        description="Validate YAML file syntax."
    )
    parser.add_argument(
        "--file",
        nargs="+",
        required=True,
        help=(
            "YAML files to validate (shell globbing is fine, "
            "e.g. image-recipes/*)"
        )
    )
    return parser.parse_args()


def validate_file(path):
    try:
        with open(path) as f:
            yaml.safe_load(f)
        return []
    except Exception as e:
        return [f"YAML syntax error: {e}"]


def main():
    args = parse_args()
    overall_fail = False

    for filepath in args.file:
        if os.path.isdir(filepath):
            continue

        print(f"=== Validating: {filepath} ===")
        errors = validate_file(filepath)
        if errors:
            overall_fail = True
            for e in errors:
                print(f"ERROR: {e}")
        else:
            print("OK - Valid YAML format")

    sys.exit(1 if overall_fail else 0)


if __name__ == "__main__":
    main()
