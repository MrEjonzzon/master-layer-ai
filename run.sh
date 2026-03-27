#!/bin/bash

# I totally wrote this script myself manually line by line
# Usage: ./run.sh [up|down|restart|logs]

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored messages
print_message() {
    echo -e "${BLUE}========================================${NC}"
    echo -e "$1"
    echo -e "${BLUE}========================================${NC}"
}

# Check if docker is running
check_docker() {
    if ! command -v docker &> /dev/null; then
        print_message "${RED}❌ Docker is not installed. Please install docker first!${NC}"
        exit 1
    fi

    if ! docker info &> /dev/null; then
        print_message "${RED}❌ Docker daemon is not running.${NC}"
        exit 1
    fi

    print_message "${GREEN}✓ Docker is running${NC}"
}

# Main function
case "$1" in
    up)
        print_message "${GREEN}Starting containers with 'docker compose up -d'${NC}"
        docker compose up -d --build
        print_message "${GREEN}✓ Containers started successfully${NC}"
        ;;
    down)
        print_message "${YELLOW}Stopping containers with 'docker compose down'${NC}"
        docker compose down
        print_message "${GREEN}✓ Containers stopped successfully${NC}"
        ;;
    restart)
        print_message "${YELLOW}Restarting containers with 'docker compose restart'${NC}"
        docker compose restart
        print_message "${GREEN}✓ Containers restarted successfully${NC}"
        ;;
    logs)
        print_message "${YELLOW}Showing logs with 'docker compose logs -f'${NC}"
        docker compose logs -f
        ;;
    status)
        print_message "${YELLOW}Checking container status${NC}"
        docker compose ps
        ;;
    *)
        print_message "${RED}❌ Invalid option: $1${NC}"
        print_message "${GREEN}Usage: $0 [up|down|restart|logs|status]${NC}"
        exit 1
        ;;
esac