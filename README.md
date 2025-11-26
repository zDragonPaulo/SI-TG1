# SI-TG1 - Oil Crisis and Automotive Data Analysis (1970–1982)

Overview
--------
This repository contains the materials and report for a data analysis project that explores how the 1970s oil crises affected automotive design and performance. Using vehicle data from 1970–1982 together with yearly gasoline prices, the project analyzes trends in fuel efficiency (miles per gallon), horsepower, acceleration, and production by country and brand. The final deliverable is a LaTeX report (Relatorio.tex) describing the methodology, findings and a proposed data warehouse design.

Key findings (summary)
- Average fuel efficiency (MPG) increased across the period (1970 → 1982).
- Average horsepower declined significantly, reflecting downsizing and efficiency-focused engine changes.
- Average 0–60 acceleration times increased (vehicles became slower), consistent with lower power outputs.
- The number of vehicles in the dataset remained broadly stable; market share shifted (notably more efficient Japanese models gaining share).
- These trends correlate with rising fuel prices during the 1973 and 1979 oil crises.

Data sources
------------
- Vehicle dataset: Auto MPG style dataset (393 records; features include MPG, cylinders, displacement, horsepower, weight, acceleration, year, origin, and name). Sourced from public datasets referenced in the report (Kaggle and/or US Department of Energy).
- Fuel prices: Average gasoline price by year (1970–1982) — US national annual averages.
- Bibliography and references are included in `Recursos/referencias.bib`.

Tools & technologies
--------------------
- Data cleaning & transformation: Microsoft Excel with Power Query
- Data warehouse & storage: Microsoft SQL Server / SQL Server Management Studio (SSMS)
- Reporting: LaTeX (Biber + APA style), compiled from `Relatorio.tex`
- Development & collaboration: Git, GitHub, Visual Studio Code
- Visualizations: Excel PivotTables and charts (dynamic)

Repository layout (expected)
---------------------------
- Relatorio.tex — LaTeX source of the report (Portuguese original)
- Recursos/ — images, bibliography file (`referencias.bib`), and other assets referenced by the report
- data/ (optional) — raw CSVs used (Auto MPG and fuel prices). If not present, add original CSVs here.
- sql/ (optional) — SQL scripts to create/load the data warehouse
- README.md — this file

Reproduce the analysis
----------------------
1. Clone the repository:
   git clone https://github.com/zDragonPaulo/SI-TG1.git

2. Prepare data:
   - Place the original CSV files (vehicle data and yearly fuel prices) in `data/` (create the folder if needed).
   - Open Excel → Data → Get & Transform (Power Query) and import both CSVs.
   - Clean and transform in Power Query:
     - Fix decimal separators (replace commas with dots where needed).
     - Convert data types for numeric columns (MPG, horsepower, weight, acceleration, price).
     - Split vehicle `Name` into `Brand` and `Model`.
     - Standardize brand and country names (e.g., "Chevy" → "Chevrolet", "VW" → "Volkswagen").
     - Remove duplicates and handle missing values (drop or impute as appropriate).
     - Join fuel price table to vehicle table by year (year format alignment: 70 → 1970).

3. Create Data Warehouse (example)
   - Design: Star schema with a central FactVehicle table and dimensions: DimYear, DimBrand, DimOrigin, DimFuelPrice.
   - Example SQL skeleton (run in SSMS):
     ```sql
     CREATE TABLE DimYear (
       YearID INT PRIMARY KEY,
       YearValue INT
     );
     CREATE TABLE DimBrand (
       BrandID INT PRIMARY KEY,
       BrandName VARCHAR(100)
     );
     CREATE TABLE DimOrigin (
       OriginID INT PRIMARY KEY,
       Country VARCHAR(100)
     );
     CREATE TABLE DimFuelPrice (
       PriceID INT PRIMARY KEY,
       YearID INT,
       AvgPrice DECIMAL(10,2)
     );
     CREATE TABLE FactVehicle (
       VehicleID INT PRIMARY KEY,
       YearID INT,
       BrandID INT,
       OriginID INT,
       MPG DECIMAL(6,2),
       Horsepower INT,
       Acceleration DECIMAL(6,2),
       Weight INT,
       Displacement DECIMAL(6,2)
     );
     ```
   - Load the cleaned data from Excel or CSV into the DW tables.

4. Analysis & visualization:
   - Use Excel PivotTables and charts (or Power BI) against the DW to compute yearly averages, trends by origin/brand, and correlation with fuel price.
   - Reproduce figures shown in the LaTeX report (MPG vs year, horsepower vs year, acceleration vs year, counts by year).

5. Build the PDF report:
   - Install LaTeX and Biber.
   - Compile:
     pdflatex Relatorio.tex
     biber Relatorio
     pdflatex Relatorio.tex
     pdflatex Relatorio.tex
   - Resulting PDF is the written report with figures referenced from `Recursos/`.

Authors & contact
-----------------
- Martinho José Novo Caeiro — 23917
- Paulo António Tavares Abade — 23919
- Supervisor: Isabel Sofia Brito

License
-------
- This repository is licensed under the GNU General Public License v3.0 (GPL-3.0).

