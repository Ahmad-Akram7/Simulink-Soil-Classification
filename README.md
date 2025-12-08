# Simulink Soil Classification Models for Civil Engineering

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A collection of simple Simulink models for classifying soil according to the **USCS (Unified Soil Classification System)** and **AASHTO (American Association of State Highway and Transportation Officials)** systems. This project is intended as an educational tool for civil engineering students and a quick reference for professionals.

## Features

-   **USCS Model**: Classifies fine-grained soils based on laboratory test results.
-   **AASHTO Model**: Classifies soils to assess their suitability for road and highway construction.
-   **Ready to Use**: No need to generate the models. Just open the `.slx` files and run the simulation.

## Getting Started

To use these models, you will need **MATLAB** and **Simulink**.

### 1. Clone the Repository

First, clone this repository to your local machine using Git:

```bash
git clone https://github.com/Ahmad-Akram7/Simulink-Soil-Classification.git
```

### 2. Run a Simulation

1.  Open either the `USCS_Model/USCS_Soil_Model.slx` or `AASHTO_Model/AASHTO_Soil_Model.slx` file in Simulink.
2.  On the left side of the model, you will find three `Constant` blocks:
    -   `PercentPassing200`
    -   `LiquidLimit`
    -   `PlasticLimit`
3.  Double-click on each block to change the input values for your soil sample.
4.  Click the **Run (▶)** button in the Simulink toolbar to execute the simulation.
5.  The resulting soil classification will appear in the **Display** block on the right.

## Models Overview

### USCS Model

This model takes the percent of soil passing the #200 sieve, the Liquid Limit (LL), and the Plastic Limit (PL) to classify fine-grained soils as 'CH' (high-plasticity clay), 'CL' (low-plasticity clay), 'MH' (high-plasticity silt), or 'ML' (low-plasticity silt).

![USCS Model](Report/USCS%20MODEL.png)

### AASHTO Model

This model uses the same inputs to classify the soil into groups like 'A-7-6', which helps in determining the quality of the soil for use as a subgrade material in pavement structures.

![AASHTO Model](Report/AASHTO%20MODEL.png)

## Example

Let's test the models with a sample clay soil.

-   **Inputs:**
    -   Percent Passing #200: `60`
    -   Liquid Limit: `55`
    -   Plastic Limit: `28`
-   **Results:**
    -   **USCS Model Output**: `'CH'`
    -   **AASHTO Model Output**: `'A-7-6'`

This demonstrates that the models are working as expected for this soil type.

## Contributing

Contributions are welcome! If you find a bug or have an idea for an improvement, please feel free to open an issue or submit a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.