# Australian Road Fatality Graph Analysis

A graph-based road safety analytics project exploring patterns in Australian fatal road crashes using **Python, Neo4j, Cypher, Graph Data Modelling, and Power BI**.

The project transforms Australian road fatality data into a graph database where crashes are connected to road users, vehicles, locations, dates, times, road characteristics, and regional information. This structure enables relationship-focused analysis that would be more difficult to explore using traditional tabular data alone.

> **Portfolio Project:** This project was developed from an academic graph database project and is being extended into an end-to-end data analytics portfolio project with improved ETL, graph analytics, visualisation, and reproducibility.

---

## Project Objective

The main objective of this project is to answer:

> **How can graph analytics be used to identify patterns in Australian fatal road crashes across location, road type, demographics, vehicles, and time?**

The project investigates questions such as:

- Which locations experience higher concentrations of fatal crashes?
- How do fatal crashes vary across road-user and age groups?
- What patterns exist between crashes, vehicle types, and road conditions?
- How do crash patterns change by time of day, weekday/weekend, and year?
- Which SA4 and LGA regions appear most frequently in fatal crash records?
- How can graph relationships provide additional insight into road-safety data?

---

## Technology Stack

| Technology | Purpose |
|---|---|
| Python | Data cleaning and preprocessing |
| Pandas | Data transformation and CSV generation |
| Neo4j | Graph database |
| Cypher | Graph creation and analytical queries |
| Neo4j Graph Data Science | Advanced graph analysis |
| Power BI | Interactive dashboard and visualisation |
| Git & GitHub | Version control and project documentation |

---

## Dataset

The project uses Australian road fatality data covering approximately **2014–2024**.

The dataset contains information related to:

- Crash ID
- State
- Year and month
- Day and time
- Crash type
- Number of fatalities
- Road-user type
- Gender
- Age and age group
- Vehicle involvement
- Speed limit
- Road type
- Local Government Area (LGA)
- Statistical Area Level 4 (SA4)
- Remoteness classification
- Weekday/weekend
- Day/night
- Christmas and Easter periods

The raw dataset is stored in:

```text
data/raw/
```

Processed Neo4j-ready datasets are generated into:

```text
data/processed/
```

---

## Project Architecture

The project follows the pipeline:

```text
Australian Road Fatality Dataset
              │
              ▼
       Python / Pandas ETL
              │
              ▼
       Cleaned CSV Files
              │
              ▼
       Neo4j Graph Database
              │
       ┌──────┴───────┐
       ▼              ▼
 Cypher Analysis    Graph Data Science
       │              │
       └──────┬───────┘
              ▼
         Key Insights
              │
              ▼
      Power BI Dashboard
```

---

## Graph Data Model

The graph is designed around a central **Crash** node.

A crash can be connected to information about:

```text
                     RoadUser
                        │
                        │ INVOLVES
                        ▼
Vehicle ───────────── Crash ───────────── Date
                        │
                        │
                ┌───────┼────────┐
                ▼       ▼        ▼
              Time    State     LGA
                                 │
                                 ▼
                                SA4

Crash ───── RoadDetails
  │
  └──────── Remoteness
```

Major node types include:

- `Crash`
- `RoadUser`
- `Vehicle`
- `Date`
- `Time`
- `State`
- `LGA`
- `SA4`
- `Remoteness`
- `RoadDetails`

The crash-centred design makes it possible to traverse relationships between fatalities, vehicles, geographic regions, temporal information, and road characteristics.

A detailed graph schema image will be available here:

```text
images/graph_schema.png
```

---

## Data Preprocessing

Data preprocessing is performed using Python and Pandas.

The preprocessing pipeline includes:

1. Loading the raw road-fatality dataset.
2. Standardising column names.
3. Cleaning and renaming selected attributes.
4. Handling geographic attributes such as LGA, SA4, and remoteness.
5. Creating unique identifiers for road-user records.
6. Removing duplicate node records where appropriate.
7. Creating individual CSV files for Neo4j nodes.
8. Creating relationship CSV files.
9. Exporting processed files for graph creation.

The preprocessing script is located at:

```text
src/preprocess.py
```

---

## Neo4j Graph Construction

Neo4j is used to represent the road-fatality dataset as a network of connected entities.

The graph construction script:

```text
cypher/create_graph.cypher
```

is responsible for:

- Creating graph entities
- Loading node data
- Creating relationships
- Connecting crashes with road users
- Connecting crashes with vehicles
- Connecting crashes with temporal information
- Connecting crashes with geographic regions
- Connecting crashes with road characteristics

The project uses Cypher commands such as:

```cypher
LOAD CSV
MERGE
MATCH
CREATE
RETURN
```

to construct and query the graph.

---

## Road Safety Analysis

Cypher queries are used to investigate several road-safety questions.

Examples include:

### Articulated Truck Crashes in Western Australia

Analysis of fatal crashes involving articulated trucks in Western Australia between 2020 and 2024, including crashes involving multiple fatalities.

### Young Driver Fatal Crashes

Analysis of drivers aged approximately 17–25 and comparison of fatal crashes occurring on weekdays and weekends across Australian states.

### Peak-Hour Crash Locations

Identification of SA4 regions with high numbers of fatal crashes during morning and afternoon peak periods.

### Motorcycle Rider Demographics

Analysis of motorcycle rider fatalities using demographic, holiday-period, gender, age, and regional information.

### Pedestrian Fatalities

Analysis of pedestrian fatal crashes involving selected heavy vehicles and different speed-limit conditions.

### Road Type and Time of Day

Investigation of how fatal crash frequency changes across different road types and times of day.

### LGA Crash Patterns

Identification of Local Government Areas appearing frequently in fatal crash records.

The analytical Cypher queries are stored in:

```text
cypher/analysis_queries.cypher
```

---

## Graph Data Science

The portfolio version of this project extends the original graph database implementation using the **Neo4j Graph Data Science (GDS)** library.

This section will investigate whether graph algorithms can reveal additional relationships or important locations that are not immediately visible from aggregate crash counts.

Planned analysis includes graph-based ranking and/or community analysis.

The implementation will be stored in:

```text
cypher/gds_analysis.cypher
```

> **Status:** In development.

---

## Power BI Dashboard

A Power BI dashboard will complement the Neo4j analysis by presenting the major findings in an accessible visual format.

Planned dashboard elements include:

**Key Performance Indicators**

- Total fatal crashes
- Total fatalities
- Average victim age
- Most affected state

**Visual Analysis**

- Fatal crashes by year
- Fatal crashes by state
- Fatal crashes by road type
- Day vs night crashes
- Fatalities by age group
- Young-driver weekday vs weekend patterns
- Peak-hour crashes by SA4
- LGA crash hotspots

The dashboard file will be stored in:

```text
dashboard/road_safety_dashboard.pbix
```

A dashboard preview will be added to:

```text
images/dashboard.png
```

> **Status:** In development.

---

## Repository Structure

```text
australian-road-fatality-graph-analysis/
│
├── README.md
├── requirements.txt
├── .gitignore
│
├── data/
│   ├── raw/
│   │   └── Project2_Dataset_Corrected.csv
│   │
│   └── processed/
│       └── Neo4j-ready CSV files
│
├── src/
│   └── preprocess.py
│
├── cypher/
│   ├── create_graph.cypher
│   ├── analysis_queries.cypher
│   └── gds_analysis.cypher
│
├── dashboard/
│   └── road_safety_dashboard.pbix
│
├── images/
│   ├── graph_schema.png
│   ├── neo4j_graph.png
│   └── dashboard.png
│
└── report/
    └── project_report.pdf
```

---

## How to Run the Project

### 1. Clone the Repository

```bash
git clone <repository-url>
cd australian-road-fatality-graph-analysis
```

### 2. Install Python Dependencies

```bash
pip install -r requirements.txt
```

### 3. Run Data Preprocessing

```bash
python src/preprocess.py
```

This generates the processed CSV files required by Neo4j.

### 4. Create the Neo4j Graph

Open Neo4j and execute:

```text
cypher/create_graph.cypher
```

### 5. Run Analytical Queries

Execute the queries contained in:

```text
cypher/analysis_queries.cypher
```

### 6. Run Graph Data Science Analysis

After the GDS component is completed, execute:

```text
cypher/gds_analysis.cypher
```

### 7. Explore the Dashboard

Open:

```text
dashboard/road_safety_dashboard.pbix
```

using Power BI Desktop.

---

## Key Findings

The final portfolio project will summarise the strongest findings from the Cypher analysis, Graph Data Science analysis, and Power BI dashboard.

This section will be updated after the analytical queries have been reviewed and validated.

> **Status:** Analysis refinement in progress.

---

## Project Development Status

| Component | Status |
|---|---|
| Dataset | Completed |
| Initial data preprocessing | Completed |
| Graph data model | Completed |
| Neo4j database implementation | Completed |
| Cypher analysis | Completed |
| Portfolio ETL refactoring | In Progress |
| Graph Data Science analysis | Planned |
| Power BI dashboard | Planned |
| Final portfolio documentation | In Progress |

---

## Future Improvements

Future extensions of the project may include:

- Additional Neo4j Graph Data Science algorithms
- Improved data-quality validation
- Automated ETL pipeline
- Query performance optimisation
- Additional geographic analysis
- Interactive Power BI reporting
- Integration of additional Australian road-safety datasets

---

## Project Report

The original detailed project report is available in:

```text
report/project_report.pdf
```

The report contains the original graph design, preprocessing methodology, Cypher implementation, queries, results, and discussion.

---

## Author

**Nisari Ramachandran**

Master of Data Science 
The University of Western Australia, Perth, Western Australia

### Skills Demonstrated

`Python` · `Pandas` · `Neo4j` · `Cypher` · `Graph Databases` · `Graph Data Modelling` · `ETL` · `Data Analysis` · `Power BI` · `Git` · `GitHub`

---

## Disclaimer

This project is intended for educational and portfolio purposes. Analytical findings should not be interpreted as causal road-safety conclusions without additional statistical validation and domain-specific investigation.