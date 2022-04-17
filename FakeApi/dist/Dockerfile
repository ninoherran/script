WORKDIR /app
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
EXPOSE 80
EXPOSE 443
COPY ./dist /app
RUN cd dist
ENTRYPOINT ["dotnet", "FakeApi.dll"]