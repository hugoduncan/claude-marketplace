#!/usr/bin/env bash
# Test script for announce-notification plugin

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NOTIFICATION_SCRIPT="$SCRIPT_DIR/../scripts/idle_notification.sh"

# Color output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

test_count=0
pass_count=0
fail_count=0

# Function to run a test
run_test() {
    local test_name="$1"
    local json_input="$2"
    local should_succeed="$3"  # "true" or "false"

    test_count=$((test_count + 1))
    echo -e "\n${YELLOW}Test $test_count: $test_name${NC}"
    echo "Input: $json_input"

    # Run the notification script
    if output=$(echo "$json_input" | bash "$NOTIFICATION_SCRIPT" 2>&1); then
        echo -e "${GREEN}✓ Script executed successfully${NC}"
        if [[ -n "$output" ]]; then
            echo "Output: $output"
        else
            echo "Note: TTS commands don't produce text output (audio only)"
        fi

        if [[ "$should_succeed" == "true" ]]; then
            echo -e "${GREEN}✓ Test passed${NC}"
            pass_count=$((pass_count + 1))
        else
            echo -e "${RED}✗ Expected failure but succeeded${NC}"
            fail_count=$((fail_count + 1))
        fi
    else
        exit_code=$?
        echo -e "${RED}✗ Script failed with exit code $exit_code${NC}"
        echo "Error output: $output"

        if [[ "$should_succeed" == "false" ]]; then
            echo -e "${GREEN}✓ Expected error occurred${NC}"
            pass_count=$((pass_count + 1))
        else
            fail_count=$((fail_count + 1))
        fi
    fi
}

# Function to display summary
show_summary() {
    echo -e "\n========================================="
    echo -e "Test Summary"
    echo -e "=========================================\n"
    echo "Total tests: $test_count"
    echo -e "${GREEN}Passed: $pass_count${NC}"
    echo -e "${RED}Failed: $fail_count${NC}"

    if [ $fail_count -eq 0 ]; then
        echo -e "\n${GREEN}All tests passed!${NC}"
        return 0
    else
        echo -e "\n${RED}Some tests failed!${NC}"
        return 1
    fi
}

# Main test execution
echo "========================================="
echo "Testing announce-notification plugin"
echo "========================================="
echo "Platform: $(uname -s)"
echo "TTS commands available:"
command -v say && echo "  - say: yes" || echo "  - say: no"
command -v spd-say && echo "  - spd-say: yes" || echo "  - spd-say: no"
command -v espeak && echo "  - espeak: yes" || echo "  - espeak: no"

# Test 1: Idle notification
run_test "Idle notification" \
    '{"message": "Claude is idle"}' \
    "true"

# Test 2: Waiting notification
run_test "Waiting notification" \
    '{"message": "Claude is waiting for input"}' \
    "true"

# Test 3: Other notification
run_test "Generic notification" \
    '{"message": "Task completed"}' \
    "true"

# Test 4: Empty message
run_test "Empty message (should use default)" \
    '{}' \
    "true"

# Show summary
show_summary
