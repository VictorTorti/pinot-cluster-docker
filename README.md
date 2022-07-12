# Apache Pinot cluster using Docker

Create an Apache Pinot cluster using `Docker` and `docker-compose`. 

## Table of contents

- [Apache Pinot cluster using Docker](#apache-pinot-cluster-using-docker)
  - [Run](#run)
  - [Ingest sample data](#ingest-sample-data)
  - [References](#references)
 
## Run

Deploy the cluster using the command:

```bash
docker-compose up -d
```

## Ingest sample data

To ingest the `tracks.csv` dataset, please run the following commands.

```bash
# Create temp folders in the container
docker exec pinot-controller-1-1 mkdir -p /tmp/raw_data/tracks
docker exec pinot-controller-1-1 mkdir -p /tmp/definitions/

# Copy files to container
docker cp tracks.csv pinot-controller-1-1:/tmp/raw_data/tracks/
docker cp tracks-schema.json pinot-controller-1-1:/tmp/definitions/
docker cp tracks-table-offline.json pinot-controller-1-1:/tmp/definitions/
docker cp tracks_job_spec.yml pinot-controller-1-1:/tmp/definitions/

# Add schema and table
docker exec -it pinot-controller-1-1 \
    /opt/pinot/bin/pinot-admin.sh AddTable \
    -controllerPort 9001 \
    -schemaFile /tmp/definitions/tracks-schema.json \
    -tableConfigFile /tmp/definitions/tracks-table-offline.json \
    -exec

# Ingest CSV data
docker exec -it pinot-controller-1-1 \
    /opt/pinot/bin/pinot-admin.sh LaunchDataIngestionJob \
    -jobSpecFile /tmp/definitions/tracks_job_spec.yml
```

## References

- [Personal Blog](https://cnatsis.com)
- [Apache Pinot Documentation](https://docs.pinot.apache.org/)
- [StarTree](https://www.startree.ai/)
