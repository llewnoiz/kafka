#mssql
https://hub.docker.com/_/microsoft-mssql-server

2022-latest
docker pull mcr.microsoft.com/mssql/server:2022-latest

2019-latest
docker pull mcr.microsoft.com/mssql/server:2019-latest

2017-latest
docker pull mcr.microsoft.com/mssql/server:2017-latest

How to use this Image
Start a mssql-server instance for SQL Server 2022, which is now generally available(GA).

docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=yourStrong(!)Password" -p 1433:1433 -d mcr.microsoft.com/mssql/server:2022-latest
Start a mssql-server instance using a CU tag, in this example we use the CU 14 for SQL 2019 IMPORTANT NOTE: If you are using PowerShell on Windows to run these commands use double quotes instead of single quotes.

docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=yourStrong(!)Password" -p 1433:1433 -d mcr.microsoft.com/mssql/server:2019-CU14-ubuntu-20.04
Start a mssql-server instance using the latest update for SQL Server 2019

docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=yourStrong(!)Password" -p 1433:1433 -d mcr.microsoft.com/mssql/server:2019-latest
Start a mssql-server instance running as the SQL Express edition

docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=yourStrong(!)Password" -e "MSSQL_PID=Express" -p 1433:1433 -d mcr.microsoft.com/mssql/server:2019-latest 
Connect to Microsoft SQL Server You can connect to the SQL Server using the sqlcmd tool inside of the container by using the following command on the host:

docker exec -it <container_id|container_name> /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P <your_password>
You can also use the tools in an entrypoint.sh script to do things like create databases or logins, attach databases, import data, or other setup tasks. See this example of using an entrypoint.sh and setup.sql scripts to create a database.

You can connect to the SQL Server instance in the container from outside the container by using various command line and GUI tools on the host or remote computers. See the Connect and Query topic in the SQL Server on Linux documentation.
