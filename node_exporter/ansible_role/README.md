# Ansible Role: OSM_PROMETHEUS_EXPORTERS
An ansible role which contains multiple exporters of prometheus for scrapping data and for enhancing your monitoring stack. Here are the list of exporters which we are supporting in this role:-
- **[Apache Exporter](https://github.com/Lusitaniae/apache_exporter)**
- **[Elasticsearch Exporter](https://github.com/justwatchcom/elasticsearch_exporter)**
- **[Kafka Exporter](https://github.com/danielqsj/kafka_exporter)**
- **[MongoDB Exporter](https://github.com/dcu/mongodb_exporter)**
- **[MySQL Exporter](https://github.com/prometheus/mysqld_exporter)**
- **[Nginx Exporter](https://github.com/nginxinc/nginx-prometheus-exporter)**
- **[Node Exporter](https://github.com/prometheus/node_exporter)**
- **[Solr Exporter](https://github.com/mosuka/solr-exporter)**

## Requirments
For **[MySQL Exporter](https://github.com/prometheus/mysqld_exporter)**, Create a user in mysql with these privileges
```sql
CREATE USER 'exporter'@'localhost' IDENTIFIED BY 'password';
GRANT PROCESS, REPLICATION CLIENT,
SELECT ON *.* TO 'exporter'@'localhost' WITH MAX_USER_CONNECTIONS 3;
FLUSH PRIVILEGES;
```
---
For **[Nginx Exporter](https://github.com/nginxinc/nginx-prometheus-exporter)**, We have to enable **stub_status** in nginx configuration. In your Nginx Conf add this line to your **location** block
```conf
location / {
    stub_status on;
}
```

## Role Variables
### Mandatory Variables
**Needs to be change depending upon environment**

|**Brief Info**| **Variable**| **Default Values**|
|----------|---------|---------------|
|User, password, host and port for mysql-exporter| prometheus_mysqld_exporter_env | 'user:password@(hostname:port)/' |
|Elasticsearch IP | es_url | localhost |
|Elasticsearch Port | es_port | 9200 |
|Kafka Server IP | kafka_ip | localhost |
|Kafka Server Port | kafka_port | 9092 |
|Nginx Server IP | nginx_ip | localhost |
|Nginx Server Port | nginx_port | 80 |
|Solr IP | solr_ip | localhost |
|Solr Port | solr_port | 8983 |

### Optional Variables

|**Brief Info**| **Variable**| **Default Values**|
|--------------|-------------|-------------------|
|Node Exporter Version| node_exporter_version | 0.17.0 |
|Solr Exporter Version| solr_exporter_version | 0.3.9 |
|Apache Exporter Version| apache_exporter_version | 0.5.0 |
|Elasticsearch Exporter Version | elasticsearch_exporter_version | 1.0.2 |
|MongoDB Exporter Version | mongodb_exporter | 1.0.0 |
|Nginx Exporter Version | nginx_exporter_version | 0.2.0 |
|Kafka Exporter Version | kafka_exporter_version | 1.2.0 |
|MySQL Exporter Version | mysql_exporter_version | 0.11.0 |

## Dependencies
None :-)

## Example Playbook
Here is an example playbook:-
```yml
---
- hosts: exporter
  user: ubuntu
  become: yes
  roles:
    - osm_prometheus_exporters
```

## Usage
For using this role you have to pass one variable to role which is **exporter_name**
```shell
ansible-playbook -i hosts site.yml -e exporter_name="node"
```
For running multiple exporter on same host you can use
```shell
ansible-playbook -i hosts site.yml -e exporter_name=["node", "apache"]
```

Values of **exporter_name** could be:-

|**Values** | **Info** |
|-----------|----------|
|**node** | For Node Exporter |
|**mysql** | For MySQL Exporter |
|**apache** | For Apache Exporter |
|**mongodb** | For MongoDB Exporter |
|**nginx** | For Nginx Exporter |
|**elasticsearch** | For Elasticsearch Exporter |
|**kafka** | For Kafka Exporter |
|**solr** | For Solr Exporter |

