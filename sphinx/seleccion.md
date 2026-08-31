# Selección de proyecto - Sphinx (Python)

## Datos generales

| Campo | Valor |
|---|---|
| Nombre | Black |
| Descripción breve | Formateador de código Python "sin concesiones" (*uncompromising*): reescribe el código fuente aplicando un único estilo consistente, con el objetivo de eliminar discusiones de estilo en revisiones de código. Mantenido bajo el paraguas de la Python Software Foundation. |
| URL del repositorio original | https://github.com/psf/black |
| Licencia | MIT |
| Lenguaje principal | Python |
| Commit exacto analizado | `8947c48ef2077c3a301b03c1e814dc2e3f78436e` |

## Tamaño del proyecto

| Métrica | Valor |
|---|---|
| Archivos relevantes (código fuente principal, sin tests/docs/ejemplos) | 56 |
| Líneas de código (sin blancos ni comentarios) | 97 322 |
| Comando utilizado | `find src/black -type d \( -name "test*" -o -name "docs" -o -name "examples" \) -prune -o -name "*.py" -print \| xargs cloc` |

Salida completa del comando (sobre el directorio `src/black`, excluyendo tests, docs y ejemplos):

```text
-------------------------------------------------------------------------------
Language                     files          blank        comment           code
-------------------------------------------------------------------------------
Python                          56           2859           3886          97322
-------------------------------------------------------------------------------
SUM:                            56           2859           3886          97322
-------------------------------------------------------------------------------
```

Ambos umbrales del laboratorio se superan cómodamente (≥10 000 líneas y ≥30 archivos fuente) usando exclusivamente el código fuente principal, sin necesidad de incluir la carpeta de tests para alcanzar el mínimo.

## Razón por la cual el proyecto es apropiado para Sphinx

- Es una herramienta oficial y ampliamente adoptada del ecosistema Python (integrada en flujos de CI de miles de proyectos), no un ejercicio académico ni un repositorio de ejemplo para documentación.
- Tiene una organización modular clara dentro de `src/black/` (parser, formateo de líneas, manejo de comentarios, modos de línea, etc.), lo que permite que `sphinx-apidoc` genere una jerarquía de módulos coherente.
- Usa *type hints* de forma consistente en las firmas de sus funciones públicas, lo cual Sphinx puede aprovechar junto con `autodoc` para mostrar tipos de parámetros y retornos sin trabajo adicional.
- Al ser una herramienta de línea de comandos con una API interna relativamente estable, resulta apropiado tanto para documentación narrativa (qué hace y cómo se usa) como para referencia de API generada automáticamente.

## Presencia y calidad inicial de docstrings

El proyecto usa docstrings con comillas triples (`"""..."""`) de forma consistente en funciones públicas. Ejemplo verificado en `src/black/__init__.py`:

```python
"""Inject Black configuration from "pyproject.toml" into defaults in `ctx`.
"""
```

Los docstrings encontrados son mayormente descriptivos en prosa simple (no siguen estrictamente el formato estructurado de Google o NumPy con secciones `Args:`/`Returns:`), por lo que `napoleon` puede no aportar tanto valor como en proyectos con docstrings más estructurados; aun así, `autodoc` podrá extraer las firmas completas gracias a los type hints, complementando los docstrings en prosa.

## Dependencias o dificultades previstas para generar la documentación

- **Entorno virtual y dependencias de Black:** `autodoc` necesita poder *importar* los módulos de Black para inspeccionarlos, por lo que habrá que instalar Black y sus dependencias (`click`, `mypy_extensions`, `pathspec`, `platformdirs`, `packaging`, etc.) en el entorno virtual antes de generar la documentación.
- **Módulos con dependencias opcionales:** algunos submódulos de Black dependen de librerías opcionales (por ejemplo, soporte de Jupyter notebooks); si no están instaladas, puede ser necesario declarar `autodoc_mock_imports` para esos módulos y documentarlo explícitamente.
- **Docstrings no estructurados:** al no seguir un formato de secciones estricto, la extracción de parámetros/retornos por parte de Sphinx dependerá más de los type hints que de los propios docstrings, lo cual debe explicarse en el análisis de la sección 8.4.
- **Resolución del paquete en `conf.py`:** al no estar el proyecto instalado como paquete en el entorno por defecto, habrá que agregar la ruta de `src/` al `sys.path` de `conf.py` para que `autodoc` lo encuentre.
