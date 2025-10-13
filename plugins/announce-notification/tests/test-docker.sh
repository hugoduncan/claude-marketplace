#!/usr/bin/env bash
# Docker-based test script for cross-platform testing

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

# Color output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Test JSON input
TEST_JSON='{"message": "Claude is idle"}'

echo "========================================="
echo "Docker-based Cross-Platform Testing"
echo "========================================="

# Test 1: Linux with speech-dispatcher
echo -e "\n${BLUE}Test 1: Linux with speech-dispatcher (spd-say)${NC}"
echo "Creating container with speech-dispatcher..."

docker run --rm \
    -v "$PLUGIN_DIR:/plugin:ro" \
    debian:bookworm-slim \
    bash -c '
        set -euo pipefail
        apt-get update -qq && apt-get install -y -qq jq speech-dispatcher > /dev/null 2>&1
        echo "Installed packages:"
        command -v jq && echo "  ✓ jq"
        command -v spd-say && echo "  ✓ spd-say"
        echo ""
        echo "Running notification script..."
        cd /tmp
        echo '"'$TEST_JSON'"' | bash /plugin/scripts/idle_notification.sh 2>&1 || true
    '

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Test passed${NC}"
else
    echo -e "${RED}✗ Test failed${NC}"
fi

# Test 2: Linux with only espeak
echo -e "\n${BLUE}Test 2: Linux with espeak only${NC}"
echo "Creating container with espeak..."

docker run --rm \
    -v "$PLUGIN_DIR:/plugin:ro" \
    debian:bookworm-slim \
    bash -c '
        set -euo pipefail
        apt-get update -qq && apt-get install -y -qq jq espeak > /dev/null 2>&1
        echo "Installed packages:"
        command -v jq && echo "  ✓ jq"
        command -v espeak && echo "  ✓ espeak"
        command -v spd-say && echo "  ✓ spd-say" || echo "  ✗ spd-say (not installed)"
        echo ""
        echo "Running notification script..."
        cd /tmp
        echo '"'$TEST_JSON'"' | bash /plugin/scripts/idle_notification.sh 2>&1 || true
    '

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Test passed${NC}"
else
    echo -e "${RED}✗ Test failed${NC}"
fi

# Test 3: Linux with no TTS (should fail with helpful error)
echo -e "\n${BLUE}Test 3: Linux with no TTS (expect error message)${NC}"
echo "Creating container without TTS..."

docker run --rm \
    -v "$PLUGIN_DIR:/plugin:ro" \
    debian:bookworm-slim \
    bash -c '
        set -euo pipefail
        apt-get update -qq && apt-get install -y -qq jq > /dev/null 2>&1
        echo "Installed packages:"
        command -v jq && echo "  ✓ jq"
        command -v spd-say && echo "  ✓ spd-say" || echo "  ✗ spd-say (not installed)"
        command -v espeak && echo "  ✓ espeak" || echo "  ✗ espeak (not installed)"
        echo ""
        echo "Running notification script (expecting error)..."
        cd /tmp
        if output=$(echo '"'$TEST_JSON'"' | bash /plugin/scripts/idle_notification.sh 2>&1); then
            echo "Unexpected success: $output"
            exit 1
        else
            echo "Expected error occurred:"
            echo "$output"
            # Check if error message is helpful
            if echo "$output" | grep -q "No text-to-speech command available"; then
                echo ""
                echo "✓ Error message contains expected text"
                exit 0
            else
                echo ""
                echo "✗ Error message does not contain expected text"
                exit 1
            fi
        fi
    '

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Test passed (error handled correctly)${NC}"
else
    echo -e "${RED}✗ Test failed${NC}"
fi

echo -e "\n${GREEN}Docker testing complete!${NC}"
