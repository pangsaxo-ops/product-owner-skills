# Architecture Patterns — When to use, when not

Pick the pattern that matches your **quality attribute priorities**, **team
size**, and **operational maturity**. Not the pattern you saw in a blog post.

## 1. Layered / N-tier

**Structure:** Presentation → Business Logic → Data Access → Database

**When to use:**
- Default for CRUD-heavy apps
- Small team, single deploy unit
- Clear separation of concerns is enough

**When NOT to use:**
- Need to swap infrastructure often (use hexagonal)
- Async / event-driven workflows dominate
- Multiple bounded contexts (use modular monolith)

**Trade-offs:**
- ✅ Simple, well-understood, easy to onboard
- ❌ Tight coupling between layers over time
- ❌ Hard to test business logic in isolation (couples to DB)

---

## 2. Hexagonal / Ports & Adapters (Clean Architecture)

**Structure:** Domain core surrounded by ports (interfaces) with adapters
(concrete implementations) at the edge.

**When to use:**
- Business logic is complex + needs to outlive infrastructure
- Need to swap backends (SQL → NoSQL, local → cloud)
- Test business logic without DB / external services
- LLM provider might change (swap OpenAI ↔ Claude ↔ local)

**When NOT to use:**
- Simple CRUD with no business logic
- Solo/small project where boilerplate hurts

**Trade-offs:**
- ✅ Testable, portable, infrastructure-independent
- ✅ Long-term maintainability
- ❌ More boilerplate up-front (interfaces + adapters)
- ❌ Learning curve for team

**Good fit for:** LLM apps, offline-first mobile, apps with regulatory
change risk.

---

## 3. Event-Driven

**Structure:** Producers publish events → broker → consumers process
asynchronously.

**When to use:**
- Decoupled workflows (order placed → email + inventory + analytics)
- High throughput, don't block on downstream
- Multiple systems need to react to same event

**When NOT to use:**
- Synchronous request/response is the norm
- Small team without event tooling experience
- Debugging speed matters more than throughput

**Trade-offs:**
- ✅ Decoupling, scalability, resilience
- ❌ Debugging is hard (distributed traces required)
- ❌ Eventually consistent — not always desirable
- ❌ Message ordering + dedup complexity

---

## 4. Modular Monolith

**Structure:** Single deploy unit, but internal modules with clear boundaries
(like microservices without the ops overhead).

**When to use:**
- Solo / small team (< 10 devs)
- Want microservices discipline without microservices ops
- Anticipate splitting later, want modules ready

**When NOT to use:**
- Already have team boundaries requiring separate deploy cadence

**Trade-offs:**
- ✅ Best-of-both — clean boundaries + simple ops
- ✅ Easy to refactor + extract modules later
- ❌ Requires discipline to keep modules truly separate
- ❌ Single point of failure (one deploy = one blast radius)

**Best default for solo/small projects.**

---

## 5. Microservices

**Structure:** Independent services, each own deploy + DB + team.

**When to use:**
- Team of 20+ devs with clear domain boundaries
- Need independent deploy cadence per service
- Different services need different tech stacks
- Operational maturity: monitoring, tracing, CI/CD, on-call

**When NOT to use (usually):**
- Team < 10 devs
- Solo project (never)
- No operational maturity
- Domain boundaries unclear

**Trade-offs:**
- ✅ Independent scaling, deploy, tech choice
- ❌ Network calls everywhere (latency, failure modes)
- ❌ Distributed system complexity (consistency, tracing, versioning)
- ❌ Ops overhead often exceeds dev productivity gain

**Solo dev rule:** Never. Use modular monolith instead.

---

## 6. Serverless (FaaS)

**Structure:** Functions triggered by events, no server management.

**When to use:**
- Sporadic / bursty traffic
- Simple stateless operations
- Cost-sensitive (pay per invocation)
- Rapid prototyping

**When NOT to use:**
- Long-running processes (functions timeout)
- Stateful interactions
- Predictable steady load (VMs cheaper)
- Complex local dev experience

**Trade-offs:**
- ✅ Zero ops, auto-scale, pay-per-use
- ❌ Cold starts (latency)
- ❌ Vendor lock-in (mostly)
- ❌ Debugging + local dev harder
- ❌ 15-min execution limits

---

## 7. Client-Server (Mobile/PWA)

For mobile-first products, architecture typically = **client** + **thin API** +
**backend**.

**Common patterns:**

### 7.1 Fat client + thin backend
- Client owns business logic
- Backend = data sync + auth
- Good for: offline-first, low-latency UX
- Bad for: multi-client parity (web/iOS/Android drift)

### 7.2 Thin client + fat backend
- Client = presentation
- Backend = all logic
- Good for: consistent behavior across clients
- Bad for: offline, latency-sensitive interactions

### 7.3 Hybrid (recommended for most)
- Client owns UX logic (validation, formatting)
- Backend owns business rules (auth, calc, integration)
- Sync layer handles offline queue + conflict resolution

---

## 8. Decision Framework

Answer these to narrow to 1–2 candidates:

1. **Team size?** 1 → modular monolith or hexagonal. 10+ → consider event-driven.
   20+ → consider microservices.
2. **Domain complexity?** Low → layered. High → hexagonal or modular monolith.
3. **Async workflows?** Yes → event-driven or hybrid. No → sync patterns.
4. **Infrastructure change risk?** High → hexagonal. Low → layered.
5. **Offline requirement?** Yes → fat client or hybrid. No → thin client OK.
6. **Ops maturity?** Low → serverless or modular monolith. High → microservices possible.

## 9. Common combinations

| Project type | Recommended combination |
|---|---|
| Solo mobile app | Hybrid client + modular monolith backend |
| Small SaaS | Layered monolith → modular monolith |
| LLM-powered app | Hexagonal (swap LLM providers) + async workers |
| E-commerce | Modular monolith → carve out services as team grows |
| Data pipeline | Event-driven + serverless workers |
| Enterprise | Microservices (if team ≥ 20) or modular monolith |

## 10. Anti-patterns

- **Resume-driven architecture** — picking hot tech to look impressive
- **Big-team pattern in small team** — microservices for solo project
- **No-pattern** — everything in one file, no boundaries
- **Fashion cycles** — rewriting because a pattern is "old"
- **Over-abstraction** — layers of interfaces for a 100-user app
- **Under-abstraction** — SQL calls in view templates
