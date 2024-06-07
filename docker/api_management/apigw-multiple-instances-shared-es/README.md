
# Manually re-assigning Kibana to the right default index / dataview in Elastic Search

IMPORTANT ==> NOT SUPPORTED!!! (Kibana accross single Elastic search with multiple tenants)

## Kibana1

curl -X POST "kibana1:5601/api/data_views/default" -H 'kbn-xsrf: true' -H 'Content-Type: application/json' -d'
{
  "data_view_id": "gateway_tenant1_analytics",
  "force": true
}
'
curl -X GET http://kibana1:5601/api/data_views/default

curl -X POST "kibana1:5601/api/index_patterns/default" -H 'kbn-xsrf: true' -H 'Content-Type: application/json' -d'
{
  "index_pattern_id": "gateway_tenant1_analytics",
  "force": true
}
'
curl -X GET "kibana1:5601/api/index_patterns/default" -H 'kbn-xsrf: true'

## Kibana2

curl -X POST "kibana2:5601/api/data_views/default" -H 'kbn-xsrf: true' -H 'Content-Type: application/json' -d'
{
  "data_view_id": "gateway_tenant2_analytics",
  "force": true
}
'
curl -X GET http://kibana2:5601/api/data_views/default

curl -X POST "kibana2:5601/api/index_patterns/default" -H 'kbn-xsrf: true' -H 'Content-Type: application/json' -d'
{
  "index_pattern_id": "gateway_tenant2_analytics",
  "force": true
}
'
curl -X GET "kibana2:5601/api/index_patterns/default" -H 'kbn-xsrf: true'

## Kibana3

curl -X POST "kibana3:5601/api/data_views/default" -H 'kbn-xsrf: true' -H 'Content-Type: application/json' -d'
{
  "data_view_id": "gateway_tenant3_analytics",
  "force": true
}
'
curl -X GET http://kibana3:5601/api/data_views/default

curl -X POST "kibana3:5601/api/index_patterns/default" -H 'kbn-xsrf: true' -H 'Content-Type: application/json' -d'
{
  "index_pattern_id": "gateway_tenant3_analytics",
  "force": true
}
'
curl -X GET "kibana3:5601/api/index_patterns/default" -H 'kbn-xsrf: true'
