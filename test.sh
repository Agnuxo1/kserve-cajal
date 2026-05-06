#!/bin/bash
# Test script for CAJAL KServe deployment
# Requires: curl, jq

ENDPOINT=${ENDPOINT:-"http://cajal-paper-generator.default.svc.cluster.local"}

echo "=== CAJAL KServe Test ==="
echo "Endpoint: $ENDPOINT"
echo ""

# Test 1: Health check
echo "Test 1: Health check..."
curl -s "$ENDPORT/v1/models" | jq '.models[] | select(.name | contains("cajal"))'

# Test 2: Generate paper
echo ""
echo "Test 2: Generate paper..."
curl -s "$ENDPOINT/v1/completions" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "cajal",
    "prompt": "Generate a paper about renewable energy storage: [ABSTRACT]",
    "max_tokens": 2048,
    "temperature": 0.7
  }' | jq '.choices[0].text'

# Test 3: Full paper with all sections
echo ""
echo "Test 3: Full paper with all sections..."
curl -s "$ENDPOINT/v1/completions" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "cajal",
    "prompt": "Generate a complete paper about CRISPR applications in agriculture with these sections: [ABSTRACT] [INTRO] [METHODS] [RESULTS] [CONCLUSIONS]",
    "max_tokens": 4096,
    "temperature": 0.7
  }' | jq '.choices[0].text'

echo ""
echo "=== Test complete ==="
