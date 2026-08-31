Introducción a Black
=====================

Esta página fue escrita como parte del Laboratorio 1 (IE0417) para presentar
el propósito y la organización general del proyecto documentado.

¿Qué es Black?
---------------

`Black <https://github.com/psf/black>`_ es un formateador de código Python
"sin concesiones" (*uncompromising*): en lugar de ofrecer decenas de opciones
de estilo configurables, aplica un único conjunto de reglas de formato de
manera determinista sobre el código fuente que recibe. El objetivo declarado
del proyecto es eliminar las discusiones de estilo en las revisiones de
código, ya que Black siempre produce el mismo resultado para una misma
entrada.

Está mantenido bajo el paraguas de la **Python Software Foundation** y es
usado por una gran cantidad de proyectos del ecosistema Python como parte de
su integración continua.

Organización del código fuente
--------------------------------

El paquete principal vive en ``src/black/`` y se organiza, a grandes rasgos,
en los siguientes grupos de módulos:

- **Punto de entrada y orquestación:** :mod:`black` (``__init__.py``) reúne
  la lógica principal de la herramienta de línea de comandos y coordina el
  resto de los módulos.
- **Análisis sintáctico:** :mod:`black.parsing` y el paquete ``blib2to3``
  (no documentado en esta entrega por estar fuera del umbral analizado) se
  encargan de convertir el código fuente en un árbol de sintaxis.
- **Generación de líneas formateadas:** :mod:`black.linegen`,
  :mod:`black.lines` y :mod:`black.brackets` construyen y organizan las
  líneas de salida ya formateadas.
- **Utilidades de dominio específico:** módulos como :mod:`black.strings`,
  :mod:`black.numerics`, :mod:`black.comments` y :mod:`black.trans` aplican
  reglas de formato sobre literales, comentarios y transformaciones
  puntuales del código.
- **Configuración y modos:** :mod:`black.mode` define las opciones de
  formato disponibles (longitud de línea, versión de destino, etc.).
- **Soporte adicional:** :mod:`black.cache`, :mod:`black.concurrency`,
  :mod:`black.report` y :mod:`black.output` cubren aspectos de
  infraestructura (caché de archivos ya formateados, procesamiento en
  paralelo y salida de resultados).

Alcance de esta documentación
-------------------------------

Esta documentación cubre el paquete ``black`` ubicado en ``src/black``, en el
commit ``8947c48ef2077c3a301b03c1e814dc2e3f78436e`` del repositorio original.
No se documentan los paquetes ``blackd`` (servidor HTTP opcional, que
requiere la dependencia ``aiohttp``) ni ``blib2to3`` (gramática de Python
adaptada de la biblioteca estándar), ya que quedan fuera del subsistema
analizado para este laboratorio.

.. toctree::
   :maxdepth: 1

   api/modules
