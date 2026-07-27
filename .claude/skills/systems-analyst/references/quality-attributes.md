# Quality Attributes — Ranking, Trade-offs, and Scenarios

Quality attributes (a.k.a. "-ilities") are the drivers that shape architecture.
Get them ranked and measured before picking any pattern.

## 1. The core 10 attributes

| Attribute | Definition | Typical measurement |
|---|---|---|
| **Availability** | System uptime | 99.9% / 99.99% |
| **Performance** | Response time, throughput | p95 latency, RPS |
| **Scalability** | Handle more load | Load capacity, horizontal scaling factor |
| **Security** | Confidentiality, integrity, auth | Threat model, compliance certs |
| **Maintainability** | Cost of change | Time to add feature, tech debt ratio |
| **Reliability** | Correctness under stress | MTBF, error rate |
| **Testability** | Ease of verification | Code coverage, test speed |
| **Usability** | User experience quality | Task success rate, SUS score |
| **Portability** | Move across environments | Effort to migrate |
| **Interoperability** | Play well with others | Standards adopted, integration count |

## 2. Ranking approach

**Rule 1:** Never say "all are top priority." Force a strict ranking.
**Rule 2:** Rankings come from the business, not from SA taste.
**Rule 3:** Top 3–5 drive architecture; the rest are "as good as we can get."

Example ranking (fitness app for solo dev):

| Rank | Attribute | Why |
|---|---|---|
| 1 | Safety (health/legal) | Regulatory + trust |
| 2 | Simplicity/maintainability | Solo dev sustainability |
| 3 | Usability (glanceable) | Core UX promise |
| 4 | Availability (offline) | Gym Wi-Fi is trash |
| 5 | Cost | Personal project |
| ... | Rest | Baseline OK |

## 3. Quality Attribute Scenarios (QAS)

Every top attribute should have measurable scenarios. Format:

```
Source (who/what) → Stimulus (event) → Environment (context)
→ Artifact (part of system) → Response (what happens)
→ Response measure (how measured)
```

### Example scenarios

**Performance scenario:**
> A returning user opens Today view on a mid-tier phone with cached data.
> The view must render fully within 500ms at p95.

- Source: User
- Stimulus: Open app
- Environment: cached data, mid-tier phone
- Artifact: Today view
- Response: full render
- Response measure: 500ms p95

**Availability scenario:**
> A user opens the app inside a gym with no Wi-Fi and no cellular.
> Today view still renders from local cache with a "offline" indicator.

**Security scenario:**
> A user with a medical condition selects the flag during onboarding.
> The system must block submission unless explicit bypass consent is given
> and record `medical_bypass_consent = true`.

## 4. Trade-offs matrix

Common trade-offs between attributes. Pick your direction before committing.

| ↓ Improves | Often costs → | Availability | Performance | Security | Maintainability |
|---|---|---|---|---|---|
| **Availability** | | — | small | none | complexity ↑ |
| **Performance** | | may reduce | — | shortcuts risk | premature opt |
| **Security** | | latency ↑ | latency ↑ | — | complexity ↑ |
| **Maintainability** | | over time ↑ | some overhead | none | — |
| **Scalability** | | small | usually ↑ | complexity ↑ | complexity ↑ |
| **Cost (↓)** | | may drop | may drop | may drop | shortcuts |

**Reading:** Improving X (row) often costs Y (column). Zero cells mean "usually
compatible."

## 5. Tactics per attribute

### Availability
- Redundancy (active-active, active-standby)
- Retry with backoff
- Circuit breaker
- Graceful degradation (offline mode)
- Health checks + auto-restart

### Performance
- Caching (client, edge, server, DB)
- Pagination
- Async processing (queue)
- CDN for static assets
- Database indexes + query optimization
- Precomputation / materialized views

### Security
- Authentication (multi-factor, magic link)
- Authorization (RBAC, ABAC)
- Encryption (at rest, in transit)
- Input validation + output encoding
- Rate limiting
- Audit logging
- Secrets management

### Maintainability
- Modular design (bounded contexts)
- Clear layering
- Dependency injection
- Test coverage
- Documentation as code (OpenAPI, ADRs)
- Continuous refactoring

### Scalability
- Stateless services
- Horizontal scaling
- Database sharding / partitioning
- Read replicas
- Async messaging
- Auto-scaling groups

## 6. ATAM-lite process (for solo/small teams)

Full ATAM is heavy. For personal/small projects:

1. **List attributes** (all 10)
2. **Rank top 5** (business input)
3. **Write scenarios** (2–3 per top attribute) — measurable
4. **Evaluate architecture** against scenarios — does it meet? risk?
5. **Document trade-offs** — which decisions moved which attributes
6. **Record risks** — where architecture might not meet scenarios

Output: 1-page quality attribute analysis in SAD §9.

## 7. Anti-patterns

- **"All attributes matter equally"** — no priority = no design
- **Unmeasurable requirements** — "fast" and "secure" are wishes
- **Attribute without scenario** — impossible to verify
- **Trade-off denial** — pretending you can have everything
- **Late optimization** — designing for scale you don't have yet
- **Copy-paste attributes** — using another project's ranking without asking
  your own business
