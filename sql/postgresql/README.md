# PingAuthorize Policy Editor PostgreSQL Scripts
This directory contains SQL scripts to initialize and upgrade a PingAuthorize Policy Editor policy
database PostgreSQL implementation. Use the `init-policy-database.sql` script to initialize an empty database
and grant access to `pap_user` (the suggested application username).
> :warning: **Before starting**, please verify that you are using a supported PostgreSQL installation by referencing
the [PingAuthorize documentation](https://docs.pingidentity.com/csh?Product=paz-latest&Page=home).
## Manual installation
This section describes how to initialize a policy database running on a traditional (non-container) system.

### Before you begin
* Install and configure PostgreSQL for your system.
* Ensure you are signed on to your system as an authenticated PostgreSQL superuser (for example `postgres`).

### Initializing a new PostgreSQL policy database
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
your PostgreSQL instance, see [Installing the PingAuthorize Policy Editor manually](https://docs.pingidentity.com/csh?Product=paz-latest&context=paz_install_pe_noninteractive).


### Upgrading an existing policy database to a newer schema
1. Verify the current version of your policy database using one of the following methods.

**Optional** - Access `my_pap_db` and query the `TAG` column of `my_pap_db.databasechangelog`

```
psql --dbname=my_pap_db
```

```
SELECT TAG FROM DATABASECHANGELOG WHERE TAG IS NOT NULL ORDER BY TAG DESC LIMIT 1;
```

**Optional** - Follow the [steps to non-interactively set up](https://docs.pingidentity.com/csh?Product=paz-latest&context=paz_install_pe_noninteractive)
   a **fresh installation** of the target version of the Policy Editor.

   An example setup script is provided below should you wish to avoid affecting your existing installation files.

   **Note**: Setup is intended to be run on a new installation, without any existing configuration.

```
bin/setup demo \
  --adminUsername admin \
  --dbConnectionString "jdbc:postgresql://<postgresql_host>:<postgresql_port>/my_pap_db" \
  --dbAppUsername "<postgres_user>" \
  --generateSelfSignedCertificate \
  --decisionPointSharedSecret pingauthorize \
  --hostname <host> \
  --port <pap_port> \
  --adminPort <admin_port> \
  --licenseKeyFile <license>
```

When executing `bin/start-server` the application checks if the database schema is misaligned with `PingAuthorize-PAP`, if so, you will be provided the locations of the necessary upgrade scripts.

```
<PingAuthorize-PAP>/bin/start-server
```

_The policy database at `'jdbc:postgresql://<postgresql_host>:<postgresql_port>/my_pap_db'` is older than this version of `PingAuthorize (9.1.0.0)`. Please use the following scripts to upgrade the policy database before running `start-server` again:_

_A) https://github.com/pingidentity/pingauthorize-contrib/blob/main/sql/postgresql/9.1-EA.sql_

_B) https://github.com/pingidentity/pingauthorize-contrib/blob/main/sql/postgresql/9.1-GA.sql_


2. Download and apply the upgrade scripts for the policy database versions between your current version and the target version.

For example, in order to upgrade from `9.0-GA` to `9.1-GA`, both the `9.1-EA`, and `9.1-GA` upgrade scripts must be applied.

```
wget https://raw.githubusercontent.com/pingidentity/pingauthorize-contrib/main/sql/postgresql/9.1-EA.sql
```

```
psql --dbname=my_pap_db --file=9.1-EA.sql >/dev/null
```

```
wget https://raw.githubusercontent.com/pingidentity/pingauthorize-contrib/main/sql/postgresql/9.1-GA.sql
```


```
psql --dbname=my_pap_db --file=9.1-GA.sql >/dev/null
```

After you apply the necessary upgrade scripts, the policy database upgrade is complete.

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
(see "[Installing PingAuthorize Policy Editor using Docker](https://docs.pingidentity.com/csh?Product=paz-latest&context=paz_install_pe_docker)"
for instructions on how to run the container and "[Starting PingAuthorize Policy Editor](https://docs.pingidentity.com/csh?Product=paz-latest&context=paz_start_pe)"
for more details on the available environment variables).
