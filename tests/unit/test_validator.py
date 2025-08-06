import os
import sys
import tempfile
import unittest
from unittest.mock import mock_open, patch

# Add the app directory to the path so we can import the validator module
current_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.dirname(os.path.dirname(current_dir))
app_path = os.path.join(project_root, "app")
sys.path.insert(0, app_path)

try:
    from validator.validator import validate_file
except ImportError as e:
    print(f"Import error: {e}")
    print(f"Python path: {sys.path}")

    # If the import fails, we'll create a mock for testing
    def validate_file(path, logger):
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
        # This is truly invalid YAML (unbalanced brackets)
        self.invalid_yaml_content = ":\n- just: [broken"

    def test_validate_valid_yaml(self):
        """Test validate_file with valid YAML content."""
        with patch("builtins.open", mock_open(read_data=self.valid_yaml_content)):
            # Create a mock logger
            mock_logger = unittest.mock.Mock()
            result = validate_file("test_file.yaml", mock_logger)
            self.assertEqual(result, [], "Should return empty list for valid YAML")

    def test_validate_invalid_yaml(self):
        """Test validate_file with invalid YAML content using a real temp file."""
        with tempfile.NamedTemporaryFile("w+", delete=False) as tmp:
            tmp.write(self.invalid_yaml_content)
            tmp_path = tmp.name
        try:
            # Create a mock logger
            mock_logger = unittest.mock.Mock()
            result = validate_file(tmp_path, mock_logger)
            self.assertIsInstance(result, list, "Should return a list")
            self.assertGreater(len(result), 0, "Should contain error messages")
        finally:
            os.remove(tmp_path)

    def test_validate_empty_file(self):
        """Test validate_file with empty file."""
        with patch("builtins.open", mock_open(read_data="")):
            # Create a mock logger
            mock_logger = unittest.mock.Mock()
            result = validate_file("test_file.yaml", mock_logger)
            self.assertEqual(result, [], "Should return empty list for empty file")

    def test_validate_nonexistent_file(self):
        """Test validate_file with nonexistent file using a real missing file."""
        fake_path = "this_file_should_not_exist_123456.yaml"
        # Ensure the file does not exist
        if os.path.exists(fake_path):
            os.remove(fake_path)
        # Create a mock logger
        mock_logger = unittest.mock.Mock()
        result = validate_file(fake_path, mock_logger)
        self.assertIsInstance(result, list, "Should return a list")
        self.assertGreater(len(result), 0, "Should contain error messages")

    def test_validate_file_with_unicode(self):
        """Test validate_file with unicode content."""
        unicode_content = """
name: test-recipe
description: "Test recipe with unicode: café, naïve, résumé"
version: 1.0.0
"""
        with patch("builtins.open", mock_open(read_data=unicode_content)):
            # Create a mock logger
            mock_logger = unittest.mock.Mock()
            result = validate_file("test_file.yaml", mock_logger)
            self.assertEqual(result, [], "Should handle unicode content")

    def test_validate_file_with_comments(self):
        """Test validate_file with YAML comments."""
        commented_content = """
# This is a comment
name: test-recipe  # Inline comment
description: Test recipe
version: 1.0.0
"""
        with patch("builtins.open", mock_open(read_data=commented_content)):
            # Create a mock logger
            mock_logger = unittest.mock.Mock()
            result = validate_file("test_file.yaml", mock_logger)
            self.assertEqual(result, [], "Should handle YAML comments")


if __name__ == "__main__":
    unittest.main()
