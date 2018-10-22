## Big Data tools

### Maquinas

|  Maquina | tipo  | version  | comentarios  |   
|---|---|---|---|---|
| Spark  | standalone  | 2.2  | hadoop 2.7 + scala 2.12  |   
| HBase |  standalone | 1.2.7  |   |   
| Kafka  | standalone  | 2.12 | 3 topics  |   
|   |   |   |   |   
| HDPnn  | cluster  |  namenode | hadop 2.9.1 + Hbase 1.2. 7  |   
| HDPdn1  | cluster  | datanode1  |   |   
| HDPdn2  | cluster  |  datanode2 |   |   
|   |   |   |   |   
| Keycloak  | auth |   |   |   
| Freipa  | auth |   |   |   |



### Comandos
estado de maquinas
```
vagrant global-status
```
arrancar maquina
```
vagrant up ${Maquina}
```
connectar a CLI de maquina
```
vagrant ssh ${Maquina}
```
volver a leer los ficheros de provision
```
vagrant provision ${Maquina}
```

**Cluster** Para arrancar el cluster utilizar  **scripts/arrancarCluster.sh**
