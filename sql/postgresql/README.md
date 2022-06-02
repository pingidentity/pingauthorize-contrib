# PingAuthorize Policy Editor PostgreSQL Scripts
This directory contains SQL scripts to initialize and upgrade a PingAuthorize Policy Editor policy
database PostgreSQL implementation. Use the `init-policy-database.sql` script to initialize an empty database
and grant access to `pap_user` (the suggested application username).
> :warning: **Before starting**, please verify that you are using a supported PostgreSQL installation by referencing
the [PingAuthorize documentation](https://docs.pingidentity.com/csh?Product=paz-90&Page=home).
## Manual installation
This section describes how to initialize a policy database running on a traditional (non-container) system.

### Before you begin
* Install and configure PostgreSQL for your system.
* Ensure you are signed on to your system as an authenticated PostgreSQL superuser (for example `postgres`).

### Steps
1. Create the `pap_user` role.
```
createuser --pwprompt pap_user
```
2. Create the database.
```
createdb my_pap_db
```
3. Run the `init-policy-database.sql` script against the new database.
```
psql --dbname=my_pap_db --file="<pingauthorize-contrib-root>/sql/postgresql/init-policy-database.sql" >/dev/null
```
You should now have an initialized policy database. For instructions on configuring the Policy Editor to connect to
your PostgreSQL instance, see "[Installing the PingAuthorize Policy Editor manually](https://docs.pingidentity.com/csh?Product=paz-90&context=pingauthorize_install_pe_noninteractive)".

## Docker installation
This section describes how to use the scripts in this directory to initialize a policy database running the official
PostgreSQL Docker image. Please adjust the steps according to your specific deployment needs.
1. Create a Docker network. The database, database administrator commands, and the PingAuthorize Policy Editor will
run on this network.
```
docker network create --driver=bridge my_pap_network
```
2. Start the PostgreSQL container.
```
docker run --name=my_postgres \
  --env POSTGRES_PASSWORD=myS3cretPassw0rd \
  --network=my_pap_network \
  --detach postgres
```
> :warning: **Please follow security best practices** when setting up the default `postgres` user password.
3. Create the `pap_user` role.
```
docker run -it --rm \
  --network=my_pap_network \
  postgres createuser \
  --host=my_postgres \
  --username=postgres \
  --pwprompt pap_user
```
4. Create the database.
```
docker run -it --rm \
  --network=my_pap_network \
  postgres createdb \
  --host=my_postgres \
  --username=postgres my_pap_db
```
5. Run the `init-policy-database.sql` script against the new database.
```
docker run -it --rm \
  --network=my_pap_network \
  --volume="<pingauthorize-contrib-root>/sql/postgresql/init-policy-database.sql":/opt/init-policy-database.sql \
  postgres psql \
  --host=my_postgres \
  --username=postgres \
  --dbname=my_pap_db \
  --file=/opt/init-policy-database.sql
```
You should now have an initialized policy database in your container. Run the PingAuthorize Policy Editor on the
same network, providing the appropriate environment variables to connect to the PostgreSQL instance 
(see "[Installing PingAuthorize Policy Editor using Docker](https://docs.pingidentity.com/csh?Product=paz-90&context=pingauthorize_install_pe_docker)"
for instructions on how to run the container and "[Starting PingAuthorize Policy Editor](https://docs.pingidentity.com/csh?Product=paz-90&context=pingauthorize_start_pe)"
for more details on the available environment variables).
