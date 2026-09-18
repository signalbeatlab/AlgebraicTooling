# StockFlow.jl Demos

This folder contains small standalone scripts for **[StockFlow.jl](https://github.com/AlgebraicJulia/StockFlow.jl)**.

## Script Index

* `repo1/repo1_01_seirh.jl` — SEIRH model
* `repo1/repo1_02_seiv.jl` — SEIV model, with vaccination dynamics
* `repo1/repo1_03_eiar.jl` — EIAR model
* `repo1/repo1_04_relation.jl` — Relational composition example
* `repo1/repo1_05_compose_covid19.jl` — COVID-19 model composition
* `repo1/repo1_06_solve_ode.jl` — COVID-19 model solution 

* `paper1/paper1_01_seir_measles.jl` — SEIR model, for measles

## Original Sources

Xiaoyan Li, Copyright © 2021-2022:
* `repo1/orig/Covid19_composition_model_in_paper.ipynb` — Notebook from `StockFlow.jl` codebase 
* `paper1/orig/examplesInPaperOfMfPH.ipynb` — Notebook supplement for paper, referenced below

## Developer Quickstart

Run from your terminal: 

```bash
# 1. Instantiate the pinned package environment
julia --project=. -e 'using Pkg; Pkg.instantiate()'

# 2. Execute any repo1 script
julia --project=. repo1/repo1_01_seirh.jl
```

## Reference

* John C. Baez, Xiaoyan Li, Sophie Libkind, Nathaniel D. Osgood, Eric Redekopp, 
[A Categorical Framework for Modeling with Stock and Flow Diagrams](https://arxiv.org/abs/2211.01290), 
arXiv:2211.01290 [math.CT] (2022).

## Julia Setup

Add to .zshrc etc.
* export JULIA_PROJECT=@/users/tanzer/git/StockFlow.jl

## Licensing

All code here under the [MIT License](./LICENSE).
