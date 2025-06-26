# Hacer servidor de tmodloader con ciertos mods y un mundo ya creado

> - Version de tmodloader: https://github.com/tModLoader/tModLoader/releases/tag/v2025.04.3.0
> - Version de terraria: 1.4.4

En el directorio donde se encuentra el dockerfile se deben encontrar ya los directorios de ModConfigs, Mods (en este se debe encontrar el archivo enabled.json con el nombre de los mods que deben estar archivos en el mundo) y Worlds con los archivos necesarios en cada uno.

```
server-directory/
├── ModConfigs/      # Configuraciones de mods que lo requieran
├── Mods/            # Mods con sus dependencias necesarias en .tmod
├── Worlds/          # Archivos del mundo (.wld y .twld)
├── .gitignore
├── Dockerfile
├── .entrypoint.sh   # Archivo que ejecuta el servidor
├── .README.md
```

> NOTA: Verificar que los mods no entren en conflicto ya que no se podra iniciar el contenedor con el servidor de manera correcta.

```bash
# Primer comando para construir la imagen
docker build -t tmodloader . 

# Comando para correr un contenedor con la imagen anteriormente creada
docker run -d \
  -p 7777:7777 \
  -v "$(pwd)/Mods:/home/tmodloader/tmodloader/Mods" \
  -v "$(pwd)/Worlds:/home/tmodloader/tmodloader/Worlds" \
  -v "$(pwd)/ModConfigs:/home/tmodloader/tmodloader/ModConfigs" \
  -v "$(pwd)/Logs:/home/tmodloader/tmodloader/Logs" \
  --name tmod-server \
  --memory=8g \
  --memory-swap=-1 \
  tmodloader

```

**Tu ip sera la de donde se encuentra tu contenedor (servidor) y el puerto siempre sera 7777 ya que ese es el que se ocupa por defecto.**
