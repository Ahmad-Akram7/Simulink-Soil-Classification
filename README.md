<div align="center">

<br/>

```
 ____  _____  ____  __      ___   __   ____  ____  ____  ____
/ ___)(  _  )(_  _)(  )    / __) (  ) (  __)(_  _)(_  _)(_  _)
\___ \ )(_)(  _)(_  )(__  ( (__   )(   ) _)   )(    )(   _)(_
(____/(_____)(____)(____)  \___) (__) (__)   (__)  (__) (____) 
```

# 🪨 Simulink Soil Classification Models

**USCS & AASHTO Soil Classification — Powered by MATLAB/Simulink**

[![MATLAB](https://img.shields.io/badge/MATLAB-R2023b%2B-0076A8?style=for-the-badge&logo=mathworks&logoColor=white)](https://www.mathworks.com/products/matlab.html)
[![Simulink](https://img.shields.io/badge/Simulink-R2023b%2B-e60000?style=for-the-badge&logo=mathworks&logoColor=white)](https://www.mathworks.com/products/simulink.html)
[![License: MIT](https://img.shields.io/badge/License-MIT-22c55e?style=for-the-badge)](https://opensource.org/licenses/MIT)
[![Standard: ASTM D2487](https://img.shields.io/badge/Standard-ASTM%20D2487-f59e0b?style=for-the-badge)]()
[![Standard: AASHTO M145](https://img.shields.io/badge/Standard-AASHTO%20M145-8b5cf6?style=for-the-badge)]()

*An educational toolkit for civil engineers and students — classify soils in seconds, straight from Simulink.*

[📦 Get Started](#-getting-started) · [📐 Models](#-models-overview) · [🧪 Example](#-example-run) · [🤝 Contributing](#-contributing)

</div>

---

## 📌 What Is This?

This repository provides **two plug-and-play Simulink models** that classify soil samples using the two most widely used geotechnical standards:

| Model | Standard | Purpose |
|-------|----------|---------|
| 🟦 **USCS** | ASTM D2487 | Fine-grained soil classification (CH, CL, MH, ML…) |
| 🟧 **AASHTO** | AASHTO M 145 | Highway subgrade suitability (A-1 through A-7-6) |

Both models accept the same three laboratory inputs and instantly output a standardized soil group symbol — no coding required.

> **Who is this for?**
> - 🎓 Civil engineering students learning soil mechanics
> - 🏗️ Geotechnical engineers wanting a fast sanity-check tool
> - 🧑‍🏫 Instructors looking for visual, interactive teaching aids

---

## ⚡ Getting Started

### Prerequisites

Make sure you have the following installed:

- [MATLAB R2023b+](https://www.mathworks.com/products/matlab.html)
- [Simulink](https://www.mathworks.com/products/simulink.html) (included with most MATLAB licenses)

### 1 — Clone the Repository

```bash
git clone https://github.com/Ahmad-Akram7/Simulink-Soil-Classification.git
cd Simulink-Soil-Classification
```

### 2 — Open a Model

Navigate to either model folder and open the `.slx` file:

```
USCS_Model/
└── USCS_Soil_Model.slx   ← Open this in Simulink

AASHTO_Model/
└── AASHTO_Soil_Model.slx ← Or this one
```

### 3 — Set Your Inputs

On the **left side** of the model, locate the three `Constant` input blocks:

| Block Name | Description | Typical Range |
|---|---|---|
| `PercentPassing200` | % of soil passing sieve #200 | 0 – 100 |
| `LiquidLimit` | Atterberg Liquid Limit (LL) | 20 – 100+ |
| `PlasticLimit` | Atterberg Plastic Limit (PL) | 10 – 60+ |

> 💡 **Tip:** Double-click any `Constant` block to edit its value.

### 4 — Run & Read Output

Click the **▶ Run** button in the Simulink toolbar.  
The **Display** block on the right shows your classification result immediately.

---

## 📐 Models Overview

### 🟦 USCS Model — `USCS_Soil_Model.slx`

> **Standard:** ASTM D2487 — *Unified Soil Classification System*

Classifies fine-grained soils using plasticity characteristics derived from Atterberg limits.

**Possible Output Symbols:**

| Symbol | Soil Type | Description |
|--------|-----------|-------------|
| `CH` | High-plasticity Clay | Expansive, compressible — poor foundation material |
| `CL` | Low-plasticity Clay | Moderate plasticity, common subgrade soil |
| `MH` | High-plasticity Silt | Elastic, frost-susceptible |
| `ML` | Low-plasticity Silt | Low plasticity, frost-susceptible |

**Decision Logic (simplified):**

```
IF % Passing #200 ≥ 50 → Fine-Grained Soil
  Plasticity Index (PI) = LL - PL
  IF LL ≥ 50 → High Plasticity (H)
  ELSE       → Low Plasticity (L)

  IF plots ABOVE A-line → Clay (C)
  ELSE                  → Silt (M)
```

![USCS Model](Report/USCS%20MODEL.png)

---

### 🟧 AASHTO Model — `AASHTO_Soil_Model.slx`

> **Standard:** AASHTO M 145 — *Classification of Soils and Soil-Aggregate Mixtures*

Assesses soil suitability for use as **road subgrade material** in pavement construction.

**Output Groups (A-Scale):**

| Group | Description | Subgrade Quality |
|-------|-------------|-----------------|
| `A-1` | Stone fragments, gravel, sand | ⭐⭐⭐ Excellent |
| `A-2` | Silty or clayey gravel/sand | ⭐⭐⭐ Good |
| `A-3` | Fine sand | ⭐⭐ Good |
| `A-4` | Silty soil | ⭐⭐ Fair |
| `A-5` | Silty soil (elastic) | ⭐ Poor |
| `A-6` | Clayey soil | ⭐ Poor |
| `A-7-5` | Clayey soil (elastic) | ⭐ Poor |
| `A-7-6` | Clayey soil (expansive) | ⭐ Very Poor |

![AASHTO Model](Report/AASHTO%20MODEL.png)

---

## 🧪 Example Run

Here's a complete worked example using a high-plasticity clay sample:

### Inputs

```yaml
Percent Passing #200 Sieve:  60%
Liquid Limit (LL):           55
Plastic Limit (PL):          28
Plasticity Index (PI):       27   # Computed: LL - PL
```

### Results

<table>
<tr>
<td align="center" width="50%">

**🟦 USCS Output**

```
CH
(High-Plasticity Clay)
```

LL = 55 > 50 → High plasticity  
PI = 27 → Plots above A-line → Clay

</td>
<td align="center" width="50%">

**🟧 AASHTO Output**

```
A-7-6
(Expansive Clayey Soil)
```

High fines + high LL + high PI  
→ Poorest subgrade category

</td>
</tr>
</table>

> ✅ Both models correctly identify this as a high-plasticity clay — a soil type that engineers must treat carefully due to its **shrink-swell behavior** and **low bearing capacity**.

---

## 🗂️ Repository Structure

```
Simulink-Soil-Classification/
│
├── 📁 USCS_Model/
│   └── USCS_Soil_Model.slx          # USCS Simulink model
│
├── 📁 AASHTO_Model/
│   └── AASHTO_Soil_Model.slx        # AASHTO Simulink model
│
├── 📁 Report/
│   ├── USCS MODEL.png               # USCS model screenshot
│   └── AASHTO MODEL.png             # AASHTO model screenshot
│
├── LICENSE                          # MIT License
└── README.md                        # This file
```

---

## 🔑 Key Concepts Glossary

| Term | Definition |
|------|-----------|
| **Sieve #200** | 0.075 mm opening — separates fine from coarse-grained soils |
| **Liquid Limit (LL)** | Water content at which soil transitions from plastic to liquid state |
| **Plastic Limit (PL)** | Water content below which soil behaves as a semi-solid |
| **Plasticity Index (PI)** | PI = LL − PL; measures the range of plastic behavior |
| **A-line** | Boundary on the Casagrande plasticity chart separating clays (C) from silts (M) |
| **USCS** | Unified Soil Classification System — general geotechnical use |
| **AASHTO** | American Association of State Highway and Transportation Officials standard |

---

## 🤝 Contributing

Contributions are warmly welcomed! Here's how to get involved:

1. **Fork** the repository
2. **Create** a feature branch: `git checkout -b feature/coarse-grained-uscs`
3. **Commit** your changes: `git commit -m 'Add coarse-grained soil classification'`
4. **Push** to the branch: `git push origin feature/coarse-grained-uscs`
5. **Open** a Pull Request

### 💡 Ideas for Contributions

- [ ] Add coarse-grained USCS classification (GW, GP, SW, SP…)
- [ ] Extend AASHTO to include Group Index (GI) calculation
- [ ] Add a MATLAB Live Script companion for step-by-step walkthroughs
- [ ] Create a standalone App Designer GUI for non-Simulink users
- [ ] Add input validation blocks for out-of-range values

Please open an [issue](https://github.com/Ahmad-Akram7/Simulink-Soil-Classification/issues) first for major changes so we can discuss the approach.

---

## 📄 License

This project is released under the **MIT License** — free to use, modify, and distribute.  
See the [LICENSE](LICENSE) file for full details.

---

<div align="center">

**Built for engineers, by engineers.**  
If this saved you time, consider ⭐ starring the repo!

*Made with ☕ and a deep appreciation for geotechnical engineering*

</div>
