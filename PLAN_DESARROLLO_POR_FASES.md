# Plan de Desarrollo por Fases — Memoria P.D.S. (ISO/IEC/IEEE 26515:2024)

> **Documento maestro de instrucciones.** Define cómo construir, fase por fase, la
> Memoria de Producto de Software de **EthosHub** en LaTeX, cumpliendo a cabalidad el
> índice de [`indice_documentacion_iso26515.md`](indice_documentacion_iso26515.md) y
> alcanzando un **mínimo de 140 páginas** con contenido técnico real extraído de los
> repositorios `ethoshubB` (backend) y `ethoshubF` (frontend).

---

## 0. Objetivo y restricciones globales

| Restricción | Valor exigido |
|-------------|---------------|
| **Estándar** | ISO/IEC/IEEE 26515:2024 (+ ISO/IEC/IEEE 15289) |
| **Extensión mínima** | **140 páginas** (cuerpo, sin contar portada e índice) |
| **Nivel de detalle** | Paso a paso. Debe documentarse **toda funcionalidad** real del sistema |
| **Fuente de la información** | `/home/dpardo/Documentos/ethoshubB` (backend) y `/home/dpardo/Documentos/ethoshubF` (frontend). **Nunca inventar funcionalidades**; lo no verificable se omite |
| **Estilo (portada, índice, capítulos)** | Idéntico al de los manuales en `/home/dpardo/Documentos/Documentacion` (Manual Técnico / Instalación) |
| **Idioma** | Español (babel `spanish, es-tabla`) |
| **Cobertura del índice** | Capítulos 1–6 (Sprint 0 → Sprint 5), **todas** las secciones y subsecciones, sin omitir ninguna |

### Producto documentado: EthosHub
Plataforma de **portafolios profesionales y descubrimiento de talento**. Dos roles:
**Profesional** (construye portafolio: proyectos, experiencia, formación, skills, CV Studio
con IA, conexiones, chat) y **Reclutador** (descubre talento, pipeline Kanban, dashboards,
insights IA, chat). Despliegue **monolítico**: el `dist/` de React se empaqueta dentro del
JAR de Spring Boot.

- **Backend:** Java 17 · Spring Boot 4.0.6 · jOOQ · PostgreSQL (Supabase) · Spring Security
  OAuth2 Resource Server (JWT) · Gemini IA · springdoc-openapi · Testcontainers.
- **Frontend:** React 18.3 · TypeScript 5.3 · Vite 5 · Tailwind · Zustand · React Router 6 ·
  Axios · Supabase Realtime · Framer Motion · Recharts · Leaflet · Monaco · dnd-kit · i18next.

### 0.1 Calendario de Sprints (fuente: `PLAN GENERAL.md`)

Cada Sprint dura **2 semanas** (lunes a sábado). Las fechas son **vinculantes** y deben
reflejarse en la ficha técnica de cada capítulo y en el historial de revisiones del documento
(`sections/front/01_historial.tex`). El Sprint 0 (incepción) transcurre antes del Sprint 1.

| Sprint | Inicio | Fin / Entrega | Módulo entregado (Plan General) | Tag |
|--------|--------|---------------|---------------------------------|-----|
| **0** | Lun 16 mar 2026 | Sáb 28 mar 2026 | Incepción, arquitectura y planificación | `release/v0.1.0` |
| **1** | Lun 30 mar 2026 | Sáb 11 abr 2026 | Cuentas de Usuario y Perfil Personal | `release/v1.0.0` |
| **2** | Lun 13 abr 2026 | Sáb 25 abr 2026 | Habilidades y Validaciones de la Comunidad | `release/v1.1.0` |
| **3** | Lun 27 abr 2026 | Sáb 9 may 2026 | Vitrina de Proyectos y Conexión Externa | `release/v1.2.0` |
| **4** | Lun 11 may 2026 | Sáb 23 may 2026 | Visibilidad, Marca Personal y Privacidad | `release/v1.3.0` |
| **5** | Lun 25 may 2026 | Sáb 6 jun 2026 | Estadísticas, Adaptabilidad y Lanzamiento | `release/v2.0.0` |

> **Nota de alineación:** la estructura de capítulos sigue el índice
> `indice_documentacion_iso26515.md` (autoridad sobre el *layout*: Intro → BD → Backend →
> Frontend → Gestión ISO). El **énfasis funcional** de cada sprint debe ajustarse al módulo del
> Plan General (p. ej. Sprint 2 prioriza *Habilidades/Skills* y Sprint 3 la *Vitrina de
> Proyectos*). Donde el contenido actual no coincida con el módulo del Plan General, se corrige
> en la fase de revisión (§6, Fase 0b).

---

## 1. Reglas de estilo y convenciones LaTeX (OBLIGATORIAS)

Estas reglas se aplican en **cada** archivo `.tex`. Son criterio de aceptación.

### 1.1 Listas
- **Todo** `itemize` y `enumerate` debe llevar `[noitemsep]` para evitar interlineado excesivo:
  ```latex
  \begin{itemize}[noitemsep]
  \begin{enumerate}[noitemsep]
  ```
- No anidar listas más de 2 niveles. Preferir frases con `\par` para descripciones largas.

### 1.2 Saltos de línea y párrafos
- Usar `\par` para separar párrafos dentro de una misma idea/bloque.
- Usar `\\` **solo** dentro de tablas o para forzar un salto puntual; **nunca** para simular
  espaciado vertical (eso lo hace `\par` o `\vspace`).
- Evitar `\\` al final de párrafos normales (causa *underfull/overfull hbox*).

### 1.3 Control de página
- `\clearpage` al final de **cada archivo de sección/capítulo** para cerrar flotantes.
- `\chapter{...}` ya genera salto de página; no anteponer `\clearpage` redundante salvo
  necesidad explícita.
- **Prohibido dejar grandes espacios en blanco.** Si una página queda semivacía:
  1. Reordenar contenido (mover una tabla/figura),
  2. Ajustar el texto para que llene la página, o
  3. Usar `\clearpage` deliberado solo cuando el corte sea semánticamente correcto.
- Verificar tras compilar que **ninguna página** tenga más de ~1/3 vacío por mal corte.

### 1.4 Etiquetas (labels) y referencias cruzadas
- Cada capítulo: `\label{cap:sprintN}`.
- Cada sección: `\label{sec:<sprint>_<tema>}` (p. ej. `\label{sec:s0_arquitectura}`).
- Cada subsección relevante, figura y tabla: `\label{...}`.
- Referenciar **siempre** con `\ref{}`/`\autoref{}` para secciones y `\pageref{}` para páginas:
  > «Como se detalla en la Sección~\ref{sec:s1_backend} (pág.~\pageref{sec:s1_backend})…»
- Usar `~` (espacio duro) antes de `\ref`/`\pageref` para no separar «Sección» del número.

### 1.5 Tipografía y macros existentes (reutilizar, no reinventar)
Definidas en `config/04_macros.tex` y `config/03_fonts_colors.tex`:
- `\comando{...}` → código inline en monospace con fondo gris.
- `\setSprint{}`, `\setTag{}`, `\setTaskID{}` → variables dinámicas del encabezado/pie.
- Entornos: `TablaCasoPrueba`, `BugReport`, `TablaBacklog`, `TablaHSDoc`,
  `ChecklistDoD`, y cajas `NotaTecnica`, `BreakingChange`, `AlertaDefecto`.
- Colores: `colorPrimario` (azul `#1A75FB`), `colorSecundario` (verde), `colorAcento` (amarillo).
- Para código multilínea introducir el paquete `listings` o `minted` **solo si se decide**
  (ver Fase 0, tarea T0.2). Por defecto, usar entornos `verbatim`/`lstlisting` controlados.

### 1.6 Figuras e imágenes (¡abundantes!)
- **Requisito explícito: el documento debe contener BASTANTES imágenes.** Mínimo objetivo:
  **3–5 figuras por capítulo** (diagramas C4/ER/secuencia/despliegue, capturas de la SPA,
  Swagger UI, Kanban, dashboards, fragmentos de mockups). Una memoria de 140 págs debería
  rondar **25–35 figuras** en total.
- Cada figura con `\caption{...}` + `\label{fig:...}` y **referenciada** en el texto con `\ref`.
- Anchura: `\includegraphics[width=...\textwidth]{...}` (nunca tamaño absoluto que desborde).
- Fuentes de imágenes, por orden de preferencia:
  1. **Capturas reales** de la aplicación EthosHub (login, dashboard, CV Studio, Kanban,
     Swagger UI, etc.) — guardarlas en `assets/img/screenshots/` y enlazarlas.
  2. **Diagramas vectoriales en TikZ** (ya disponible): C4 contexto/contenedores, ER,
     secuencia (flujo JWT/OTP), estados, despliegue monolítico, pipeline Kanban.
  3. Assets de marca existentes en `assets/img/` (logos UMSS/Byte Busters).
- Tablas anchas → `tabularx` con columna `X`. `\arraystretch` 1.3–1.5.
- Si una captura aún no existe, dejar la figura con un `\fbox` de marcador y un `% TODO:
  reemplazar por captura real` para no romper la maqueta ni dejar huecos.

---

## 2. Estilo de portada e índice (igual a los manuales existentes)

- **Portada** (`sections/00_portada.tex`): conservar la estructura ya presente
  (logo UMSS, Facultad, Taller de Ingeniería de Software, Convocatoria CPTIS-2302-2026,
  datos del proponente Byte Busters S.R.L., fecha). Ajustar el subtítulo a
  «Memoria de Producto de Software — Release Notes por Sprint».
- **Índice**: `\tableofcontents` con `\pagestyle{empty}` (ya configurado en `main.tex`).
- **Encabezado/pie**: `fancyhdr` con logo a la izquierda, `\currentSprint` centrado,
  `\currentTag` a la derecha; pie con `\currentTaskID` y `Pág. X de \pageref{LastPage}`.
- **Títulos de capítulo/sección**: Helvetica bold, `colorPrimario`, tamaños ya definidos
  en `config/02_layout.tex` (capítulo 16pt, sección 14pt).
- Considerar añadir, como en el Manual de Instalación, una página de **historial de
  versiones** (`sections/front/01_historial.tex`) tras la portada.

---

## 3. Mapa Índice → Estructura de archivos

El índice ordena cada capítulo como: **Intro → Base de Datos → Backend → Frontend →
Gestión de la Información (ISO 26515)**. Se reorganiza el árbol `sections/` para reflejarlo
exactamente. Cada subsección del índice = un `\subsection`; cada viñeta `X.Y.Z` = un
`\subsubsection` con su `\label`.

```
sections/
├── 00_portada.tex
├── front/01_historial.tex            (nuevo, historial de versiones)
├── 01_doc-sprint0/
│   ├── 01_objetivos.tex              → 1.1
│   ├── 02_arquitectura.tex           → 1.2 (1.2.1 C4 contexto, 1.2.2 contenedores)
│   ├── 03_database.tex               → 1.3 (1.3.1 ER preliminar, 1.3.2 entidades cuenta/perfil)
│   ├── 04_backend.tex                → 1.4 (1.4.1 entorno/repos, 1.4.2 estructura/CI-CD)
│   ├── 05_frontend.tex               → 1.5 (1.5.1 deps React/estado, 1.5.2 componentes/estética)
│   └── 06_gestion_info.tex           → 1.6 (1.6.1 estrategia doc, 1.6.2 historias de usuario)
├── 02_doc-sprint1/  (mismo patrón → cap. 2)
│   ├── 01_resumen.tex                → 2.1
│   ├── 02_database.tex               → 2.2 (credenciales seguras, roles/accesos)
│   ├── 03_backend.tex                → 2.3 (API auth/registro/verificación, JWT/cifrado/middlewares)
│   ├── 04_frontend.tex               → 2.4 (Navbar+Sidebar responsiva, formularios perfil)
│   └── 05_gestion_info.tex           → 2.5 (borrador spec API, diagrama componentes seguridad)
├── 03_doc-sprint2/                   → cap. 3 (CRUD, dominio transaccional)
├── 04_doc-sprint3/                   → cap. 4 (tiempo real, WebSockets, concurrencia)
├── 05_doc-sprint4/                   → cap. 5 (QA, pruebas E2E, seguridad OWASP, accesibilidad)
└── 06_doc-sprint5/                   → cap. 6 (despliegue, seeders, backups, release notes, CDN)
```

> **Nota:** se renombra/expande la estructura actual (que era intro/backend/frontend/database/
> conclusiones) al nuevo orden del índice. Los Sprints 4 y 5 son **nuevos** (no existían).

---

## 4. Inventario de funcionalidades → asignación por Sprint

Extraído de los READMEs, migraciones `V1`–`V15`, paquetes Java y stores/servicios del frontend.
Cada fase documenta **paso a paso** las funcionalidades que le corresponden.

### Sprint 0 — Incepción y arquitectura base
- Modelo C4 (contexto + contenedores). Stack: Spring Boot 4 + jOOQ + Supabase; React + Vite.
- Decisión de despliegue **monolítico** (FE empaquetado en el JAR).
- ER preliminar: entidades `core.profiles`, cuenta/usuario (Supabase Auth).
- Boilerplate backend: estructura por *feature* (vertical slice), `pom.xml`, `application.yml`,
  CI/CD (`.github/`), `build.sh`.
- Boilerplate frontend: Vite, Tailwind, Zustand, alias `@`, router con guards.
- ISO 26515: estrategia *Documentation as Code*, historias de usuario.

### Sprint 1 — Cimientos, seguridad y autenticación
- **BD:** almacenamiento seguro de credenciales (Supabase Auth), RLS, esquema de roles
  (PROFESSIONAL / RECRUITER / admin), políticas.
- **Backend:** paquetes `auth` (registro, login, OAuth sync, recuperación de contraseña,
  correos), `security` (cambio password/email con OTP, eliminación de cuenta). Resource
  Server OAuth2, validación JWT por JWKS, `CookieTokenFilter`, `SecurityHeadersFilter`,
  `NoCacheFilter`, `CorsConfig`, `AdminEmailPolicy`.
- **Frontend:** layouts (Navbar, Sidebar responsiva solo-móvil), `pages/auth/` (login,
  registro, recuperación, callback OAuth), sesiones múltiples por pestaña (`sessionStorage`,
  `BroadcastChannel`), `authStore`, formularios de perfil, OTP (`input-otp`).
- **ISO 26515:** primer borrador de la spec OpenAPI (Swagger), diagrama de componentes de seguridad.

### Sprint 2 — Lógica de negocio y entidades transaccionales
- **BD:** entidades centrales — `project`, `experience` (V1: campos geográficos),
  `education`, `skills` (V9/V10: soft-delete hard skills), `cv_documents` (V2: soft-delete),
  `profile_settings` (V4). Constraints, vistas operativas, integridad referencial.
- **Backend:** CRUD `ProjectController` (subida multi-PDF, Google Drive),
  `WorkExperienceController`, `AcademicRecordController`, `SkillController`,
  `ProfileController`. `ApiResponse`, validación Jakarta, manejo global de excepciones.
  Pruebas unitarias de validación.
- **Frontend:** vistas dinámicas (listas, tablas, paneles de detalle), `projectsStore`,
  `skillsStore`, servicios (`experienceService`, `educationService`, `fileService`),
  animaciones (Framer Motion), microinteracciones, estados de carga.
- **ISO 26515:** glosario técnico, documentación continua de endpoints nuevos.

### Sprint 3 — Funcionalidades avanzadas y tiempo real
- **BD:** índices estratégicos, V6 (fases Talent Discovery: Kanban, notas, dashboard),
  V7 (idempotencia de mensajes + RPCs de notas seguras), V8 (RPCs seguros de pipeline),
  almacenamiento de sesiones/eventos.
- **Backend:** chat en tiempo real (Supabase Realtime), idempotencia, borrado lógico;
  `ChatController`, `NotificationController`; CV Studio (`CvDocumentController`,
  `FileUploadController`) con compilación LaTeX→PDF y asistente Gemini multi-turno;
  conexiones (`ConnectionController`, V3/V14 URL-first +15 providers); reclutador
  (`TalentController`, `RecruiterAiController` insights IA, búsqueda NLP).
- **Frontend:** Talent Discovery Kanban (dnd-kit), match ring, dashboards (Recharts: funnel,
  radar, KPIs), chat realtime con presencia, CV Studio (Monaco + IA), conexiones, leaflet,
  notificaciones (Sonner).
- **ISO 26515:** manuales de monitoreo de servicios realtime, guías de troubleshooting de concurrencia.

### Sprint 4 — QA, pruebas e integración
- **BD:** *query profiling*, remoción de huérfanos (worker asíncrono de archivos),
  V11 (fix RPCs chat/perfil + wrapper talent-views), V12/V13 (sync cambio de email),
  V15 (política SELECT likes), scripts de migración de optimización final.
- **Backend:** refactor de seguridad (OWASP: rate limiting, blacklist de JWT, sanitización
  XSS, *magic numbers*, anti path-traversal, `Content-Disposition`), logging estructurado,
  telemetría, `AiServiceException` (429/5xx mapping). Pruebas de carga, Testcontainers.
- **Frontend:** *cross-device testing*, accesibilidad/contrastes, pruebas E2E de flujos,
  Vitest + Testing Library, ESLint.
- **ISO 26515:** *technical review* editorial, pruebas de usabilidad de la documentación.

### Sprint 5 — Despliegue, empaquetado y cierre
- **BD:** seeders de datos maestros, políticas de backups y recuperación (Supabase).
- **Backend:** variables de entorno/secretos (`application-prod.yml`, rotación de claves),
  despliegue en producción/contenedores (Dockerfile, docker-compose), balanceo de carga.
- **Frontend:** build optimizado (`tsc && vite build`), minificación, code splitting
  (vendor chunk), distribución de assets estáticos (servidos por el JAR / CDN).
- **ISO 26515:** Release Notes integrales, empaquetado y versionado de la base de
  conocimiento embebida en el repositorio.

---

## 5. Presupuesto de páginas (para alcanzar ≥140)

| Capítulo | Contenido | Páginas objetivo |
|----------|-----------|------------------|
| Portada + índice + historial | front matter | 4 |
| Cap. 1 — Sprint 0 | arquitectura, C4, ER, boilerplate, ISO | 22 |
| Cap. 2 — Sprint 1 | seguridad, auth, JWT, frontend auth | 24 |
| Cap. 3 — Sprint 2 | CRUD, dominio, vistas, pruebas | 26 |
| Cap. 4 — Sprint 3 | realtime, WebSockets, CV Studio, reclutador | 30 |
| Cap. 5 — Sprint 4 | QA, OWASP, E2E, accesibilidad | 22 |
| Cap. 6 — Sprint 5 | despliegue, backups, release notes | 18 |
| **Total** | | **≈146** |

> Cada capítulo combina: prosa técnica densa + tablas (endpoints, casos de prueba, backlog) +
> figuras (diagramas C4, ER, secuencia) + bloques de código + cajas `NotaTecnica`/`BreakingChange`.
> La densidad se logra documentando **paso a paso** cada funcionalidad, no rellenando.

---

## 6. Fases de ejecución

> Una **fase = un capítulo (Sprint)**. Se ejecutan en orden. Tras cada fase: compilar,
> revisar páginas (sin huecos), validar labels/referencias, contar páginas acumuladas.

- **Fase 0 — Andamiaje:** reorganizar `sections/`, actualizar `main.tex` con los 6 sprints
  e `\include` nuevos, ajustar portada, añadir historial, decidir paquete de código
  (`listings`), verificar que compila en vacío. (T0.1 estructura · T0.2 código · T0.3 portada)
- **Fase 0b — Revisión y corrección de los Sprints ya escritos (OBLIGATORIA):** los Sprints
  que ya existían/se redactaron (Sprint 0 a 3) **deben revisarse y corregirse** antes de darse
  por buenos. Puntos a verificar:
  1. **Stack correcto:** eliminar restos de tecnologías erróneas (p. ej. *Next.js*, *Node v20*,
     *Spring Boot 3.4.1*) y dejar el stack real (**React + Vite / Spring Boot 4.0.6**).
  2. **Fechas:** alinear la ficha de cada sprint y el historial con el calendario §0.1.
  3. **Énfasis funcional:** ajustar el contenido al módulo del Plan General (Sprint 2 →
     Habilidades; Sprint 3 → Vitrina de Proyectos).
  4. **Reglas LaTeX §1:** `noitemsep`, `\par`/`\\`, `\clearpage`, labels y `\ref`/`\pageref`.
  5. **Imágenes:** comprobar que cada capítulo ya escrito alcanza el mínimo de figuras (§1.6).
  6. **Huecos en blanco:** corregir cortes de página defectuosos.
- **Fase 1 — Sprint 0** → `sections/01_doc-sprint0/*` (objetivo ≈22 pág.)
- **Fase 2 — Sprint 1** → `sections/02_doc-sprint1/*` (≈24 pág.)
- **Fase 3 — Sprint 2** → `sections/03_doc-sprint2/*` (≈26 pág.)
- **Fase 4 — Sprint 3** → `sections/04_doc-sprint3/*` (≈30 pág.)
- **Fase 5 — Sprint 4** → `sections/05_doc-sprint4/*` (≈22 pág.)
- **Fase 6 — Sprint 5** → `sections/06_doc-sprint5/*` (≈18 pág.)
- **Fase 7 — Cierre:** compilación final, conteo ≥140, revisión de huecos en blanco,
  consistencia de referencias cruzadas, ortografía, índice correcto.

### Procedimiento por subsección (repetible)
1. Leer la fuente real en `ethoshubB`/`ethoshubF` (paquete, migración, store, servicio).
2. Redactar prosa paso a paso de la funcionalidad (qué, cómo, por qué).
3. Añadir tabla(s) (endpoints / esquema / casos de prueba / backlog) con `tabularx`.
4. Insertar figura/diagrama si aporta (con `\caption` + `\label`).
5. Poner `\label` a sección/subsección; enlazar con `\ref`/`\pageref` desde otras partes.
6. Verificar `[noitemsep]` en toda lista, uso correcto de `\par`/`\\`, y `\clearpage` al final.

---

## 7. Checklist de aceptación (por fase y final)

- [ ] El índice del documento coincide **exactamente** con `indice_documentacion_iso26515.md`.
- [ ] Todas las secciones y subsecciones (X.Y y X.Y.Z) están presentes.
- [ ] Contenido derivado de los repos reales; sin funcionalidades inventadas.
- [ ] **Sprints ya escritos (0–3) revisados y corregidos** (Fase 0b): stack real, sin Next.js.
- [ ] **Fechas de cada sprint** alineadas con el calendario §0.1 (ficha + historial).
- [ ] **Imágenes abundantes:** ≥3–5 figuras por capítulo, todas con `\caption`+`\label`+`\ref`.
- [ ] `[noitemsep]` en **todo** `itemize`/`enumerate`.
- [ ] Uso correcto de `\par` y `\\`; sin `\\` para espaciar párrafos.
- [ ] `\clearpage` al cierre de cada sección; sin páginas con grandes huecos en blanco.
- [ ] `\label` en capítulos, secciones, figuras y tablas; referencias con `\ref`/`\pageref`.
- [ ] Portada, índice, encabezados y estilo idénticos a los manuales de `/Documentacion`.
- [ ] Compila sin errores (`pdflatex`/`latexmk`); auxiliares van a `/build`.
- [ ] **≥ 140 páginas** de cuerpo.

---

## 8. Comandos de compilación y verificación

```bash
cd /home/dpardo/Documentos/Documentacion/04_Memoria-PDPS
make            # o: latexmk -pdf main.tex   (usa .latexmkrc → salida en /build)
pdfinfo build/main.pdf | grep Pages    # verificar conteo de páginas ≥ 140
```

Revisión de huecos en blanco: abrir `build/main.pdf` y recorrer páginas; corregir cortes
defectuosos reubicando tablas/figuras o ajustando texto (ver §1.3).
</content>
</invoke>
