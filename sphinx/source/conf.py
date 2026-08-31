# Configuration file for the Sphinx documentation builder.
#
# Configuración propia creada para el Laboratorio 1 (IE0417), Parte IV.
# Proyecto documentado: Black (https://github.com/psf/black)
# Commit exacto analizado: 8947c48ef2077c3a301b03c1e814dc2e3f78436e

import os
import sys

# -- Resolución del paquete ---------------------------------------------------
# Black vive en <repo>/src/black. Agregamos esa ruta al sys.path para que
# autodoc pueda importar el paquete sin necesidad de instalarlo aparte
# (aunque en esta entrega también se instaló en el entorno virtual con
# `pip install .` para que sus dependencias declaradas queden resueltas).
BLACK_SRC = os.path.abspath(
    os.path.join(os.path.dirname(__file__), "..", "..", "..", "candidatos", "black", "src")
)
sys.path.insert(0, BLACK_SRC)

# -- Project information -----------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#project-information

project = 'Black'
copyright = '2026, Laboratorio IE0417'
author = 'Laboratorio IE0417'
release = '0.1 (commit 8947c48)'

# -- General configuration ---------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration

extensions = [
    'sphinx.ext.autodoc',    # extrae documentación desde módulos y docstrings
    'sphinx.ext.napoleon',   # interpreta docstrings estilo Google/NumPy
    'sphinx.ext.viewcode',   # agrega enlaces al código fuente resaltado
    'sphinx.ext.autosummary',  # genera tablas resumen de módulos/miembros
]

# Genera automáticamente los stubs de autosummary referenciados en el índice
autosummary_generate = True

# Orden de los miembros documentados: como aparecen en el código fuente
autodoc_member_order = 'bysource'

# Módulos opcionales de Black que dependen de librerías no instaladas en este
# entorno virtual (soporte de notebooks Jupyter y del demonio blackd).
# Se simulan con autodoc_mock_imports para que autodoc no falle al importar
# black/__init__.py, que los referencia condicionalmente.
autodoc_mock_imports = ["IPython", "tokenize_rt", "aiohttp"]

templates_path = ['_templates']
exclude_patterns = ['_build', 'Thumbs.db', '.DS_Store']

language = 'es'

# -- Options for HTML output -------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output

html_theme = 'sphinx_rtd_theme'
html_static_path = ['_static']
