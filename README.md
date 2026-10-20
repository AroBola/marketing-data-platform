# Marketing Data Platform — Databricks & dbt

## 1. Project Overview

The Marketing Data Platform combines Facebook Ads and Snapchat Ads data into a unified analytical model using Databricks and dbt.

The goal is to provide a consistent dataset for analysing advertising spend, impressions, clicks, and campaign performance across platforms.

## 2. Architecture

The project follows a layered data transformation approach:

```text
Facebook Ads ──┐
               ├──> Databricks Raw/Bronze
Snapchat Ads ──┘              |
                              v
                       dbt Staging
                              |
                              v
                    Intermediate Model
                              |
                              v
                    Final Marketing Model
                              |
                              v
                 SQL Analysis and Reporting
```

## 3. Technology Stack

* **Databricks:** Data storage and SQL execution.
* **dbt Core:** SQL transformations, testing, and documentation.
* **Databricks SQL Connector:** Connectivity between dbt and Databricks.
* **Git and GitHub:** Version control and project collaboration.

## 4. Data Models

The project contains four dbt models.

| Model                 | Purpose                                                | Materialization |
| --------------------- | ------------------------------------------------------ | --------------- |
| `stg_facebook_ads`    | Standardizes Facebook advertising data and data types. | View            |
| `stg_snapchat_ads`    | Standardizes Snapchat advertising data and data types. | View            |
| `int_marketing_ads`   | Combines advertising records into a unified structure. | View            |
| `fct_marketing_spend` | Provides the final analytical marketing dataset.       | Table           |

### Materialization decisions

Staging and intermediate models use views to avoid unnecessarily persisting intermediate results. The final analytical model uses a table to provide a persisted dataset for downstream analysis.

## 5. Data Quality and Transformation

The staging models standardize field names and data types across the advertising sources. The intermediate model combines the platforms into a consistent structure, and the final model calculates marketing performance metrics.

The project includes dbt tests for:

* Non-null platform values.
* Accepted platform values.
* Non-null Facebook ad IDs and dates.
* Non-null Snapchat ad detail IDs and dates.

During validation, 7,067 Snapchat source records were found to have no ad detail ID, date, spend, impressions, or clicks. These records were excluded from the Snapchat staging model because they contain no usable advertising performance metrics. The raw source data was not modified.

## 6. Marketing Performance Metrics

The final analytical model is designed to support analysis of advertising spend, impressions, clicks, and platform performance.

The key performance indicators include:

* **Click-through rate (CTR):** Clicks divided by impressions.
* **Cost per click (CPC):** Spend divided by clicks.
* **Cost per thousand impressions (CPM):** Spend divided by impressions, multiplied by 1,000.

Calculations should handle zero clicks and zero impressions safely to avoid division errors.

## 7. Setup and Execution

### Prerequisites

* Python
* dbt Core
* The `dbt-databricks` adapter
* Access to a Databricks SQL warehouse and the required source tables

### Install dependencies

```bash
pip install dbt-core dbt-databricks
```

### Configure the connection

Configure the `marketing_data_platform` profile in `~/.dbt/profiles.yml` with the appropriate Databricks host, HTTP path, catalog, schema, and credentials.

Credentials should be supplied securely through the approved configuration or secret-management mechanism. Do not commit access tokens or passwords to GitHub.

### Validate the connection

```bash
dbt debug
```

### Build the models

```bash
dbt run
```

### Run data quality tests

```bash
dbt test
```

### Generate dbt documentation

```bash
dbt docs generate
```

To view the generated documentation locally:

```bash
dbt docs serve
```

## 8. Validation Results

The latest successful validation confirmed:

* All four dbt models built successfully.
* All six configured data quality tests passed.
* The final model was materialized as a table in the development schema.

These results apply to the development environment used during validation.

## 9. Repository Structure

```text
marketing_data_platform/
├── models/
│   ├── staging/
│   │   ├── sources.yml
│   │   ├── stg_facebook_ads.sql
│   │   └── stg_snapchat_ads.sql
│   ├── intermediate/
│   │   └── int_marketing_ads.sql
│   ├── marts/
│   │   └── fct_marketing_spend.sql
│   └── schema.yml
├── dbt_project.yml
└── README.md
```

## 10. Further Production Readiness

The next steps for a production-ready implementation include completing and validating environment separation, CI/CD automation, Elementary observability, production service-principal authentication, and Unity Catalog permissions.

Generated documentation and lineage should also be validated before the project is considered fully complete.

## 11. Conclusion

This project establishes a unified marketing data model using Databricks and dbt. It demonstrates layered SQL transformations, platform standardization, automated data quality tests, and deliberate materialization choices, providing a foundation for consistent advertising analytics and future production deployment.
