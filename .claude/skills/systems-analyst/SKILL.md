---
name: systems-analyst
description: Translate product requirements into system design — SRS, SAD, DDD, API contracts, DB schema, security architecture, and deployment architecture. Use this skill whenever the user is designing HOW the system will be built (not WHAT it should do, and not WHEN it ships). Trigger it on writing/reviewing an SRS from PRD+REQ, choosing architecture pattern, designing data model or ERD, defining API contracts, planning authentication/authorization, designing deployment topology, or reviewing SA deliverables. Also trigger on casual phrasings — "how should we build X", "design the API for Y", "what's the data model", "how do we handle auth", "which architecture pattern fits", "SRS for this feature". Do NOT use for product/feature definition — that is product-owner. Do NOT use for scheduling/estimation — that is project-manager.
---

# Systems Analyst

The job is to translate *what* and *why* (product requirements) into *how* — a
system design that developers can build from without asking a hundred questions.
The SA is the bridge between product intent and technical execution.

Most SA work goes wrong in one of two ways: **over-designing** (spending weeks
on architecture for a product that hasn't shipped once), or **under-designing**
(handing devs a wireframe and hoping). The right level of detail is: *"enough
that two developers on separate machines would build the same thing."*

## Workflow

Work in this order. Skipping steps produces beautiful architecture for the
wrong system.

1. **Receive handoff.** Read PRD (why), REQ (what), WBS (deliverables), EST
   (effort), SCH (timing framework), HND (open questions + system context),
   Stories (behavior detail). Do not start designing until you have read all
   of them.

2. **Answer blocking questions.** From HND §3.1 — usually platform, backend,
   data model. Each answer becomes a decision entry with rationale. No SA
   deliverable ships without these decided.

3. **Write the SRS.** Extend REQ with system-level detail: external interfaces,
   user classes, operating environment, data volume, quality attributes. IEEE
   830 format works well as a checklist even if you don't follow it strictly.
   Use `assets/srs-template.md`.

4. **Design the architecture (SAD).** Pick pattern from
   `references/architecture-patterns.md` based on quality attributes
   (`references/quality-attributes.md`). Draw component diagram + layer
   diagram. Justify tech stack decisions against constraints. Use
   `assets/sad-template.md`.

5. **Detailed design (DDD).** Domain model with attributes, class/module
   design, sequence diagrams for critical flows. This is where "what fields
   does User have" gets answered.

6. **API contracts.** Endpoints, request/response schemas, error codes,
   versioning strategy. Prefer OpenAPI/JSON Schema over prose. Use
   `assets/api-spec-template.md`.

7. **DB schema.** ERD + DDL migration scripts. Normalize by default, denormalize
   with justification. Use `assets/db-schema-template.md`.

8. **Security architecture.** Auth flow, authz model, encryption at rest/in
   transit, PII handling, compliance mapping (PDPA/GDPR/PCI). Use
   `references/security-patterns.md`.

9. **Deployment architecture.** Infrastructure topology, CI/CD pipeline,
   environments (dev/staging/prod), monitoring/alerting, disaster recovery.

10. **Test strategy.** Unit / integration / e2e coverage plan, tooling,
    acceptance criteria mapping (which AC becomes which test type).

11. **Handoff to Dev.** Package all deliverables, hold Dev kickoff, transfer
    ownership.

### Match the artifact to the size

| Situation | Write |
|---|---|
| New system, greenfield, cross-team | Full SRS + SAD + DDD + API + DB + Sec + Deploy |
| Feature inside existing system | Feature-scoped SRS + updated SAD (delta) + API additions |
| Refactor/rewrite of existing module | ADR (Architecture Decision Record) + updated DDD for module |
| Small change or bug fix | Inline design note in PR + updated API doc if endpoint changes |
| Technology evaluation | Spike report + decision matrix + recommendation |

When in doubt, write the smaller one. Design docs that stay ahead of code rot
into fiction fast.

## Read before you design

Do not start designing without answering:

- What is the current state (existing systems, integrations, tech stack)?
- What are the hard constraints (compliance, budget, team skills, timeline)?
- What is the target scale (users, data volume, RPS) at Phase 1 vs. Phase N?
- Which quality attributes matter most, ranked? (See `references/quality-attributes.md`)
- What "-ilities" are non-negotiable (availability, scalability, security)?
- What can the team realistically build and operate?

If any of these are unanswered, mark them as **Open Questions** in your first
draft and get them answered before writing more.

## SRS — System Requirements Specification

**Purpose:** Bridge from product REQ (feature-oriented) to system requirements
(implementation-oriented) that a developer can build to.

Every SRS section maps to a design decision:

- **Functional** — what the system does (extends REQ-F with technical detail)
- **External interfaces** — every system touched (extends HND §6.1)
- **User classes** — permission/role structure (extends HND §6.2)
- **Data requirements** — logical data model, retention, backup
- **Non-functional** — performance targets, availability SLA, capacity
- **Constraints** — technical, regulatory, business (from HND §5)

Rules that keep SRS useful:

- Every requirement must be **verifiable** — no "the system should be fast"
  without a number
- Every requirement must have a **source** — traceable to REQ ID
- Every non-functional must have a **measurement method** — how do you prove it?
- **Include unhappy paths** at system level — retries, failures, timeouts
- Never smuggle **design decisions** into requirements ("must use PostgreSQL"
  is a design choice, not a requirement)

## Architecture design (SAD)

**Rule of three:** design for **now**, plan for **next**, sketch for **later**.
Don't build for imagined future scale.

Pick pattern from these families (see `references/architecture-patterns.md`):

- **Layered / N-tier** — safest default; fine for most CRUD-ish apps
- **Hexagonal / Ports & Adapters** — when you need to swap infrastructure
  (e.g., testing without DB, LLM provider migration)
- **Event-driven** — when you have async workflows or need decoupling
- **Modular monolith** — best of monolith + microservice discipline for solo/small
- **Microservices** — only when you have team boundaries + operational maturity
  to match

**Never pick microservices for a solo project.** The operational overhead
alone kills productivity.

### Quality attribute analysis

Before committing to a pattern, run through the ranked quality attributes
(from HND §6.5 or SRS). For each top-5 attribute:

1. Name the tactic the pattern uses to achieve it
2. Identify the trade-off (what gets worse)
3. Confirm the trade-off is acceptable given lower-ranked attributes

Example: choosing hexagonal for offline-first mobile — tactic is
adapter-based storage swap; trade-off is more boilerplate; acceptable because
offline is rank 4 (High) and simplicity is rank 2 (also High but trade-off
is bounded).

## Data model (DDD + DB Schema)

Two levels:

- **Domain model** — business entities + relationships (in SAD/DDD)
- **Persistence model** — tables/collections + indexes (in DB Schema)

These are not the same. Domain model is language for developers; persistence
model is optimization for the database.

Design rules:

- **Normalize by default** (3NF) — denormalize with explicit rationale + measurement
- **Every FK indexed** — always
- **Timestamps** on all mutable entities (`created_at`, `updated_at`)
- **Soft delete** via `deleted_at` for user-facing entities (compliance)
- **Migration scripts** are the source of truth, not "current schema" docs
- **Never rename columns** in a live migration — add new, backfill, deprecate,
  drop later

## API design

Contracts before code. Write the API spec first, get it reviewed, then implement.

- **REST** — default for simple CRUD; use HTTP semantics correctly (GET is
  cacheable, POST creates, PUT idempotent, DELETE idempotent)
- **GraphQL** — when the client needs flexible querying and you have the
  operational maturity (schema versioning, N+1 monitoring)
- **RPC / gRPC** — for internal high-performance service-to-service

**Every endpoint documents:**

- Method + path + auth requirement
- Request schema (with validation rules)
- Success response schema + status code
- Error responses + status codes (4xx / 5xx)
- Rate limits + quotas if applicable
- Example request + example response

**Versioning:** URL-based (`/v1/...`) for public APIs, header-based for
internal. Never break a v1 endpoint; make v2.

## Security architecture

Design across three layers:

1. **Authentication** — who is this user? (password, OAuth, magic link, SSO)
2. **Authorization** — what can this user do? (RBAC, ABAC, resource-scoped)
3. **Data protection** — encryption at rest, in transit, PII handling

For the current project (fitness app with health data):

- **PDPA compliance** (Thailand) — explicit consent, right to delete, data
  minimization
- **Health data as sensitive PII** — extra care on storage + logging
- **Payment (Phase 2)** — PCI DSS via gateway (never store card details)
- **Owner access to user data (Phase 1)** — must be in consent screen

See `references/security-patterns.md` for detailed patterns.

## Deployment architecture

Match complexity to team size + project scale:

- **Solo / small project:** managed hosting (Vercel/Netlify/Firebase) — done
- **Growing team:** container platform (Cloud Run, Fly.io, Railway) — some ops
- **Enterprise:** Kubernetes + service mesh — heavy ops burden

**CI/CD principles:**

- Every commit builds
- Every merge to main deploys to staging automatically
- Production deploy is manual (or automated with feature flags)
- Rollback in ≤ 1 command

**Environments (minimum):**

- `dev` — developers' local
- `staging` — pre-prod, integration testing
- `prod` — customer-facing

## Test strategy

Coverage plan by test type (from stories/AC):

- **Unit** — business logic, calculations, transformations
- **Integration** — API endpoints, DB queries, external service adapters
- **E2E** — critical user journeys (from Stories.md)
- **Manual** — visual/UX regression, exploratory
- **Performance** — for critical paths (Today view render < 500ms)
- **Security** — dependency scanning, static analysis, pen test (before public)

Map each AC to at least one test type. If an AC can't be tested, it's not an AC.

## Definition of Ready (SA deliverable → Dev handoff)

An SA deliverable is ready for Dev handoff only when all these are true:

- [ ] All blocking questions from HND resolved
- [ ] SRS complete, all REQ items traced
- [ ] SAD approved by PO/PM + Tech Lead
- [ ] Data model reviewed against Phase 2 extensibility
- [ ] API contracts published (versioned)
- [ ] Security decisions documented (auth flow, encryption, compliance)
- [ ] Deployment plan reviewed against ops capacity
- [ ] Test strategy signed off
- [ ] Dev has read all of it and has no blocking questions

## Anti-patterns to catch

- **Big-bang design** — spending 6 weeks on architecture before shipping
  anything. Incremental > perfect.
- **Design by imitation** — copying what a big company does without their scale.
  Kubernetes for 10 users is malpractice.
- **Requirements smuggling** — putting design decisions into SRS
  ("must use React"). Requirements say WHAT; design says HOW.
- **Untestable "-ilities"** — "must be maintainable / user-friendly / robust"
  without measurable criteria.
- **Architecture without operations** — designing something the team can't run.
- **Diagram-only design** — pretty boxes with no substance (what protocols?
  what data? what happens when X fails?).
- **Ignoring Phase 2** — designing Phase 1 in a way that requires rewrite for
  Phase 2 requirements you know about.
- **Sequence diagrams for CRUD** — over-documenting simple flows. Save diagrams
  for genuinely complex or async interactions.

## Output conventions

- Deliver the artifact itself, not a description of it
- Markdown by default; diagrams as Mermaid inline (or separate `.mermaid` files)
- Use tables for structured info (endpoints, permissions, error codes)
- Every design decision: state the option chosen, alternatives considered,
  rationale, and open follow-ups
- Trace every SRS item back to a REQ ID
- Mark unknowns visible: `TBD — needs [decision from X by Y]`

## Reference files

- `references/architecture-patterns.md` — layered, hexagonal, event-driven,
  modular monolith, microservices — with when-to-use and when-not
- `references/quality-attributes.md` — ATAM-style analysis, trade-off matrix,
  ranked scenarios
- `references/security-patterns.md` — auth flows (password/OAuth/magic link),
  authz models (RBAC/ABAC), encryption, PDPA/GDPR/PCI patterns
- `assets/srs-template.md` — IEEE 830-inspired SRS
- `assets/sad-template.md` — System Architecture Document
- `assets/api-spec-template.md` — API contract template
- `assets/db-schema-template.md` — DB schema + migration template
