#!/usr/bin/env bash
# Ubuntu with Python 3.10+; execute from the extracted crispr_planning_agent directory.
# This script installs dependencies and runs an explicitly NON-AI offline preview.
set -euo pipefail
python3 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
python agent_planner.py --brief example_brief.json --offline-preview --out offline_preview
python -m pip freeze > offline_preview/installed_versions.txt

# If venv is unavailable, install before running:
# sudo apt update
# sudo apt install python3-venv python3-pip

# LIVE AI AGENT — copy these commands separately:
# source .venv/bin/activate
# cp example_brief.json my_brief.json
# nano my_brief.json
# read -rsp 'OpenAI API key: ' OPENAI_API_KEY
# export OPENAI_API_KEY
# read -rp 'Tool-calling OpenAI model ID available to your account: ' OPENAI_MODEL
# export OPENAI_MODEL
# python agent_planner.py --brief my_brief.json --model "$OPENAI_MODEL" --out live_plan
# python -m pip freeze > live_plan/installed_versions.txt
# unset OPENAI_API_KEY

# OPTIONAL NCBI metadata lookup (for an endogenous gene, not the reporter demo):
# read -rp 'Email for NCBI requests: ' NCBI_EMAIL
# export NCBI_EMAIL
# python agent_planner.py --brief my_brief.json --model "$OPENAI_MODEL" --enable-ncbi --out live_plan_ncbi
# The NCBI search receives the gene symbol, organism and contact email.
# Use a fresh --out directory per run. Keys are not stored in output files.
