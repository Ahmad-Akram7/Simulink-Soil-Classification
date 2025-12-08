# Assignment 3: Soil Classification Models

### **By:Ahmad Akram**

---

### **Introduction**

For this assignment, I made two models using Simulink. These models help figure out what type of soil you have based on some test results. One model uses the USCS (Unified Soil Classification System) and the other one uses the AASHTO system.

I wrote MATLAB scripts that build the models automatically.

---

### **Part 1: The USCS Model**

This model classifies soil using the USCS rules.

**How it Works:**
The model takes three numbers as input: Percent Passing Sieve #200, Liquid Limit (LL), and Plastic Limit (PL). It first calculates the Plasticity Index (PI = LL - PL). Then, a bunch of logic blocks check if the numbers are bigger or smaller than the standard values. Based on these checks, it uses Switch blocks to pick the right soil type, like 'CH' or 'CL', and shows it on a Display.

**(A picture of the USCS_Soil_Model.slx would go here)**

---

### **Part 2: The AASHTO Model**

This model does the same thing but for the AASHTO system.

**How it Works:**
It uses the same three inputs (P200, LL, PL). The logic is a bit different because AASHTO has different rules. For example, it checks if PI is bigger than LL-30. Just like the other model, it uses logic and switch blocks to find the right classification, like 'A-7-6', and shows it on a Display.

**(A picture of the AASHTO_Soil_Model.slx would go here)**

---

### **How to Use the Models**

1.  Open MATLAB.
2.  To create the USCS model, go to the `USCS_Model` folder and run this command:
    `create_uscs_model`
3.  To create the AASHTO model, go to the `AASHTO_Model` folder and run this command:
    `create_aashto_model`
4.  Open the `.slx` file that was just created in each folder.
5.  Double-click the `Constant` blocks on the left to change the input values.
6.  Click the green "Run" button to see the result.

---

### **Sample Results**

I tested it with one type of soil to make sure it works.

**Test Soil: A Clay Soil**
-   **Inputs:**
    -   Percent Passing #200 = 60
    -   Liquid Limit = 55
    -   Plastic Limit = 35
-   **Results:**
    -   The USCS Model showed: `CH`
    -   The AASHTO Model showed: `A-7-6`

This shows the models are working correctly for this type of soil.
