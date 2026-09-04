# Laboratorio 1 - Control de versiones y documentación automática de software

**Curso:** IE0417 - Diseño de Software para Ingeniería
**Estudiante:** [Isaac Flores Zamora]
**Carné:** [C32985]

## Repositorio y sitio publicado

| Recurso | URL |
|---|---|
| Repositorio de entrega | [https://github.com/CH4CFZ/ie0417-laboratorio-git-documentacion-C32985.git] |
| Sitio publicado (portada) | https://monumental-lokum-aedc73.netlify.app/ |
| Documentación C++ ({fmt}, generada con Doxygen) | https://monumental-lokum-aedc73.netlify.app/cpp/ |
| Documentación Python (Black, generada con Sphinx) | https://monumental-lokum-aedc73.netlify.app/python/ |

## Proyectos documentados

| | Proyecto | Repositorio original | Licencia | Commit documentado |
|---|---|---|---|---|
| C++ / Doxygen | {fmt} | https://github.com/fmtlib/fmt | MIT | `b039e624c02ae473280156235217f9e02792b055` |
| Python / Sphinx | Black | https://github.com/psf/black | MIT | `8947c48ef2077c3a301b03c1e814dc2e3f78436e` |

Más detalle de cada selección en `doxygen/seleccion.md` y `sphinx/seleccion.md`.

## Estructura del repositorio

```text
.
├── README.md
├── informe.md
├── git/
│   ├── learn-git-branching.md
│   └── evidencias/
├── doxygen/
│   ├── Doxyfile
│   ├── mainpage.md
│   ├── seleccion.md
│   └── build.log
├── sphinx/
│   ├── source/
│   │   ├── conf.py
│   │   ├── index.rst
│   │   ├── introduccion.rst
│   │   └── api/
│   ├── requirements-docs.txt
│   ├── seleccion.md
│   └── build.log
├── scripts/
│   └── build-docs.sh
└── site/
    ├── index.html
    ├── cpp/
    └── python/
```

## Cómo regenerar la documentación localmente

### Requisitos previos

- Doxygen y Graphviz instalados en el sistema (`sudo apt-get install doxygen graphviz` en Ubuntu/Debian).
- Python 3.9 o superior con soporte de `venv` (`sudo apt-get install python3-venv`).
- El código fuente de ambos proyectos clonado en el commit exacto documentado, en carpetas **fuera** de este repositorio (para no versionar código de terceros):

```bash
git clone https://github.com/fmtlib/fmt.git ../fmt-fuente
cd ../fmt-fuente && git checkout b039e624c02ae473280156235217f9e02792b055 && cd -

git clone https://github.com/psf/black.git ../black-fuente
cd ../black-fuente && git checkout 8947c48ef2077c3a301b03c1e814dc2e3f78436e && cd -
```

### Generar ambas documentaciones

Desde la raíz de este repositorio:

```bash
chmod +x scripts/build-docs.sh
./scripts/build-docs.sh
```

Esto regenera `doxygen/build.log`, `sphinx/build.log`, y coloca el HTML resultante en `site/cpp/` y `site/python/`. Si el código fuente de los proyectos se clonó en una ubicación distinta a la de arriba, se puede indicar con variables de entorno:

```bash
FMT_SRC=/otra/ruta/fmt BLACK_SRC=/otra/ruta/black ./scripts/build-docs.sh
```

## Versión de las herramientas utilizadas

| Herramienta | Versión |
|---|---|
| Doxygen | 1.9.8 |
| Graphviz | 2.43.0 |
| Python | [3.13.3] |
| Sphinx | 9.1.0 |
| sphinx_rtd_theme | 3.1.0 |
| Git | [2.48.1] |

## Licencia de este trabajo

Este repositorio corresponde a una entrega académica del curso IE0417. Los proyectos de terceros documentados (fmt, Black) conservan su propia licencia MIT original; no se modifica ni redistribuye su código fuente, solo se genera documentación derivada con fines educativos.
