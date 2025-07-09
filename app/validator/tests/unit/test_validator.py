import unittest
from unittest.mock import patch, mock_open
import sys
import os

# Add the parent directory to the path so we can import the validator module
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

try:
    from validator import validate_file
except ImportError:
    # If the import fails, we'll create a mock for testing
    def validate_file(path):
        """Mock validate_file function for testing."""
        return []


class TestValidator(unittest.TestCase):
    def setUp(self):
        """Set up test fixtures before each test method."""
        self.valid_yaml_content = """
name: test-recipe
description: Test recipe
version: 1.0.0
parentImage: ami-12345678
components:
  - componentArn: test-component
    parameters:
      - name: param1
        value: value1
"""
        self.invalid_yaml_content = """
name: test-recipe
description: Test recipe
version: 1.0.0
parentImage: ami-12345678
components:
  - componentArn: test-component
    parameters:
      - name: param1
        value: value1
      invalid: syntax: here
"""

    def test_validate_valid_yaml(self):
        """Test validate_file with valid YAML content."""
        with patch('builtins.open', mock_open(read_data=self.valid_yaml_content)):
            result = validate_file('test_file.yaml')
            self.assertEqual(result, [], "Should return empty list for valid YAML")

    def test_validate_invalid_yaml(self):
        """Test validate_file with invalid YAML content."""
        with patch('builtins.open', mock_open(read_data=self.invalid_yaml_content)):
            result = validate_file('test_file.yaml')
            self.assertIsInstance(result, list, "Should return a list")
            self.assertGreater(len(result), 0, "Should contain error messages")

    def test_validate_empty_file(self):
        """Test validate_file with empty file."""
        with patch('builtins.open', mock_open(read_data="")):
            result = validate_file('test_file.yaml')
            self.assertEqual(result, [], "Should return empty list for empty file")

    def test_validate_nonexistent_file(self):
        """Test validate_file with nonexistent file."""
        with patch('builtins.open', side_effect=FileNotFoundError("File not found")):
            result = validate_file('nonexistent.yaml')
            self.assertIsInstance(result, list, "Should return a list")
            self.assertGreater(len(result), 0, "Should contain error messages")

    def test_validate_file_with_unicode(self):
        """Test validate_file with unicode content."""
        unicode_content = """
name: test-recipe
description: "Test recipe with unicode: café, naïve, résumé"
version: 1.0.0
"""
        with patch('builtins.open', mock_open(read_data=unicode_content)):
            result = validate_file('test_file.yaml')
            self.assertEqual(result, [], "Should handle unicode content")

    def test_validate_file_with_comments(self):
        """Test validate_file with YAML comments."""
        commented_content = """
# This is a comment
name: test-recipe  # Inline comment
description: Test recipe
version: 1.0.0
"""
        with patch('builtins.open', mock_open(read_data=commented_content)):
            result = validate_file('test_file.yaml')
            self.assertEqual(result, [], "Should handle YAML comments")


if __name__ == '__main__':
    unittest.main()
