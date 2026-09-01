#!/usr/bin/env bash
# ============================================================================
# scripts/build-docs.sh
#
# Regenera la documentacion Doxygen (C++) y Sphinx (Python) de este
# laboratorio, y las coloca en site/cpp y site/python respectivamente.
#
# Requisitos previos (una sola vez):
#   - doxygen y graphviz instalados en el sistema
#   - python3 y python3-venv instalados en el sistema
#   - el codigo fuente de fmt y de black clonados FUERA de este repositorio,
#     en el commit exacto documentado en doxygen/seleccion.md y
#     sphinx/seleccion.md
#
# Uso:
#   ./scripts/build-docs.sh
#
# Se puede sobreescribir la ubicacion del codigo fuente de terceros con
# variables de entorno, por ejemplo:
#   FMT_SRC=/otra/ruta/fmt BLACK_SRC=/otra/ruta/black ./scripts/build-docs.sh
# ============================================================================

set -euo pipefail

# Se ejecuta desde la raiz del repositorio, sin importar desde donde se
# invoque el script:
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

# Rutas por defecto: carpetas hermanas al repositorio (fuera de git)
FMT_SRC="${FMT_SRC:-$REPO_ROOT/../fmt-fuente}"
BLACK_SRC="${BLACK_SRC:-$REPO_ROOT/../black-fuente}"

echo "=================================================================="
echo " Laboratorio IE0417 - Regeneracion de documentacion"
echo "=================================================================="
echo "Raiz del repositorio: $REPO_ROOT"
echo "Fuente de fmt:        $FMT_SRC"
echo "Fuente de black:      $BLACK_SRC"
echo

if [ ! -d "$FMT_SRC" ]; then
  echo "ERROR: no se encontro el codigo fuente de fmt en $FMT_SRC"
  echo "Clonalo con:"
  echo "  git clone https://github.com/fmtlib/fmt.git $FMT_SRC"
  echo "  cd $FMT_SRC && git checkout b039e624c02ae473280156235217f9e02792b055"
  exit 1
fi

if [ ! -d "$BLACK_SRC" ]; then
  echo "ERROR: no se encontro el codigo fuente de black en $BLACK_SRC"
  echo "Clonalo con:"
  echo "  git clone https://github.com/psf/black.git $BLACK_SRC"
  echo "  cd $BLACK_SRC && git checkout 8947c48ef2077c3a301b03c1e814dc2e3f78436e"
  exit 1
fi

# --------------------------------------------------------------------------
# 1. Doxygen (fmt) -> site/cpp
# --------------------------------------------------------------------------
echo "------------------------------------------------------------------"
echo " Generando documentacion Doxygen (fmt)"
echo "------------------------------------------------------------------"

command -v doxygen >/dev/null 2>&1 || {
  echo "ERROR: doxygen no esta instalado. Instalalo con:"
  echo "  sudo apt-get install -y doxygen graphviz"
  exit 1
}

cd "$REPO_ROOT/doxygen"

# El Doxyfile debe tener su INPUT apuntando a $FMT_SRC. Si se movio la
# fuente de lugar, se puede regenerar la linea INPUT automaticamente:
sed -i "s|^INPUT .*|INPUT                  = $FMT_SRC/include $FMT_SRC/src mainpage.md|" Doxyfile

doxygen Doxyfile > build.log 2>&1
DOXYGEN_EXIT=$?

if [ $DOXYGEN_EXIT -ne 0 ]; then
  echo "ERROR: doxygen termino con codigo $DOXYGEN_EXIT. Revisa doxygen/build.log"
  exit 1
fi

WARN_COUNT=$(grep -c "warning:" build.log || true)
echo "Doxygen genero correctamente. Advertencias: $WARN_COUNT (ver doxygen/build.log)"

cd "$REPO_ROOT"
rm -rf site/cpp
cp -r doxygen/html site/cpp
echo "Documentacion Doxygen copiada a site/cpp/"
echo

# --------------------------------------------------------------------------
# 2. Sphinx (black) -> site/python
# --------------------------------------------------------------------------
echo "------------------------------------------------------------------"
echo " Generando documentacion Sphinx (black)"
echo "------------------------------------------------------------------"

cd "$REPO_ROOT/sphinx"

if [ ! -d ".venv" ]; then
  echo "Creando entorno virtual..."
  python3 -m venv .venv
fi

# shellcheck disable=SC1091
source .venv/bin/activate

pip install --quiet --upgrade pip
pip install --quiet -r requirements-docs.txt
pip install --quiet "$BLACK_SRC"

# conf.py lee la ruta del paquete desde esta variable de entorno
# (con un valor por defecto propio si no se define, ver source/conf.py)
export SPHINX_BLACK_SRC="$BLACK_SRC/src"

sphinx-build -b html source ../site/python > build.log 2>&1
SPHINX_EXIT=$?

deactivate

if [ $SPHINX_EXIT -ne 0 ]; then
  echo "ERROR: sphinx-build termino con codigo $SPHINX_EXIT. Revisa sphinx/build.log"
  exit 1
fi

WARN_COUNT=$(grep -c "WARNING" build.log || true)
echo "Sphinx genero correctamente. Advertencias: $WARN_COUNT (ver sphinx/build.log)"
echo "Documentacion Sphinx generada en site/python/"
echo

echo "=================================================================="
echo " Listo. Verifica site/index.html, site/cpp/index.html y"
echo " site/python/index.html antes de publicar."
echo "=================================================================="
