# Plantilla de Memoria P.D.S. (Release Notes) - Estándar ISO/IEC/IEEE 26515:2024

## Logo
![Logo Byte Busters](assets/img/bytebusters/logo_horizontal.png)

## Insignias
[![LaTeX](https://img.shields.io/badge/LaTeX-Project-008080.svg?style=flat&logo=latex&logoColor=white)](https://www.latex-project.org/)
[![License: CC0-1.0](https://img.shields.io/badge/License-CC0_1.0-lightgrey.svg)](http://creativecommons.org/publicdomain/zero/1.0/)
[![Standard: ISO 26515](https://img.shields.io/badge/Standard-ISO/IEC/IEEE_26515-blue)](https://www.iso.org/standard/79553.html)

## Perfil de Github - Introducción
Este repositorio proporciona una infraestructura técnica en **LaTeX** diseñada para generar **Memorias de Producto de Software (P.D.S.) y Release Notes** en entornos ágiles, cumpliendo estrictamente con el estándar internacional **ISO/IEC/IEEE 26515:2024** (Developing information for users in an agile environment). Está optimizado para la empresa **Byte Busters S.R.L.** en el marco de la Facultad de Ciencias y Tecnología de la UMSS.

## Características
* **Cumplimiento Normativo (Ágil):** Implementa la estructura incremental orientada a Sprints exigida por la norma ISO 26515 y apoyada en ISO 15289 (Software Product Specification).
* **Identidad Visual Minimalista:** Tipografías corporativas preconfiguradas, optimizadas con fuente a 10pt e interlineado de 1.15 para no generar burocracia documental excesiva.
* **Diseño de Layout:** Márgenes exactos de 3cm (interno) y 2cm (externo) con trazabilidad orientada a "Documentation as Code".
* **Componentes de Usabilidad Ágil:** Macros visuales para Etiquetas de Historias de Usuario (`\tagUS{}`), Alertas de Cambios Críticos (Breaking Changes) y Tablas de Cierre de Sprint.
* **Gestión de Compilación:** Redirección automática de archivos auxiliares a la carpeta `/build` para mantener el directorio limpio.

## Tecnología
* **Lenguaje de Marcado:** LaTeX.
* **Motor de Compilación:** `pdflatex` con soporte para tablas avanzadas (`xcolor`, `tabularx`).
* **Automatización:** `latexmk` para gestión de dependencias y `Makefile` para atajos de terminal.
* **Editor Sugerido:** Visual Studio Code con extensión *LaTeX Workshop*.

## Perfil de Github - Habilidades
* **Agile Documentation:** ISO/IEC/IEEE 26515:2024.
* **Software Product Specification (SPS):** ISO/IEC/IEEE 15289:2024.
* **Typesetting:** LaTeX, Diseño de Información Minimalista.
* **Project Management:** Sincronización de Release Notes para Taller de Ingeniería de Software (TIS).

## Instalación
Para utilizar esta plantilla localmente y generar la memoria al cierre de su Sprint, clona el repositorio:

```bash
git clone [https://github.com/dpardo23/manual-usuario.git](https://github.com/dpardo23/manual-usuario.git)
cd manual-usuario
```

## Corre Localmente
Utiliza el `Makefile` o `latexmk` incluido para gestionar la compilación del reporte:

```bash
# Compilar la memoria del Sprint actual
latexmk -pdf -outdir=build main.tex 

# Limpiar archivos temporales y la carpeta build
make clean
```

## Ejecutando Pruebas
Para validar que el entorno está correctamente configurado y que los colores de las etiquetas compilan bien, ejecute:
1. `make clean`
2. `make all`
3. Verifique la existencia del PDF en `build/main.pdf`.

## Uso/Ejemplos
La plantilla incluye componentes específicos para redactar los logros de un Sprint de manera rápida y altamente visual:

```latex
% Listado de nuevas funcionalidades y bugs con tags visuales
\begin{itemize}
    \item \tagUS{US-042} Implementación de exportación masiva a formato PDF.
    \item \tagUS{BUG-102} Se resolvió el timeout en consultas pesadas.
\end{itemize}

% Componente para alertar sobre ruptura de compatibilidad hacia atrás
\begin{BreakingChange}
La actualización del ORM requiere ejecutar el script \tagTech{V2.1.0\_\_update\_schema.sql}.
\end{BreakingChange}

% Tabla de sincronización de la Definition of Done
\begin{TablaHSDoc}
\tagUS{US-042} & Exportación PDF & Sí (Sec 4) & Sí (Endpoint /export) \\
\hline
\end{TablaHSDoc}
```

## Variables de Entorno y Configuración Dinámica
La configuración del flujo de trabajo se divide en dos partes:
1. **Compilación (`.latexmkrc`):** * `$out_dir = 'build'`: Los binarios se guardan aquí.
   * `$pdf_mode = 1`: Fuerza salida en PDF.
2. **Variables de Sprint (En `main.tex`):** Antes de compilar cada versión, debe actualizar las variables globales que alimentan los encabezados:
   ```latex
   \setSprint{Sprint 5 - Closed}
   \setTag{release/v2.1.0}
   \setTaskID{Jira: SPRINT-05}
   \setDocOwner{Documentation Owner: J. Pardo}
   ```

## Capturas de Pantalla
El diseño final respeta los siguientes estándares de identidad corporativa en entornos ágiles:
* **Encabezados:** Logo de Byte Busters S.R.L. a la izquierda, Estado del Sprint al centro, y la Referencia a la rama de Git (Tag) a la derecha.
* **Pie de Página:** ID de trazabilidad en el gestor de proyectos (ej. Jira), el Propietario del Documento y paginación dinámica.
* **Colores:** Azul Corporativo (#080852) para elementos primarios, Naranja (#FF9800) exclusivo para Breaking Changes, y Verde (#2E7D32) para Historias de Usuario.

## Documentación
El documento maestro (`main.tex`) está estructurado bajo los lineamientos de entregas incrementales:
* **Identificación del Incremento:** Número de Sprint y Versión Semántica (Mayor.Menor.Parche).
* **Resumen de Cambios (Release Notes):** Nuevas funcionalidades, mejoras y correcciones de bugs.
* **Especificación Técnica del Producto (SPS):** Componentes modificados y dependencias actualizadas.
* **Instrucciones de Actualización:** Pasos y scripts para migrar a la nueva versión.
* **Impacto en el Usuario:** Actualizaciones necesarias en el Manual Final.
* **Problemas Conocidos:** Limitaciones técnicas pospuestas (Deuda Técnica).

## Hoja de Ruta
* [ ] Implementación de Webhooks para autocompletar la sección de Release Notes directamente desde Jira.
* [ ] Script en bash para inyectar automáticamente el tag de Git (`\setTag`) al ejecutar `make release`.
* [ ] Soporte para marcas de agua de "Confidencial" con opacidad inferior al 10%.

## Optimizaciones
* **Minimalismo Visual:** Se redujo la tipografía base a 10pt y el interlineado a 1.15 para condensar la información técnica y facilitar la lectura en pantalla ("Documentation as Code").
* **SyncTeX:** Habilitado para navegación bidireccional entre el código fuente y el PDF generado.
* **Tablas Autoajustables:** Implementación de `tabularx` con sombreado de filas (`\rowcolor`) para revisar rápidamente el checklist de documentación por cada Historia de Usuario.

## Relacionado
* Sitio Oficial de la Empresa TIS
* Guía de Estilo ISO/IEC/IEEE 26515:2024
* Guía de Especificación ISO/IEC/IEEE 15289:2024

## FAQ

**¿Por qué debo usar los comandos `\setSprint` y `\setTag`?**
En entornos ágiles, la documentación cambia rápido. Centralizar estas variables evita que tengas que buscar y reemplazar manualmente el número de versión a lo largo de todas las páginas del documento.

**¿Cómo cambio el nombre del PDF de salida?**
Modifique la variable `DOCNAME` en el archivo `Makefile`.

## Lecciones
Durante la adaptación a la norma ISO 26515, se aprendió que la documentación ágil no significa "falta de documentación", sino "documentación precisa y sin fricción". La creación de comandos cortos como `\tagUS{}` redujo significativamente el tiempo de transcripción de los desarrolladores al momento de cerrar un Sprint.

## Autores
* **Razón Social:** Byte Busters S.R.L.
* **Representante Legal / Product Owner:** Juan Diego Pardo Pozo
* **Consultor TIS:** Corina Justina Flores Villarroel

## Feedback y Apoyo
Para reportar discrepancias entre el Release Note y el software entregado, escriba a: contacto.bytebusters@gmail.com.

## Licencia
Este proyecto se distribuye bajo la licencia CC0 1.0 Universal (Public Domain Dedication). Puedes copiar, modificar y distribuir el trabajo, incluso con fines comerciales, sin pedir permiso.
