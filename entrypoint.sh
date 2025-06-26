#!/bin/bash
set -e

# Asegúrate de que el script principal sea ejecutable
chmod +x ./start-tModLoaderServer.sh

# Ejecuta el servidor
exec ./start-tModLoaderServer.sh -nosteam -world "Worlds/${WORLD_NAME}.wld" -tmlsavedirectory "/home/tmodloader/tmodloader"
