# Game Pipeline Project

## Overview

This project is an end-to-end data engineering pipeline that simulates the data infrastructure for a mobile game. It demonstrates a complete, automated ELT (Extract, Load, Transform) process using modern, cloud-native data stack tools. The pipeline automatically ingests raw game data, loads it into a data warehouse, and transforms it into clean, analytics-ready tables.

**🎯 Target:** This project was specifically developed to showcase the core competencies required for the **Data Engineer role at Dream Games**, covering their specified tech stack and responsibilities.

---

## Architecture

*A high-level diagram illustrating the flow of data from source to destination.*

![Architecture Diagram](path/to/your/diagram.png) 
*(Note: You should create a diagram using a tool like draw.io or Excalidraw and upload it to your repository, then update this link.)*

---

## Tech Stack

* **Cloud Provider:** Google Cloud Platform (GCP)
* **Orchestration:** Apache Airflow (managed via Google Cloud Composer)
* **Data Lake:** Google Cloud Storage (GCS)
* **Data Warehouse:** Google BigQuery
* **Data Transformation:** dbt (data build tool) & dbt Cloud
* **Core Languages:** Python, SQL

---

## Features

* **Automated ELT Pipeline:** An Airflow DAG orchestrates the entire workflow, ensuring tasks run in the correct order and dependencies are met.
* **Infrastructure as Code:** The Airflow DAG is defined in Python, allowing for version control, collaboration, and easy replication.
* **Data Modeling & Transformation:** dbt is used to transform raw, unstructured data into clean, tested, and documented analytical models. This separates raw data from production-ready tables, following data warehousing best practices.
* **Separation of Environments:** The project utilizes distinct datasets in BigQuery for raw data (`game_pipeline_raw_data`), development (`dbt_asevim`), and production (`game_pipeline_production`), which is a professional standard.

---

## Pipeline in Action

The orchestration is handled by a single Airflow DAG (`gcs_to_bq_with_dbt_transform`) which performs the following tasks in order:

1.  **`load_csv_from_gcs_to_bq`**:
    * This task uses Airflow's `GCSToBigQueryOperator`.
    * It extracts the `match_results.csv` file from the Google Cloud Storage bucket.
    * It loads this raw data into a staging table named `raw_match_results` inside the `game_pipeline_raw_data` dataset in BigQuery.
    * This task is idempotent; it truncates the table before each load to ensure fresh data.

2.  **`trigger_dbt_cloud_job`**:
    * This task runs only after the data loading is successful.
    * It uses Airflow's `DbtCloudRunJobOperator` to trigger a pre-configured job in dbt Cloud.
    * The dbt job executes `dbt build`, which runs all models. It transforms the raw data from `raw_match_results` and materializes the final, clean `stg_matches` table in the `game_pipeline_production` dataset.

---
