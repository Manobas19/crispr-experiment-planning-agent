# CRISPR experiment planning with a pre-existing AI agent framework

This package configures LangChain's existing `create_agent` tool-calling loop for CRISPR study planning. It does not train a new model. It is **not the official CRISPR-GPT package**, nor a pretrained CRISPR-specific model. A compatible pretrained OpenAI chat model supplies the language reasoning.

## What it creates
A reviewable plan containing the hypothesis, design rationale, control groups, primary phenotype endpoint, replication and power considerations, randomization/blinding, guide-design requirements, molecular validation, analysis steps, limitations and missing information.

The agent can call three tools:
1. `get_plan_context`: reads your structured brief and checks missing design information.
2. `get_tool_capabilities`: describes available software capabilities and verified documentation links.
3. `find_target_metadata`: optionally queries NCBI Gene through Biopython for the supplied gene symbol and organism. Returns candidates, not verified gene-function conclusions. NCBI lookup is off by default and is unsuitable for the example transgene.

The required context and capabilities calls are verified before exporting a live plan. Pydantic checks the output structure. These checks do not guarantee scientific correctness.

## Live AI versus offline preview
**Live:** calls a tool-capable OpenAI model through LangChain. Requires internet, a valid API key and a model available to your API account. API use may incur charges. The brief and tool results are sent to the model provider. Do not put credentials or unnecessary private data in the brief.
**Offline preview:** a fixed educational template; makes no model or NCBI calls. It demonstrates the export format only. It is clearly labeled `OFFLINE_TEMPLATE_NOT_AI`.

No API key is bundled. Enter keys through a hidden prompt or environment variable, never by editing a notebook cell with the key. The model name is configurable instead of assuming account access to a specific model. Use a model supporting tool calling and structured output. The loop limit and output-token setting limit work but are not a hard currency spending cap. No live API request was made during authoring.

## Google Colab / Jupyter
Open https://colab.research.google.com/ → upload `CRISPR_Experiment_Planning_Agent.ipynb` → run the cells in order.
The notebook embeds the complete program, installs dependencies, and defaults to live mode. It prompts securely for an API key and asks for your model ID. Edit the example brief first. Set LIVE_AGENT=False only if you want the fixed preview.

The default example asks whether perturbing an existing fluorescent reporter reduces fluorescence in a cultured-cell reporter system. The cell line, construct and integration details are intentionally unresolved; they must not be inferred by the model. Replace this with your own research question, organism, target gene and model system.

## Ubuntu (Python 3.10+)
Run from the extracted `crispr_planning_agent` directory:

```bash
python3 -m venv .venv
source .venv/bin/activate
python -m pip install -r requirements.txt
python agent_planner.py --brief example_brief.json --offline-preview --out offline_preview
```

For a real agent run:

```bash
cp example_brief.json my_brief.json
nano my_brief.json
read -rsp 'OpenAI API key: ' OPENAI_API_KEY
export OPENAI_API_KEY
read -rp 'Compatible model ID: ' OPENAI_MODEL
export OPENAI_MODEL
python agent_planner.py --brief my_brief.json --model "$OPENAI_MODEL" --out live_plan
python -m pip freeze > live_plan/installed_versions.txt
unset OPENAI_API_KEY
```

Optional NCBI lookup requires `NCBI_EMAIL` and `--enable-ncbi`. NCBI receives the gene query, organism and contact email. For multiple/ambiguous results the tool does not choose a gene automatically. For reporter transgenes supply the actual construct information separately; do not treat an endogenous Gene database hit as the transgene reference.

## Input: JSON brief
Required: `goal`, `organism`, `target_gene`, `model_system`, `phenotype_readout`.
Optional: `perturbation` (knockout, CRISPRi, CRISPRa, undecided), `reference_build`, `available_assays`, `constraints`.
Use real details where known; use 'unspecified' and describe missing information when unknown. No FASTA, FASTQ, count matrix or patient data is required for this planning task.

## Output files
- plan.md: readable study plan.
- plan.json: structured plan.
- experimental_groups.csv: group purposes and comparisons.
- workflow.csv: actions, deliverables and completion checks.
- review_items.csv: unresolved questions.
- brief.json: the input used.
- audit.json: live/template status, model ID, tool calls, metadata, input hash and token usage if returned.
- installed_versions.txt: exact resolved dependency versions (written by notebook/commands).

Choose a fresh output folder on each run. API keys are not written to these exports. Audit records list tool calls and outputs, not hidden model reasoning. Do not publish input briefs that contain unpublished or private information unless you intend to share them.

## Scope
The agent plans a study; it does not synthesize or validate guides, score off-targets, run CRISPick, perform a literature search, calculate justified statistical power without inputs, order reagents or execute laboratory procedures. The guide-design stage is an explicit external deliverable. The supplied references document software and must not be treated as evidence for target-specific biology.

Relevant brochure tools are LangChain, Biopython and Pandas. Pydantic and langchain-openai provide validation and model access. MAGeCK is appropriate later for pooled guide-count screens; it is not automatically applicable to an arrayed experiment or amplicon editing rates. DNABERT, DeepCRISPR, Keras and SHAP are not needed for this planning task.

## Troubleshooting
- Missing key: use the hidden notebook prompt or OPENAI_API_KEY environment variable.
- Model/access error: use a tool-calling model available to your API account; the notebook does not silently switch to a different model.
- Rate/quota error: check API quota and retry later. No fixed template is silently substituted for an AI response.
- Required tool or schema validation error: inspect the brief, use a compatible model, and retry into a new output folder.
- Existing output folder: choose a new folder; existing plans are not overwritten.
- NCBI failure: run without --enable-ncbi and leave gene identity unresolved, or investigate the network/API error.

## References
https://docs.langchain.com/oss/python/langchain/agents
https://docs.langchain.com/oss/python/langchain/structured-output
https://reference.langchain.com/python/langchain-openai/chat_models/base/ChatOpenAI
https://biopython.org/docs/latest/Tutorial/chapter_entrez.html

Created 20 October 2026. Outputs require scientific review; there is no target-specific or experimental validation.
