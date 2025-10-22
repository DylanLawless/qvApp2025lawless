# Application of qualifying variants for genomic analysis

**This repo contains only manuscript files. For the code and data used in this study see the public Zenodo repository** <https://doi.org/10.5281/zenodo.17414191>

---

Qualifying Variants (QVs) are defined, versioned criteria that determine which genomic alterations are included in an analysis. Rather than being hidden as code-level filters, QVs are externalised into human- and machine-readable YAML or JSON files that specify the exact rules applied, such as allele frequency thresholds, gene panels, or pathogenicity classifications. This makes analyses transparent, reproducible, and auditable across tools, studies, and institutions. QVs function as a common reference layer that links the technical and interpretive logic of variant analysis, ensuring that every decision in a genomic workflow is explicit, traceable, and aligned with FAIR data principles.

## How to build a QV file

We recommend YAML or JSON for portability and adoption. You can build a QV in three ways:

### option 1: use the HTML QV builder (Zenodo)

1. Open the HTML builder from the Zenodo repository.
2. Enter simple `key=value` statements in the left pane.
3. Copy or download the generated YAML.

Example input lines:

```
meta qv_set_id="qv_gwas_common_v1_20250827"
meta version="1.0.0"
meta title="GWAS common QC"
meta authors=Alice,Bob
meta tags=GWAS,QC,PCA
filter maf_minimum field=MAF operator=">=" value=0.01 desc="Minimum MAF"
filter hwe field=HWE_P operator=">=" value=1e-6 logic=keep_if
filter region_include desc="include panel" field=OVERLAP(targets.exome.bed) operator=">=" value=1 logic=keep_if
criteria disease_panel logic=and desc="HIGH impact within panel"
criteria disease_panel field=IMPACT operator="==" value=HIGH
criteria disease_panel field=OVERLAP(targets.exome.bed) operator=">=" value=1
meta description_patient="There is a strong family history of early heart attacks."
meta description_ppie="The PPIE group reviewed and approved the criteria on 2025-08-15."
```

Generated YAML:

```yaml
meta:
  qv_set_id: qv_gwas_common_v1_20250827
  version: 1.0.0
  title: GWAS common QC
  authors: [Alice, Bob]
  tags: [GWAS, QC, PCA]
  description_patient: >
    There is a strong family history of early heart attacks.
  description_ppie: >
    The PPIE group reviewed and approved the criteria on 2025-08-15.
filters:
  maf_minimum:
    description: Minimum MAF
    logic: keep_if
    field: MAF
    operator: ">="
    value: 0.01
  region_include:
    description: include panel
    logic: keep_if
    field: OVERLAP(targets.exome.bed)
    operator: ">="
    value: 1
  hwe:
    logic: keep_if
    field: HWE_P
    operator: ">="
    value: 1e-6
criteria:
  disease_panel:
    description: HIGH impact within panel
    logic: and
    conditions:
      - { field: IMPACT, operator: "==", value: HIGH }
      - { field: OVERLAP(targets.exome.bed), operator: ">=", value: 1 }
notes:
  - Implementations are hints only
```

### option 2: write YAML by hand

Minimal pattern:

```yaml
meta:
  qv_set_id: qv_disease_panel_v1_20250828
  version: 1.0.0
  title: Disease panel filter
filters:
  region_include:
    description: Restrict to curated disease gene panel
    logic: keep_if
    field: OVERLAP(targets.disease_panel.bed)
    operator: ">="
    value: 1
criteria:
  pathogenic:
    description: Variant classified as pathogenic or likely pathogenic
    logic: and
    conditions:
      - group: any_of:start
      - { field: CLASS, operator: "==", value: P }
      - { field: CLASS, operator: "==", value: LP }
      - group: any_of:end
notes:
  - Gene panel file defines the target regions
```

### option 3: write JSON

JSON equivalent of the minimal example:

```json
{
  "meta": {
    "qv_set_id": "qv_disease_panel_v1_20250828",
    "version": "1.0.0",
    "title": "Disease panel filter"
  },
  "filters": {
    "region_include": {
      "description": "Restrict to curated disease gene panel",
      "logic": "keep_if",
      "field": "OVERLAP(targets.disease_panel.bed)",
      "operator": ">=",
      "value": 1
    }
  },
  "criteria": {
    "pathogenic": {
      "description": "Variant classified as pathogenic or likely pathogenic",
      "logic": "and",
      "conditions": [
        { "group": "any_of:start" },
        { "field": "CLASS", "operator": "==", "value": "P" },
        { "field": "CLASS", "operator": "==", "value": "LP" },
        { "group": "any_of:end" }
      ]
    }
  },
  "notes": [
    "Gene panel file defines the target regions"
  ]
}
```

### Checksum, and register

Record the checksum:

```bash
sha256sum qv/examples/qv_disease_panel_v1_20250828.yaml
```

Register the release:

```csv
# qv/registry/releases.csv
qv_disease_panel_v1_20250828,1.0.0,ef6cf810b994dfd4ce5ac275bce1d2dbe2e60332d1c7af304a88c458046d79ce,qv/examples/qv_disease_panel_v1_20250828.yaml,2025-08-28
```

Versioning and IDs:

* Use a stable `qv_set_id` plus semantic version.
* Update the version on any change that affects selection or interpretation.
* Keep one file per release and never mutate published files.

## use in a workflow

Point your pipeline to the QV file:

```yaml
# workflows/.../config.yaml
qv_file: ".../qv/registry/qv_disease_panel_v1_20250828.yaml"
```

It can be read programmatically at runtime, for example using `yq` in shell-based workflows or `yaml::read\_yaml()` in R, providing the same parameters that would otherwise be embedded within pipeline configurations

## Citing

Application of qualifying variants for genomic analysis

Dylan Lawless, Ali Saadat, Mariam Ait Oumelloul, Simon Boutry, Veronika Stadler, Sabine Österle, Jan Armida, David Haerry, D. Sean Froese, Luregn J. Schlapbach, Jacques Fellay

doi: https://doi.org/10.1101/2025.05.09.25324975

## Licence

MIT. See `LICENSE`.

## Contact

[Dylan.Lawless@kispi.uzh.ch](mailto:Dylan.Lawless@kispi.uzh.ch)


## Future directions

Qualifying Variants (QVs) can be formalised as computational entities representing defined sets of genomic variants on which mathematical operations can be performed. Conceptually, QV sets function as measurable subsets of the theoretical variant space, enabling equations that link observed and unobserved genomic evidence. In statistical genetics, this allows analytical models such as logistic regression or kernel-based tests to incorporate QV-based terms, denoted ( G_{\text{QV}} ), to quantify effects derived from specific variant sets. Beyond simple filtering, QV sets provide a structured foundation for Bayesian and likelihood-based inference, allowing estimation of true positives, false negatives, and unobserved variants through relations such as ( \text{TP} = \text{QV}_{ax} \cap \text{QV}*1 ) and ( \text{FN} = \text{QV}*{ax} \setminus \text{QV}_1 ). This mathematical framing elevates QVs from practical workflow components to theoretical units in computational genetics, capable of supporting formal reasoning, uncertainty quantification, and integration into advanced probabilistic and multi-omic models.

