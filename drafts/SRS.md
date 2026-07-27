# System Requirements Specification (SRS) — Daily Fitness Companion (Phase 1)

**Owner:** Systems Analyst (SA) · **Status:** Draft v0.1 · **Last updated:** 2026-07-25
**Position in workflow:** PRD → REQ → WBS → EST → SCH → HND → **SRS** → SAD → DDD/API/DB/Sec/Deploy
**Source docs:** PRD, REQ (traceability), HND (system context)
**Consumed by:** SAD (architecture), Dev team

> **Note:** SRS นี้ extend REQ ด้วย system-level detail. Tech-specific decisions
> (platform, backend, framework) ที่รอ Q1/Q2 answer จะ mark เป็น **TBD** และ
> SA จะเติมหลัง ADR ใน SAD

---

## 1. Introduction

### 1.1 Purpose

เอกสารนี้ระบุ system-level requirements ที่ **Development team** จะใช้ build
Daily Fitness Companion Phase 1 — ครอบคลุมทั้ง functional, external interfaces,
data model, non-functional, และ constraints ในระดับที่ชัดเจนพอให้ implement ได้
ตรงตาม spec โดยไม่ต้องตีความเพิ่ม (solo developer)

### 1.2 Scope

**In-scope (Phase 1):**
- User-facing mobile app (Today view + edit + browse)
- Owner-facing admin (submission queue + plan input)
- Backend persistence + notifications
- 5-domain plan structure (workout / meal / supplement / cardio / recovery)

**Out-of-scope (Phase 2+):**
- LLM auto-generation (SA design ต้องเผื่อรองรับ)
- User authentication (Phase 1 = device-only)
- Payment / subscription (Phase 2)
- Advanced features per PRD Non-goals

### 1.3 Definitions

| Term | Meaning |
|---|---|
| **User (Nan)** | End user — fitness member ที่รับ plan + ใช้ Today view |
| **Owner** | Wizard-of-Oz coach + system admin (Phase 1: 1 person) |
| **Submission** | Onboarding form ที่ user ส่งเข้าระบบ |
| **Plan** | Weekly schedule ครบ 5 domain ที่ owner generate ให้ user |
| **Day** | ข้อมูลต่อวันใน plan (workout/meal/supp/cardio/recovery ของวันนั้น) |
| **Item** | หน่วยย่อยใน Day (เช่น 1 exercise, 1 meal, 1 supplement) |
| **PDPA** | Personal Data Protection Act B.E. 2562 (Thailand privacy law) |
| **NFR** | Non-Functional Requirement |
| **AC** | Acceptance Criterion |

### 1.4 References

| Doc | Purpose |
|---|---|
| PRD.md | Product vision + business goals |
| REQ.md | Requirements catalog (47 items, traced from PRD) |
| HND.md | Handover package + System Context §6 |
| Stories.md | User stories with Given/When/Then AC |
| WBS.md / EST.md / SCH.md | Implementation planning |

---

## 2. Overall Description

### 2.1 Product Perspective

**Type:** Greenfield mobile-first application, standalone (no legacy system)

**Deployment:** Client (mobile app) + Backend API + Managed backend service

**Approach for Phase 1:** Wizard-of-Oz — Owner uses external ChatGPT UI to
generate plans; input via admin queue. No LLM API integration ใน Phase 1

### 2.2 Product Functions (Extends REQ §2)

**User-facing:**
1. Onboarding submission (12-Q form + save/resume + medical block)
2. Today view (5-domain glanceable view + browse days + offline)
3. Item editing (workout/meal/supp modal edits)
4. Duplicate week (stretch)

**Owner-facing:**
1. Submission queue (list + sort + filter)
2. Plan input (5-domain structured input + auto-save)
3. Mark plan ready + notify user

**Cross-cutting:**
1. Disclaimer at key moments
2. Analytics event logging (non-PII)
3. Email notifications (owner + user)

### 2.3 User Classes and Characteristics (Extends HND §6.2)

| Class | ID | Access level | Frequency | Technical background |
|---|---|---|---|---|
| **Fitness User** | U1 | Standard (own data only) | Daily (2–4 opens/day) | Tech-literate, smartphone daily |
| **Owner / Admin** | U2 | Elevated (all data + queue) | Weekly (per plan generation) | Owner = SA/dev = high tech literacy |
| **Anonymous Visitor** | U3 | Read landing/onboarding only | One-time | Varies |

**Note:** U1 access to own data enforced by device-only storage (Phase 1) →
Phase 2 auth + row-level security

### 2.4 Operating Environment (Extends HND §6.3)

**Client environment:**
- **Target platform:** TBD — pending Q1 decision (iOS native / PWA / RN / Flutter)
- **Mobile OS minimum:** iOS 15+ / Android 10+
- **Screen sizes:** responsive 320px – 1920px
- **Network:** offline-first for Today view; online required for submit + owner input
- **Peak load:** morning 7–9am, before workout 5–7pm, before meals

**Server environment:**
- **Backend platform:** TBD — pending Q2 decision (Firebase / Supabase / custom)
- **Region:** Southeast Asia (Singapore recommended)
- **Availability target:** ≥ 99% uptime (REQ-N-010)

**Development environment:**
- OS: macOS (owner's dev machine)
- CI/CD: platform-managed (GitHub Actions or hosting built-in)

### 2.5 Constraints (Consolidated from HND §5)

**Technical:**
- Solo developer — no coordination overhead but no parallelization
- Must be buildable + maintainable by 1 person
- Offline-first for Today view (REQ-N-002)
- Health data local storage priority (REQ-N-004)
- ≤ 500ms Today view render (REQ-N-001)

**Business:**
- Personal project — budget = free tier where possible
- Timeline: TBD (owner-managed scheduling)

**Regulatory:**
- PDPA compliance (REQ-R-005)
- Medical disclaimer (REQ-R-001)
- Medical condition block/bypass (REQ-R-002)
- WCAG 2.1 AA basics (REQ-N-005)
- Thai + English locale (REQ-N-006)

### 2.6 Assumptions and Dependencies

| # | Assumption | Impact if false |
|---|---|---|
| A1 | Tech stack familiar to owner | Effort estimate +25% |
| A2 | Backend-as-a-service ตอบโจทย์ | Custom backend = large effort |
| A3 | Email notification เพียงพอ (no push) | UX degradation |
| A4 | F&F cohort เข้าใจ Wizard-of-Oz | Positioning gap |
| A5 | Phase 1 ไม่ต้อง user account | Migration pain ตอน Phase 2 |
| A6 | Owner has ChatGPT access | Alternative LLM required |

---

## 3. External Interface Requirements

### 3.1 User Interfaces

**Design system:** TBD — SA + PO to decide (custom / native OS defaults / library)

**Key screens (extends Stories.md):**

| # | Screen | User class | Reference |
|---|---|---|---|
| 3.1.1 | Onboarding intro + disclaimer | U1, U3 | US-01, US-16 |
| 3.1.2 | 12-question form (paginated) | U1 | US-01, US-02 |
| 3.1.3 | Medical block screen | U1 | US-03 |
| 3.1.4 | Pending "waiting for owner" state | U1 | US-11 |
| 3.1.5 | Today view (main app screen) | U1 | US-08, US-09, US-10 |
| 3.1.6 | Week navigator + browse | U1 | US-12 |
| 3.1.7 | Edit item modal (workout/meal/supp/cardio) | U1 | US-13, US-14 |
| 3.1.8 | Empty + rest day states | U1 | US-11 |
| 3.1.9 | About / Terms / Privacy | U1 | US-16 |
| 3.1.10 | Admin — submission queue | U2 | US-04 |
| 3.1.11 | Admin — plan input (5 domain) | U2 | US-05, US-06 |
| 3.1.12 | Admin — mark ready action | U2 | US-07 |

### 3.2 Hardware Interfaces

- **Touch screen:** required (mobile-first)
- **Network:** Wi-Fi / cellular
- **Storage:** local device storage for offline cache (~10 MB typical)
- **No hardware sensor integration** (no wearables in Phase 1 — see PRD non-goals)

### 3.3 Software Interfaces (Extends HND §6.1)

| # | External System | Direction | Protocol | Auth | Failure handling | Phase |
|---|---|---|---|---|---|---|
| **E1** | **Owner email inbox** | Outbound | SMTP / provider API (TBD: SendGrid / Resend / Postmark) | API key | Retry 3× with exponential backoff; alert owner via secondary channel if fail | 1 |
| **E2** | **User email inbox** | Outbound | SMTP / provider API | API key | Retry 3×; log failure; user can request resend via admin | 1 |
| **E3** | **ChatGPT (owner browser)** | Manual UI | Web app | Owner's account | Owner action, no system dep | 1 |
| **E4** | **LLM API** | Outbound (Phase 2 only) | HTTPS REST/streaming | API key + rate limit | Retry with backoff; fallback to cached prompt result if available | 2 |
| **E5** | **Payment gateway** (Phase 2) | Outbound + webhook | HTTPS + HMAC-signed webhook | API key + webhook secret | Provider handles idempotency | 2 |
| **E6** | **Analytics platform** (Phase 1+2) | Outbound events | HTTPS REST | API key | Fire-and-forget with local buffer; drop on repeated fail | 1+2 |
| **E7** | **Backend service** (Phase 1+2) | Bi-directional | Provider SDK / HTTPS REST | (see auth spec Phase 2) | Retry idempotent operations; user-visible error otherwise | 1+2 |
| **E8** | **Push notification** (optional) | Outbound | FCM / APNs | Provider credentials | Fire-and-forget; log undeliverable | 1+ |

**Detailed contracts:** SA จะเขียนใน API Spec doc (ต่อไป)

### 3.4 Communications Interfaces

- **All external traffic HTTPS** (TLS 1.2+)
- **HSTS** for public web (if PWA chosen)
- **Certificate management** ผ่าน hosting provider (Let's Encrypt / managed)
- **API auth (Phase 2):** Bearer JWT ใน `Authorization` header
- **Webhook auth:** HMAC-SHA256 body signature

---

## 4. System Features

Features grouped by workflow. Each block extends REQ-F with system-level detail.

### 4.1 Onboarding & Submission (WP 1.2)

**Traces to:** REQ-F-001, REQ-F-002, REQ-F-003, REQ-B-007
**Priority:** P0

#### 4.1.1 Description
ระบบต้องรับ user profile ผ่าน 12-question form, validate, persist,
notify owner, และแสดง "pending" state จนกว่า owner จะ mark plan ready

#### 4.1.2 Preconditions
- User เปิดแอปครั้งแรก
- Network available (สำหรับ submit — form filling OK offline)

#### 4.1.3 Main Flow
1. แสดง welcome screen + disclaimer (REQ-R-001) — user ยอมรับ
2. Present 12-question form paginated (1 Q per screen)
3. On each question: validate input inline; on invalid, block "next" button
4. On step change: save partial state to local storage (REQ-F-002)
5. On question 12 → present review + submit button
6. On submit: POST to backend endpoint
7. Backend persists submission + triggers email to owner (E1)
8. Show "pending — รอ owner ~24 ชม." screen (until status changes)

#### 4.1.4 Alternate Flows

**AF1: Medical condition selected (REQ-F-003)**
- User selects Yes on any medical Q (heart/diabetes/injury/pregnancy)
- System shows block screen + guidance "ปรึกษาแพทย์"
- User can: (a) Cancel submission, or (b) Explicit bypass with checkbox +
  confirmation modal
- If bypass: submit proceeds with `medical_bypass_consent = true`
- Owner queue shows flag

**AF2: Network fail on submit**
- Retry 3× with exponential backoff
- On persistent fail: show error with "ลองใหม่" button; form state preserved
- No submission recorded until successful ACK from backend

**AF3: Resume partial (REQ-F-002)**
- User closes app mid-form
- Reopen within 30 days: form restores at last completed step
- Reopen after 30 days: partial state discarded, restart from step 1

#### 4.1.5 Data Touched
- **Write:** `submissions` (new record with status='pending')
- **Read/write:** local storage `onboarding_partial` (temp until 30d)
- **Trigger:** email notification (E1) to owner

#### 4.1.6 Verification
- Integration tests for form validation
- E2E test for full submit → owner sees in queue
- Manual test for medical block + bypass
- Timing test for partial save (should be instant, ≤ 100ms)

---

### 4.2 Owner Submission Queue (WP 1.2)

**Traces to:** REQ-F-004
**Priority:** P0

#### 4.2.1 Description
Owner ต้องเข้าถึง admin view เพื่อดู submissions ทั้งหมด, sort ตาม pending
oldest first, click เข้าไปดูรายละเอียดของแต่ละคน

#### 4.2.2 Preconditions
- Owner accesses admin URL (Phase 1: password-protected via .env secret)
- Backend accessible

#### 4.2.3 Main Flow
1. Owner navigates to `/admin/queue`
2. Password prompt (single value from env; Phase 2 → proper auth)
3. On success: fetch submissions list from backend
4. Render list: name, email, submitted_at, status, medical_flag
5. Sort: `pending` first, oldest submitted_at first
6. Owner clicks row → detail view (§4.3 Plan Input)

#### 4.2.4 Alternate Flows

**AF1: Empty queue**
- Show "ยังไม่มี user ใหม่" empty state + link to test-generate

**AF2: Auth fail**
- Rate-limit password attempts (5 fails / hour)
- Log failed attempts

#### 4.2.5 Verification
- Unit test for sort order
- Integration test for auth
- Manual test for empty state

---

### 4.3 Owner Plan Input — 5 Domain (WP 1.3)

**Traces to:** REQ-F-005, REQ-F-006, REQ-F-007
**Priority:** P0

#### 4.3.1 Description
Owner กรอก plan ครบ 5 domain (workout / meal / supplement / cardio / recovery)
สำหรับ submission ที่เลือก, auto-save ระหว่าง input, จากนั้นกด "Mark ready"
เพื่อ notify user

#### 4.3.2 Preconditions
- Owner ผ่าน auth (§4.2)
- Selected submission มี status='pending'

#### 4.3.3 Main Flow
1. Show plan input UI แบ่งเป็น 5 tabs หรือ sections
2. **Workout tab:** day picker Mon–Sun + rest toggle + exercises (name/sets/reps/rest/note) + reorder
3. **Meal tab:** per day → meals (mealtime/food items/portion/optional macros)
4. **Supplement tab:** items (name/dose/timing) applied to relevant days
5. **Cardio tab:** type/duration/frequency
6. **Recovery tab:** sleep target + rest day count + mobility notes
7. On every field change: debounced auto-save (500ms)
8. Once complete: owner clicks "Mark ready"
9. System validates workout section not empty
10. Status → `plan_ready`, timestamp saved
11. Trigger email to user (E2)
12. User's next app-open routes to Today view

#### 4.3.4 Alternate Flows

**AF1: Auto-save fail (network)**
- Show inline warning "ยังไม่ได้ save — retry..."
- Buffer changes locally, retry on reconnect
- Do NOT lose owner input

**AF2: Mark ready with missing workout**
- Block action, show error "ยังต้องกรอก workout อย่างน้อย 1 วัน"

**AF3: Owner reopens partially-filled plan**
- Load latest saved state
- All previously entered data intact

#### 4.3.5 Data Touched
- **Write:** `plans`, `plan_days`, `plan_items` (per domain)
- **Update:** `submissions.status`
- **Trigger:** email E2

#### 4.3.6 Verification
- Integration tests for auto-save (debounce + retry)
- E2E for full plan input → user receives email
- Manual for reorder + validation

---

### 4.4 Today View (WP 1.4 + 1.5)

**Traces to:** REQ-F-008, REQ-F-009, REQ-F-010, REQ-F-011, REQ-B-008
**Priority:** P0 (F-008, F-009) / P1 (F-010, F-011)
**⚠️ Risk R2:** biggest task, UX polish blow-up risk

#### 4.4.1 Description
User เปิดแอปเห็น plan ของวันนี้ทันที (< 5 วิ perceived) ครบ 5 domain
เรียงตามเวลา, glanceable, offline-capable

#### 4.4.2 Preconditions
- User มี plan status='plan_ready' หรือ 'delivered'
- Local cache populated (or online fetch OK)

#### 4.4.3 Main Flow
1. On app-open: display skeleton loader (< 100ms)
2. Read today's day from local cache (offline-first)
3. Determine day type: workout / rest / meal-only / no plan
4. Render sections in time-of-day order:
   - Morning meal (if any)
   - Pre-workout supplement (if any)
   - Workout section (if workout day)
   - Post-workout meal + supplement
   - Additional meals + supplements
   - Cardio (if any)
   - Recovery / sleep target (bottom)
5. Fire analytics event `today_view_opened` with `time_of_day`
6. Background sync with backend (if online) to refresh cache

#### 4.4.4 Alternate Flows

**AF1: Rest day**
- Show "Rest day — พักผ่อน" prominent
- Meals still displayed if defined

**AF2: Offline**
- Serve from cache
- Show subtle offline indicator (top badge)
- No error UX

**AF3: Plan not ready (pending)**
- Show pending state (§4.1.3 step 8) with email support link

**AF4: No plan (never onboarded)**
- Show CTA "Start onboarding"

**AF5: Cache miss + offline**
- Show generic "no internet, tap to retry" screen
- Should be extremely rare — cache populated on first successful load

#### 4.4.5 Data Touched
- **Read:** local cache (or backend if cache miss)
- **Write:** analytics events (async)
- **Update:** local cache from background sync

#### 4.4.6 Verification
- **REQ-N-001:** performance test — render ≤ 500ms p95 on mid-tier phone
- **REQ-N-002:** airplane mode test — full functionality
- E2E for all state variations (workout / rest / pending / no plan)
- Manual UX review — "glanceable" criterion

---

### 4.5 Browse Days + Edit Items (WP 1.5)

**Traces to:** REQ-F-012, REQ-F-013, REQ-F-014, REQ-F-015
**Priority:** P0 (US-12, US-13) / P1 (US-14) / P2 (US-15)

#### 4.5.1 Description
User navigate ระหว่างวันของสัปดาห์ + แก้ / เพิ่ม / ลบ item ในแต่ละวัน

#### 4.5.2 Main Flow

**Browse (REQ-F-012):**
1. Week navigator แสดง Mon–Sun (7 pills or swipe)
2. Tap/swipe → เปลี่ยน selected day
3. Fetch that day from cache
4. Persist selection (last viewed day)

**Edit item (REQ-F-013):**
1. Long-press or tap item → context menu (Edit / Delete)
2. Edit → modal with editable fields (varies by item type)
3. Save → optimistic update + backend sync
4. Cancel → discard (with unsaved warning if dirty)

**Add item (REQ-F-014):**
1. In section footer: "+ เพิ่ม item"
2. Same modal as Edit but empty
3. Save → append to section

**Duplicate week (REQ-F-015, P2):**
1. Menu action: "Duplicate this week"
2. Confirm modal ("จะเขียนทับ plan สัปดาห์หน้า?" if applicable)
3. Copy operation (backend transaction)

#### 4.5.3 Data Touched
- **Read:** cache (day-specific)
- **Write:** cache + backend on save (optimistic)

#### 4.5.4 Verification
- E2E: edit workout, verify persists across reload
- Unit tests for cache mutation logic
- Manual: unsaved-changes warning

---

### 4.6 Safety & Disclaimer (Cross-cutting)

**Traces to:** REQ-R-001, REQ-R-002, REQ-F-016
**Priority:** P0 (safety-critical)

#### 4.6.1 Description
Disclaimer "ไม่ใช่คำแนะนำทางการแพทย์" ต้องปรากฏที่จุดสำคัญ + medical
condition ต้องถูก handle เข้ม

#### 4.6.2 Points of enforcement
1. **Onboarding intro screen** — full disclaimer + "ยอมรับและเริ่ม" button
2. **First plan review** — banner disclaimer (dismissible, saved state)
3. **About page** — link to full Terms + Privacy + Disclaimer
4. **Medical condition question** — if flagged → block screen (§4.1.4 AF1)

#### 4.6.3 Copy source
Reference to `constants/disclaimer.ts` (single source of truth for Thai + English)

#### 4.6.4 Verification
- Manual verification of copy at each point
- E2E: onboarding cannot proceed without accepting disclaimer
- Legal review before public launch (Phase 2)

---

## 5. Non-Functional Requirements (Extends REQ §3)

### 5.1 Performance

| # | Requirement | Target | Measurement method | Trace |
|---|---|---|---|---|
| N-1.1 | Today view render | p95 ≤ 500ms (cached, mid-tier phone) | Automated perf test (Lighthouse หรือ equivalent) | REQ-N-001 |
| N-1.2 | Onboarding form navigation | ≤ 200ms per step | Manual + integration timing | REQ-N-003 |
| N-1.3 | Local storage read/write | ≤ 50ms | Unit test | Implicit |
| N-1.4 | Backend API response (typical) | p95 ≤ 500ms | APM (Application Performance Monitoring) | Implicit |
| N-1.5 | Cache warm-up (post-login) | ≤ 2s | Manual timing | Implicit |

### 5.2 Availability

| # | Requirement | Target | Measurement | Trace |
|---|---|---|---|---|
| N-2.1 | Backend uptime (Phase 1) | ≥ 99% monthly | Uptime monitor | REQ-N-010 |
| N-2.2 | Today view offline capability | 100% functionality (cached) | Airplane mode test | REQ-N-002 |
| N-2.3 | Recovery time (backend down) | Full recovery ≤ 30 min | Incident response | Implicit |

### 5.3 Scalability (Phase 1 targets — SA design for Phase 2)

| # | Metric | Phase 1 | Phase 2 target | Trace |
|---|---|---|---|---|
| N-3.1 | Concurrent users | ≤ 10 | 10 – 50 peak | HND §6.4 |
| N-3.2 | Total registered users | ≤ 10 | 100 – 1,000 | HND §6.4 |
| N-3.3 | Requests / user / day | ≤ 10 | 5 – 10 | HND §6.4 |
| N-3.4 | DB size | < 10 MB | < 10 GB (year 1) | HND §6.4 |

### 5.4 Security

Reference: **Security Architecture Doc** (ต่อไป). Key SRS-level requirements:

| # | Requirement | Trace |
|---|---|---|
| N-4.1 | All external traffic HTTPS (TLS 1.2+) | Implicit / industry standard |
| N-4.2 | Health data local storage priority; backend encrypted at rest | REQ-N-004 |
| N-4.3 | Consent flow แจ้งชัดเรื่อง owner viewing (Phase 1) | REQ-N-007 |
| N-4.4 | Analytics events ไม่ track PII (email, name, health data) | REQ-N-008 |
| N-4.5 | Admin auth via .env secret Phase 1; proper auth Phase 2 | Implicit |

### 5.5 Maintainability

| # | Requirement | Verification |
|---|---|---|
| N-5.1 | Code test coverage ≥ 70% for business logic | Coverage report |
| N-5.2 | API documented per API Spec doc | Doc review |
| N-5.3 | ADRs (Architecture Decision Records) for major decisions | Present in SAD |
| N-5.4 | Migrations idempotent + reversible | Migration review |

### 5.6 Usability

| # | Requirement | Target | Trace |
|---|---|---|---|
| N-6.1 | WCAG 2.1 AA basics (contrast, touch ≥ 44px, keyboard, screen reader) | Automated (axe) + manual | REQ-N-005 |
| N-6.2 | Locales: Thai + English | 2 locales supported | REQ-N-006 |
| N-6.3 | Time to answer "วันนี้ทำอะไร" | ≤ 5 วิ (open → info visible) | REQ-B-002 |

---

## 6. Data Requirements

### 6.1 Logical Data Model (details ใน DDD)

**Core entities:**

```
User ─┬─→ Submission ─→ Plan ─→ Day ─→ Item
      └─→ Preferences (Phase 2)

Item polymorphic per domain:
- WorkoutItem (exercise + sets + reps + rest + note)
- MealItem (mealtime + food + portion + macros)
- SupplementItem (name + dose + timing)
- CardioItem (type + duration + frequency)
- RecoveryItem (sleep target + mobility)
```

### 6.2 Data Volume (Extends HND §6.4)

See §5.3 Scalability targets.

### 6.3 Data Retention & Deletion

| Entity | Active retention | Deletion trigger | Hard-delete SLA |
|---|---|---|---|
| User + submissions + plans | Indefinite (Phase 2: until sub cancelled + 30d) | User request or account close | Within 30 days (PDPA) |
| Local storage cache | 30 days for onboarding partial; indefinite for plan cache | Explicit clear or 30d unused | Immediate on trigger |
| Analytics events | Aggregate: 12 months; raw: 30 days | Retention window expiry | Automatic (provider default) |
| Email logs | 90 days | Retention window | Automatic |

**Compliance:** REQ-R-005 (PDPA), REQ-R-004 (T&C before public)

### 6.4 Data Volume Growth Assumptions

- Per user: ~1 MB storage growth
- Analytics events: ~10–30 / user / day (aggregate stored)
- Backup: daily automated (backend provider default)

---

## 7. Other Requirements

### 7.1 Regulatory

- **PDPA compliance** (Thailand) — REQ-R-005
- **Medical disclaimer** at all UI touchpoints — REQ-R-001
- **PCI DSS** (Phase 2, via payment gateway) — REQ-R-006

### 7.2 Localization / i18n

- Primary locale: Thai (`th-TH`)
- Secondary: English (`en-US`)
- Copy externalized in `i18n/{locale}.json`
- Number/date formatting per locale

### 7.3 Accessibility

- WCAG 2.1 AA basics per REQ-N-005
- Screen reader labels on all interactive elements
- Focus management for modals + forms
- No color-only information encoding (use icon + text)

### 7.4 Analytics Events (Phase 1 event catalog)

| Event name | Trigger | Properties (non-PII) |
|---|---|---|
| `app_open` | Any app open | `time_of_day`, `day_of_week` |
| `onboarding_started` | User starts form | (none) |
| `onboarding_step_completed` | Each Q done | `step_number` |
| `onboarding_submitted` | Form submit success | `q_count`, `medical_flag`, `bypass` |
| `plan_delivered` | Owner marks ready | (server-side) |
| `today_view_opened` | Today view load | `time_of_day`, `day_type` |
| `item_edited` | User edits item | `item_type` |
| `item_added` | User adds item | `item_type` |
| `item_removed` | User removes item | `item_type` |
| `disclaimer_accepted` | User accepts | (none) |
| `rest_timer_used` | Should tier | (none, Phase 1.1+) |

---

## 8. Traceability Matrix

**REQ → SRS Section → Test Type**

| REQ ID | Description | SRS Section | Test Type |
|---|---|---|---|
| REQ-B-001 | Discovery pain solved | §1.2 scope | User interview |
| REQ-B-002 | Reminder pain solved | §5.6 usability (N-6.3) | Manual timing |
| REQ-B-003 | Wizard-of-Oz validation | §2.1 approach | Retro post-Phase 1 |
| REQ-B-007 | Onboarding completion ≥ 70% | §4.1 | Funnel analytics |
| REQ-B-008 | Adherence ≥ 80% | §4.4 | Event analytics |
| REQ-F-001 | Onboarding form | §4.1 | Integration + E2E |
| REQ-F-002 | Save/resume | §4.1.4 AF3 | Integration |
| REQ-F-003 | Medical block | §4.1.4 AF1, §4.6 | Manual + E2E |
| REQ-F-004 | Owner queue | §4.2 | Integration + Manual |
| REQ-F-005 | Owner workout input | §4.3 | E2E |
| REQ-F-006 | Owner nutrition input | §4.3 | E2E |
| REQ-F-007 | Mark ready + notify | §4.3 | E2E |
| REQ-F-008 | Today view workout | §4.4 | E2E + performance |
| REQ-F-009 | Today view meals | §4.4 | E2E |
| REQ-F-010 | Supp/cardio/recovery view | §4.4 | E2E |
| REQ-F-011 | Empty/rest states | §4.4 AF | E2E |
| REQ-F-012 | Browse days | §4.5 | E2E |
| REQ-F-013 | Edit item | §4.5 | E2E |
| REQ-F-014 | Add/remove | §4.5 | E2E |
| REQ-F-015 | Duplicate week | §4.5 | Manual |
| REQ-F-016 | Disclaimer | §4.6 | Manual + E2E |
| REQ-N-001 | Today view ≤ 500ms | §5.1 N-1.1 | Perf test |
| REQ-N-002 | Offline-first | §5.2 N-2.2, §4.4 AF2 | Airplane mode |
| REQ-N-003 | Onboarding nav ≤ 200ms | §5.1 N-1.2 | Timing |
| REQ-N-004 | Health data local | §5.4 N-4.2, §6.3 | Code review |
| REQ-N-005 | WCAG 2.1 AA | §5.6 N-6.1, §7.3 | Axe + manual |
| REQ-N-006 | Thai + English | §5.6 N-6.2, §7.2 | Locale switch |
| REQ-N-007 | Owner viewing consent | §5.4 N-4.3 | Consent screen present |
| REQ-N-008 | No-PII analytics | §5.4 N-4.4, §7.4 | Analytics review |
| REQ-N-010 | Backend ≥ 99% uptime | §5.2 N-2.1 | Uptime monitor |
| REQ-R-001 | Medical disclaimer | §4.6, §7.1 | Manual UI review |
| REQ-R-002 | Medical block/bypass | §4.1.4 AF1, §4.6 | E2E + manual |
| REQ-R-005 | PDPA compliance | §6.3, §7.1 | Legal review |

**Phase 2 REQs (REQ-F-017 to 023, REQ-B-004 to 006, REQ-R-003 to 006):**
Not implemented in Phase 1; SA must design for extensibility.

---

## 9. Open Questions (Blocking for SAD)

| # | Question | Priority | Blocks | Owner to answer |
|---|---|---|---|---|
| **Q1** | **Platform** — iOS native / PWA / React Native / Flutter | P0 (blocking) | All UI code + deploy | SA + Owner |
| **Q2** | **Backend** — Firebase / Supabase / custom | P0 (blocking) | Persistence + Phase 2 auth | SA + Owner |
| **Q3** | **Data model finalization** — attribute-level for User/Submission/Plan/Day/Item | P0 (blocking) | Backend + DDD | SA |
| Q4 | Notification method — email only / add push | P1 | E8 interface | SA + Owner |
| Q5 | Analytics platform | P1 | E6 interface | SA |
| Q6 | Deployment infra + region | P1 | Deploy Arch | SA |
| Q7 | Testing framework choice | P1 | Test Strategy | SA |
| Q8 | Feature flag mechanism | P2 | Phase 2 rollout | SA |
| Q9 | LLM API choice (Phase 2) | P3 | Phase 2 arch | SA |
| Q10 | Payment gateway (Phase 2) | P3 | Phase 2 arch | SA + Owner |
| Q11 | Legal review requirement | P3 | Phase 2 launch | Owner + legal |

---

## 10. Decision Log

| Date | Decision | Rationale | Made by |
|---|---|---|---|
| 2026-07-25 | SRS v0.1 draft created from REQ + HND | Initial SA phase output | SA (via /systems-analyst) |
| 2026-07-25 | Data model designed as polymorphic Item per domain | Extensibility for Phase 2 + flex per user | SA (draft) |
| 2026-07-25 | Analytics event catalog specified (§7.4) | Ensures no PII leaks + consistent naming | SA (draft) |
| 2026-07-25 | Q1/Q2 marked as blocking; SAD ต้องรอ | Cannot commit tech stack without decision | SA |

---

## 11. Change Control

SRS changes require:
1. Documented change reason (new REQ / discovered constraint / SA analysis)
2. Impact on downstream: SAD, DDD, API, DB, code
3. Review by PO/PM
4. Version bump + regenerate PDF/DOCX
5. Update traceability matrix if scope changed

---

## 12. Next Steps for SA Phase

1. **Answer Q1/Q2** (with owner) → ADR entries
2. **Write SAD** using `assets/sad-template.md` — pick pattern, run quality attribute analysis
3. **Write DDD** — flesh out §6.1 logical model → attributes + business rules
4. **Write API Spec** — endpoints from §4 features + §3.3 interfaces
5. **Write DB Schema** — persistence model from DDD
6. **Write Security Architecture** — auth (Phase 1 admin, Phase 2 user), encryption, PDPA compliance flow
7. **Write Deployment Architecture** — based on Q2 backend decision
8. **Write Test Strategy** — coverage plan per §5, §7.4 events
