#!/usr/bin/env python3
import logging
import sys
from typing import Optional


class ColoredFormatter(logging.Formatter):
    """Custom formatter with colored output for different log levels."""
    
    # ANSI color codes
    COLORS = {
        'DEBUG': '\033[36m',      # Cyan
        'INFO': '\033[32m',       # Green
        'WARNING': '\033[33m',    # Yellow
        'ERROR': '\033[31m',      # Red
        'CRITICAL': '\033[35m',   # Magenta
        'RESET': '\033[0m'        # Reset
    }
    
    def format(self, record):
        # Get the original format
        formatted = super().format(record)
        
        # Add color if available
        if record.levelname in self.COLORS:
            formatted = f"{self.COLORS[record.levelname]}{formatted}{self.COLORS['RESET']}"
        
        return formatted


def setup_logger(
    name: str = "validator",
    level: int = logging.INFO,
    colored: bool = True,
    log_file: Optional[str] = None,
    force: bool = False
) -> logging.Logger:
    """
    Set up a logger with custom formatter and optional colored output.
    
    Args:
        name: Logger name
        level: Logging level
        colored: Whether to use colored output
        log_file: Optional file path for logging to file
        force: Force reconfiguration even if handlers exist
    
    Returns:
        Configured logger instance
    """
    logger = logging.getLogger(name)
    
    # Only configure if no handlers exist or force is True
    if not logger.handlers or force:
        logger.setLevel(level)
        
        # Clear any existing handlers
        logger.handlers.clear()
        
        # Create formatter
        if colored:
            formatter = ColoredFormatter(
                '%(asctime)s - %(name)s - %(levelname)s - %(message)s',
                datefmt='%Y-%m-%d %H:%M:%S'
            )
        else:
            formatter = logging.Formatter(
                '%(asctime)s - %(name)s - %(levelname)s - %(message)s',
                datefmt='%Y-%m-%d %H:%M:%S'
            )
        
        # Console handler
        console_handler = logging.StreamHandler(sys.stdout)
        console_handler.setLevel(level)
        console_handler.setFormatter(formatter)
        logger.addHandler(console_handler)
        
        # File handler (if specified)
        if log_file:
            file_handler = logging.FileHandler(log_file)
            file_handler.setLevel(level)
            # Use non-colored formatter for file output
            file_formatter = logging.Formatter(
                '%(asctime)s - %(name)s - %(levelname)s - %(message)s',
                datefmt='%Y-%m-%d %H:%M:%S'
            )
            file_handler.setFormatter(file_formatter)
            logger.addHandler(file_handler)
    
    return logger


def get_logger(name: str = "validator") -> logging.Logger:
    """
    Get a logger instance. If not configured, sets up default configuration.
    
    Args:
        name: Logger name
    
    Returns:
        Logger instance
    """
    logger = logging.getLogger(name)
    
    # If logger has no handlers, set up default configuration
    if not logger.handlers:
        setup_logger(name)
    
    return logger 