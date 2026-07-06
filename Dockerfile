# Etapa 1: compilar la app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY . .
RUN dotnet restore
RUN dotnet publish -c Release -o /app/publish

# Etapa 2: imagen final, más liviana, solo para ejecutar
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=build /app/publish .

# Render asigna el puerto dinámicamente mediante la variable PORT
ENV ASPNETCORE_URLS=http://+:$PORT

# Cambia "BlazorApp.dll" si el nombre de tu ensamblado es distinto
ENTRYPOINT ["dotnet", "BlazorApp.dll"]
