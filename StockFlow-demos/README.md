# StockFlow.jl Demos

This folder contains small standalone scripts for **[StockFlow.jl](https://github.com/AlgebraicJulia/StockFlow.jl)**.

## Script Index

* `repo1/repo1_01_seirh.jl` — SEIRH epidemiological model refactoring
* `repo1/repo1_02_seiv.jl` — SEIV model with vaccination dynamics
* `repo1/repo1_03_eiar.jl` — EIAR model formulation
* `repo1/repo1_04_relation.jl` — Relational composition examples
* `repo1/repo1_05_compose_covid19.jl` — Multi-layer COVID-19 model composition
* `repo1/repo1_06_solve_ode.jl` — Dynamic ODE solving pipeline

* `paper1/paper1_01_seir_measles.jl` — Complex SEIR measles refactoring

## Original Sources

* `repo1/orig/Covid19_composition_model_in_paper.ipynb` — Notebook from `StockFlow.jl` codebase (Copyright © 2022 Xiaoyan Li)
* `repo1/orig/Covid19_composition_model_in_paper.jl` — Standalone Julia conversion of upstream notebook
* `paper1/orig/paper1.ipynb` — Official paper notebook supplement (Copyright © 2021 Xiaoyan Li)

## Developer Quickstart

Run from your terminal: 

```bash
# 1. Instantiate the pinned package environment
julia --project=. -e 'using Pkg; Pkg.instantiate()'

# 2. Execute any repo1 script
julia --project=. repo1/repo1_01_seirh.jl
```

## Background Paper 

> **Compositional Modeling with Stock and Flow Diagrams**  
> *Xiaoyan Li, Evan Patterson, Nathaniel D. Osgood* (2021/2022)

## Julia Setup

Add to .zshrc etc.
* export JULIA_PROJECT=@/users/tanzer/git/StockFlow.jl

## Licensing

All code here under the [MIT License](./LICENSE).
