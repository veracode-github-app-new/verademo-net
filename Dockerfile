# For Security Labs we need both the application and DB running within the same container.
# It's far easier to use the SQL Server base image and install the ASP.NET 8 SDK
# on top than the other way around. We are using the full SDK rather than
# aspnetcore-runtime-8.0 to enable re-compilation within the lab.
#
# https://hub.docker.com/_/microsoft-mssql-server
# This is Ubuntu 22.04
FROM mcr.microsoft.com/mssql/server:2022-CU12-ubuntu-22.04

# This is so that we can add some relevant soft links and apt
USER root

# Configure Sql Server
ENV ACCEPT_EULA=Y
ENV MSSQL_PID=Express
ENV SA_PASSWORD=SuperSecurePassw0rd!
COPY db/* /var/opt/mssql/data/
RUN ln -s /opt/mssql-tools/bin/sqlcmd /bin/ && chmod +x /var/opt/mssql/data/configure.sh && /var/opt/mssql/data/configure.sh

# Install the ASP.NET 8 SDK as per
# Also install the fortune-mod fortune game
# https://docs.microsoft.com/en-us/dotnet/core/install/linux-ubuntu
RUN apt-get update \
    && apt-get -y install apt-transport-https dotnet-sdk-8.0 fortune-mod iputils-ping \
    && ln -s /usr/games/fortune /bin/ \
    && rm -rf /var/lib/apt/lists/*
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

WORKDIR /app
COPY app /app

ENV ASPNETCORE_URLS="http://+:8080"
ENV ASPNETCORE_ENVIRONMENT="Development"
ENV ASPNETCORE_FORWARDEDHEADERS_ENABLED="true"
ENV NUGET_PACKAGES="/usr/share/nuget"

# Compile
RUN dotnet build

ENTRYPOINT ["/entrypoint.sh"]
CMD ["-c"]