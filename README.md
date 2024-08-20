# JuliaSimulation
Juliaによるシミュレーションの練習用レポジトリ

[![Build Status](https://github.com/yyasui/JuliaSimulation.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/yyasui/JuliaSimulation.jl/actions/workflows/CI.yml?query=branch%3Amain)

# Requirement
- Ubuntu 22.04.3 LTS
- Julia v1.10

# Installation
## Install julia

```shell
curl -fsSL https://install.julialang.org | sh
```

※実行後、Ubuntuを再起動する

## Auto activate Julia

JuliaのPERL立ち上げ時に、仮想環境をactivateし、かつモジュールの再インポートを自動で行うようにする

1. 設定ファイルの作成
```shell
mkdir -p ~/.julia/config/ | touch ~/.julia/config/startup.jl
```

2. `vi`等で設定ファイルを以下にする
```julia
using Pkg
using Revise

if isfile("Project.toml") && isfile("Manifest.toml")
    Pkg.activate(".")
end
```

# Usage
## 1. PERLの立ち上げ

```shell
julia
```

## 2. JuliaSimulationモジュールのインポート

```julia
using JuliaSimulation
```

## 3. シミュレーション実行

```julia
JuliaSimulation.function()
```

**実装済のシミュレーター**

| スクリプト | 内容 | コード |
| --- | --- | --- |
| `JuliaSimulation.knapsack_ga()` | GAアルゴリズムによるナップサック問題の最適化 | [src/knapsack_ga/](./src/knapsack_ga/) |
| `JuliaSimulation.double_pendulum()` | 二重振り子シミュレーション | [src/double_pendulum/](./src/double_pendulum/) |

# Refarence
- [Juliaではじめる数値計算入門](https://www.amazon.co.jp/Julia%E3%81%A7%E3%81%AF%E3%81%98%E3%82%81%E3%82%8B%E6%95%B0%E5%80%A4%E8%A8%88%E7%AE%97%E5%85%A5%E9%96%80-%E6%B0%B8%E4%BA%95-%E4%BD%91%E7%B4%80/dp/4297141280)
