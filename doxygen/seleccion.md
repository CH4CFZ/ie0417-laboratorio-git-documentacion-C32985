# Selección de proyecto - Doxygen (C++)

## Datos generales

| Campo | Valor |
|---|---|
| Nombre | {fmt} |
| Descripción breve | Biblioteca de C++ para formateo de texto rápido, seguro en cuanto a tipos y con sintaxis inspirada en Python (`str.format`). Sirve como base del `std::format` incorporado en C++20. |
| URL del repositorio original | https://github.com/fmtlib/fmt |
| Licencia | MIT |
| Lenguaje principal | C++ |
| Commit exacto analizado | `b039e624c02ae473280156235217f9e02792b055` |

## Tamaño del proyecto

| Métrica | Valor |
|---|---|
| Archivos relevantes | 74 (26 `.h`, 47 `.cc`, 1 `.c`) |
| Líneas de código (sin blancos ni comentarios) | 46 309 |
| Comando utilizado | `cloc fmt --include-lang=C++,C,"C/C++ Header"` |

Salida completa del comando:

```text
-------------------------------------------------------------------------------
Language                     files          blank        comment           code
-------------------------------------------------------------------------------
C/C++ Header                    26           5286          10111          27214
C++                             47           3621           4583          19012
C                                1             23              6             83
-------------------------------------------------------------------------------
SUM:                            74           8930          14700          46309
-------------------------------------------------------------------------------
```

Ambos umbrales del laboratorio se superan con amplio margen (≥10 000 líneas y ≥30 archivos fuente), sin necesidad de recurrir a un subsistema.

## Razón por la cual el proyecto es apropiado para Doxygen

- Es una biblioteca de C++ real y ampliamente usada en producción por proyectos como LLVM, Blender, MongoDB y muchos otros; no es un ejercicio de clase ni un repositorio creado para ilustrar Doxygen.
- Tiene una separación clara entre interfaz pública (`include/fmt/`) e implementación (`src/`), lo cual facilita que Doxygen genere una referencia de API navegable y bien delimitada.
- Usa una jerarquía de clases y plantillas de C++ moderada (no trivial, pero tampoco tan extensa como para volverse inmanejable), lo que permite que Doxygen genere diagramas de clases y de colaboración útiles con Graphviz.
- Tiene cientos de colaboradores y miles de commits, lo que confirma que es un proyecto de software libre activo y no artificial.

## Presencia y calidad inicial de comentarios Doxygen

El código ya usa comentarios de estilo Doxygen de forma consistente en los headers públicos, principalmente:

- Bloques `/** ... */` para documentar funciones y clases completas.
- Comentarios de una línea `///` para miembros individuales y estructuras auxiliares.

Ejemplo verificado en `include/fmt/format.h`:

```cpp
/// An error reported from a formatting function.
```

Esto significa que gran parte del trabajo de Doxygen será **extraer** documentación ya existente, más que depender de `EXTRACT_ALL` para inferir todo desde las firmas del código. Aun así, no toda la base de código está comentada al mismo nivel, especialmente en detalles de implementación (`src/`), por lo que se espera cierta variación en la cobertura.

## Dependencias o dificultades previstas para generar la documentación

- **Graphviz:** para generar diagramas de clases y de llamadas (`HAVE_DOT=YES`) es necesario tener instalado Graphviz (`dot`) en el entorno donde se ejecuta Doxygen.
- **Plantillas de C++:** fmt usa fuertemente plantillas (`template`) y macros de preprocesador; Doxygen puede tener dificultad para resolver algunas instanciaciones de plantillas complejas, lo cual puede generar advertencias que habrá que clasificar y explicar en `doxygen/build.log`.
- **Archivos de implementación vs. cabecera:** al incluir tanto `include/` como `src/` en `INPUT`, es probable que aparezcan símbolos duplicados o advertencias de miembros no documentados en `src/`, que deberán revisarse.
- No se detectan dependencias externas de compilación necesarias solo para generar la documentación (Doxygen analiza el código fuente sin necesidad de compilarlo).
