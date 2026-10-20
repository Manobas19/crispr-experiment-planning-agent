# OFFLINE TEMPLATE — EGFP reporter transgene CRISPR study

**Mode: OFFLINE_TEMPLATE_NOT_AI**

## Hypothesis
Test the supplied goal: Plan an educational loss-of-function study asking whether disruption of an existing fluorescent reporter reduces its signal.

## Design rationale
Template preview only. Perturbation modality and target suitability need review for An established non-infectious cultured-cell reporter model; exact cell line and integration details not yet specified..

## Primary endpoint
Reporter fluorescence per viable cell compared with a matched non-targeting control.

## Groups
- **Target perturbation:** Assess the proposed gene-related phenotype with independent perturbations. Comparison: Compare with matched non-targeting control.
- **Non-targeting control:** Estimate background from the delivery and assay context. Comparison: Same model-system and assay context as target group.
- **Mock/untreated:** Identify assay and delivery-related background where appropriate. Comparison: Interpret separately from the non-targeting control.

## Replication and power
Use independent biological units; estimate required replication from pilot variance, expected effect and planned analysis. Technical repeats are not independent samples.

## Randomization and blinding
Randomize sample allocation where feasible, balance batches and mask phenotype analysis to group identity.

## Guide-design requirements
- Verify reference assembly, transcript, perturbation modality and PAM compatibility.
- Use an external guide-design tool; inspect off-target predictions, variants and independent guide agreement. No guides are generated here.

## Validation strategy
- Confirm the intended molecular perturbation separately from the phenotype.
- Assess agreement among independent guides; consider an orthogonal or rescue experiment if appropriate.

## Analysis plan
- Prespecify the primary contrast and endpoint.
- Use sample-level biological replication, suitable effect estimates and uncertainty.
- Choose methods appropriate to the actual data type; MAGeCK only applies to pooled guide-count screens.

## Missing information
- Confirm genome assembly, target transcript/isoform and exact model-system genotype before guide design.
- Define independent biological replication and estimate sample size from pilot variance and a meaningful effect size.
- Specify whether the experiment is arrayed or pooled and whether batch effects or matched samples are expected.

## Limitations
- This fixed preview is not AI-generated or target-specific biological advice.
- No sequence design, laboratory protocol execution or live evidence retrieval was performed.

## Workflow
- **Define:** Resolve target identity, model system and hypothesis. Deliverable: Reviewed study brief. Completion check: Missing context resolved.
- **Design:** Prepare control groups, guide-design requirements and assay plan. Deliverable: Reviewed design matrix. Completion check: Controls address the main confounders.
- **Evaluate:** Analyze molecular validation and prespecified phenotype separately. Deliverable: Effect estimates, uncertainty and interpretation. Completion check: Biological units and batch effects handled correctly.

## Software references (not biological evidence)
- [LangChain agents documentation](https://docs.langchain.com/oss/python/langchain/agents) — Software API; not biological evidence

This plan has not been experimentally validated. External guide design and target-specific literature review remain separate tasks.
