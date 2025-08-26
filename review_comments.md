----------------------------------------
Reviewer: 1

Comments to the Author
1.General comments:

The manuscript "Application of qualifying variants for genomic analysis" presents a thoughtful and well-motivated framework for treating qualifying variants (QVs) as standalone, structured, and reusable elements in genomic analysis pipelines. The authors clearly address the limitations of current QV filtering approaches and convincingly demonstrate that decoupling QV criteria from pipeline code improves clarity, reproducibility, and interdisciplinary communication. The proposed YAML-based implementation is practical, aligns well with FAIR principles, and is validated in a rare disease cohort where it matches conventional methods. The paper is well-written and includes a detailed discussion of the results. There is an opportunity to further discuss how this framework could enhance the traceability and transparency of variant interpretation in clinical and research settings. I have some comments below to suggest improvements for the manuscript.

2. a. Major comments:

- The authors describe how the QV YAML file and its unique identifier enable traceability of variant interpretation. To make this clearer, the authors could include a concrete example illustrating how a clinician or analyst would use the QV set ID to retrieve the exact criteria applied to a reported variant—for example, during audit, re-analysis, or regulatory review.

- The validation is limited to ACMG criteria in a rare disease cohort. Testing the framework in other contexts (e.g., GWAS, polygenic risk scores, structural variant analyses) would help demonstrate its generalizability.

- It would be helpful to include some discussion or benchmarking of the computational overhead (if any) and scalability of using YAML-based QVs compared to hard-coded scripts.

- The authors highlight the potential of including Public and Patient Involvement and Engagement (PPIE) fields in the QV files. However, it would be helpful to provide an example of how patient preferences were recorded and how they influenced an analysis or report.

b. Miner comments:
- There are typographical errors (e.g., “varaints” → “variants”) that should be corrected.

- Box 2 provides a helpful YAML snippet, but readers unfamiliar with YAML might still benefit from a brief primer or a few lines of explanation in the main text or supplementary materials to help them better understand the YAML syntax and structure.

Thanks,




Reviewer: 2

Comments to the Author
The authors propose a framework to apply and combine different filtering sets to identify qualifying variants for genomic analysis. While this approach might be convenient, I think it lacks novelty as various analysis tools offer user-friendly filtering approaches (e.g. VarFish). Please find my major comments below. I would appreciate a more extensive description of the gap that this framework is filling.

1) The chapter regarding implementation lacks technical clarity, i.e. how is the framework implemented, which input does it require, which is the output, etc.
2) The authors mention that their criteria are aligned with FAIR principles. Could they elaborate on this and justify this statement?
3) The validation study showcases the agreement with hard-coded criteria for one example data set. Could the authors add a more comprehensive comparison by extending the validation study to different data sets and use cases?
4) Can users specify their own filtering criteria for QVs and safe them as a QV set? Can the authors showcase how to do that?
----------------------------------------
