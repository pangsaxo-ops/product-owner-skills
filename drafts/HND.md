# Handover Document (HND) — Product to Systems Analyst

**Purpose:** เอกสารบริดจ์การส่งมอบจาก **Product Owner / Project Manager** ไป
**Systems Analyst (SA)** — สรุปสิ่งที่ handoff, open questions, constraints,
และ SA deliverables ที่คาดหวัง

**Position in workflow:** PRD → REQ → WBS → EST → SCH → **HND** → (SA phase: SRS → SAD → DDD)
**Source docs:** PRD, REQ, WBS, EST, SCH, Stories
**Consumed by:** Systems Analyst (SA) และทีมออกแบบระบบ

---

## 1. Project Snapshot

| Item | Value |
|---|---|
| Project name | Daily Fitness Companion |
| Phase | Phase 1 — Wizard-of-Oz MVP |
| Approach | Owner-in-loop plan generation (manual ChatGPT) |
| Target user cohort | Friends & Family (จำนวน = owner กำหนด) |
| Business model | Freemium — trial 30d → subscription (Phase 2) |
| Doc set version | v0.7 DRAFT (ดู doc control / `_revisions.json`) |
| Handoff date | ___________ (fill on transfer) |
| SA phase status | เริ่มแล้ว — SRS v0.1 draft ออกแล้ว (ดู SRS.md); SAD ถัดไป |

---

## 2. Handoff Scope

### 2.1 สิ่งที่ Handoff

**Documents (6 formal + 1 handover):**
- PRD.md — Product specification
- REQ.md — Requirements catalog + traceability
- WBS.md — Work breakdown structure
- EST.md — Effort estimates
- SCH.md — Schedule framework
- Stories.md — User stories with AC
- **HND.md** (this doc) — Handover package

**Access:** Read + comment access ให้ SA · Write access เฉพาะ REQ traceability column

**Ownership after handoff:**
- Product docs (PRD, REQ) — owned by PO, SA อ่านและอ้างอิง
- WBS/EST/SCH — owned jointly, SA อาจเพิ่ม detail
- Stories — owned by PO/SA ร่วมกัน (SA อาจ split เพิ่ม)
- SA deliverables (§4) — SA รับผิดชอบเต็ม

### 2.2 สิ่งที่ NOT handoff

- Phase 2 requirements (REQ-F-017 ถึง 023) — parked จนกว่า Phase 1 validate เสร็จ
- Payment integration (Q8–Q12) — Phase 2 concern
- Full LLM integration architecture — Phase 2 (แต่ SA ควรรับรู้ direction)
- Personal working files (drafts iteration, PRD-workout-tracker.md history)

---

## 3. Open Technical Questions ที่ SA ต้องช่วยตอบ / ยืนยัน

### 3.1 Blocking (ต้องตอบก่อน kickoff SA phase)

| # | Question | Impact if unanswered | SA recommendation expected |
|---|---|---|---|
| Q1 | **Platform** — iOS native (Swift) / PWA / React Native / Flutter | Blocks all UI + deploy tasks | ต้องแนะนำพร้อม rationale (dev speed, offline, cost, future Phase 2 fit) |
| Q2 | **Backend** — Firebase / Supabase / Custom (Node+Postgres) / other | Blocks persistence + auth (Phase 2) | ต้องแนะนำ พิจารณา Phase 2 auth/payment + cost |
| Q3 | **Data model** — ERD ต้อง finalize (User → Submission → Plan → Day → Item) | Blocks all backend work | SA design ERD + normalization decisions |

### 3.2 Non-blocking (ตอบระหว่าง SA phase ได้)

| # | Question | Owner to Answer |
|---|---|---|
| Q4 | Notification — push / email / in-app only | SA + PO |
| Q5 | Analytics platform — Firebase / Amplitude / Mixpanel / self-hosted | SA |
| Q6 | Deployment infra — free tier vs. paid, region | SA |
| Q7 | Testing framework — unit / integration / e2e coverage strategy | SA |
| Q8 | Feature flag mechanism (สำหรับ Phase 2 gradual rollout) | SA |

### 3.3 Deferred (Phase 2 concerns)

| # | Question | When to Answer |
|---|---|---|
| Q9 | LLM API choice — OpenAI GPT-4o / Claude Sonnet / on-prem | Phase 2 planning |
| Q10 | Payment gateway — Omise / Stripe / IAP | Phase 2 planning |
| Q11 | T&C + Privacy Policy — ต้องปรึกษาที่ปรึกษาไหม | Before Phase 2 public launch |

---

## 4. Expected SA Deliverables

SA จะต้อง produce เอกสารต่อไปนี้ ในลำดับ:

| Priority | Doc | ย่อจาก | Purpose | Est. effort |
|---|---|---|---|---|
| 1 | **SRS** | System Requirements Specification | Requirements ระดับระบบ (extend จาก REQ) | 2–4 วัน |
| 2 | **SAD** | Solution/System Architecture Document | Component diagram, layer, tech stack decision | 3–5 วัน |
| 3 | **DDD** | Detailed Design Document | Data model, class/module design, sequence diagrams | 5–10 วัน |
| 4 | **API Spec** | Interface Contracts | REST/GraphQL endpoints, request/response schema | 3–5 วัน |
| 5 | **DB Schema** | Data Model | ERD + DDL migration scripts | 2–3 วัน |
| 6 | **Sec Arch** | Security Architecture | Auth, authz, encryption, PDPA compliance approach | 2–3 วัน |
| 7 | **Deploy Arch** | Deployment Architecture | Infrastructure, CI/CD, environments | 1–2 วัน |
| 8 | **Test Strategy** | Test approach | Unit / integration / e2e coverage plan | 1–2 วัน |

**Total SA phase: ~19–34 วัน** (estimate; SA to refine)

### 4.1 Success criteria for SA deliverables

- ทุก REQ (Phase 1) ต้อง trace ไปยัง SA design element ได้
- Data model รองรับ Phase 2 requirements ได้ (extensibility)
- Security architecture ครอบคลุม medical disclaimer + PDPA
- Offline-first architecture (REQ-N-002) ได้รับการออกแบบชัด
- Sign-off จาก PO/PM หลัง SRS + SAD

---

## 5. Constraints (Consolidated)

### 5.1 Technical constraints

- **Solo developer** — architecture ต้อง buildable + maintainable โดยคนเดียว
- **Offline-first** for Today view (REQ-N-002)
- **Local storage priority** for health data (REQ-N-004, PDPA)
- **≤ 500ms Today view render** (REQ-N-001)
- **LLM latency ≤ 30s** สำหรับ Phase 2 (REQ-N-009)
- **Owner manual step (Phase 1)** — admin queue UI + owner input flow ต้องรองรับ

### 5.2 Business constraints

- **Budget:** personal project — ควรอยู่ใน free tier ของ cloud services เท่าที่ทำได้
- **Timeline:** TBD (owner จัดการ) — SA อาจต้องประเมิน architecture effort เพื่อ inform owner
- **Team:** Solo — architecture ต้องไม่ over-engineered

### 5.3 Regulatory constraints

- **Medical disclaimer** required (REQ-R-001) — UI + T&C ต้องรองรับ
- **Medical condition block/bypass** (REQ-R-002) — flow ต้องออกแบบชัด
- **PDPA compliance** (REQ-R-005) — data handling, retention, deletion
- **PCI DSS** (REQ-R-006, Phase 2) — via payment gateway compliance
- **LLM output safety** (REQ-R-003, Phase 2) — prompt engineering + blocked keywords

### 5.4 Accessibility & i18n

- **WCAG 2.1 AA basics** (REQ-N-005)
- **Thai + English** locales (REQ-N-006)

---

## 6. System Context for SA

รวม system-context inputs 5 หัวข้อ ที่ SA ต้องมีเพื่อออกแบบ SRS + SAD
ได้ครบถ้วนตาม IEEE 830 / ATAM guidelines

### 6.1 External Interfaces Inventory

รายการทุกระบบ/บริการที่ product ต้อง integrate ด้วย:

| # | External System | Direction | Phase | Protocol / Format | Notes |
|---|---|---|---|---|---|
| E1 | Owner email inbox | Outbound (notifications) | 1 | SMTP / API (SendGrid, Resend, etc.) | Notify on new submission + on plan ready |
| E2 | User email inbox | Outbound (notifications) | 1 | SMTP / API | Notify user เมื่อ plan ready |
| E3 | ChatGPT (via owner browser) | Manual (owner uses UI) | 1 | Web app | Wizard-of-Oz — no integration ใน Phase 1 |
| E4 | LLM API (GPT-4o / Claude Sonnet) | Outbound API | 2 | HTTPS REST / streaming | Plan generation; cost ~$0.05–0.20/user |
| E5 | Payment gateway (Omise / Stripe / IAP) | Outbound + webhook | 2 | HTTPS + webhook | Subscription checkout, cancel |
| E6 | Analytics platform (Firebase / Amplitude / Mixpanel) | Outbound (events) | 1+2 | HTTPS API | Non-PII events only |
| E7 | Cloud storage / backend | Bi-directional | 1+2 | Firebase / Supabase SDK or REST | Plans, submissions, user state |
| E8 | Push notification service (if used) | Outbound | 1+ | FCM / APNs | Reminders (Should tier — Q4) |

### 6.2 User Classes and Characteristics

| Class | Description | Privilege | Est % of total | Key characteristics |
|---|---|---|---|---|
| **U1 Fitness User (Nan)** | End user who follows the plan | Standard | ~95% post-launch | Tech-literate, smartphone daily, moderate routine |
| **U2 Owner / Admin** | Wizard-of-Oz coach + system admin | Elevated | 1 person (Phase 1) | Owner ตัวเอง — access queue + input plans |
| **U3 Anonymous visitor** | Pre-onboarding | Restricted | Small | Sees landing / onboarding intro only |
| **U4 Trialing user (Phase 2)** | In 30-day trial window | Standard | Varies | Same as U1 + trial countdown UI |
| **U5 Subscriber (Phase 2)** | Paid user | Standard | Target growth | Full app + regenerate cap 3/session |
| **U6 Grandfathered F&F (Phase 2)** | Phase 1 cohort → lifetime free | Standard | 3–5 fixed | Lifetime free flag |

### 6.3 Operating Environment

**Target devices (Phase 1):**
- **Mobile primary:** iOS 15+ / Android 10+ (mid-tier and newer)
- **Desktop (if PWA):** Chrome / Safari — latest 2 versions
- **Screen sizes:** 320px – 1920px (responsive)

**Network conditions:**
- **Offline:** required for Today view (REQ-N-002)
- **Poor connection:** graceful degradation (retry submit, cached read)
- **Wi-Fi / 4G / 5G:** standard
- **Peak usage:** morning 7–9am · before workout 5–7pm · before meals

**Backend infrastructure (SA to decide):**
- **Region:** Southeast Asia (Singapore หรือ nearest)
- **Uptime target:** ≥ 99% (personal project scope, not 99.9)
- **CDN:** static assets ผ่าน CDN ถ้าเลือก PWA

**Development environment:**
- **OS:** macOS (owner's dev machine)
- **Tools:** VS Code / Xcode / standard dev tooling
- **CI/CD:** GitHub Actions หรือ platform built-in (Vercel/Netlify)

### 6.4 Data Volume Expectations

**Phase 1 (F&F cohort ≤ 5–10 users):**

| Entity | Volume/user | Total Phase 1 |
|---|---|---|
| Submissions | 1–3 (with regenerate) | ≤ 30 records |
| Plans (active) | 1 per user | ≤ 10 records |
| Plan items (5 domains) | ~50–100/plan | ≤ 1,000 records |
| Analytics events | ~10–30/user/day | ≤ 300/day |
| **Total DB size** | | **< 10 MB** |

**Phase 2 (public launch — SA design for these):**

| Metric | Assumption | Notes |
|---|---|---|
| MAU (year 1) | 100 – 1,000 | Personal project, organic growth |
| Peak concurrent users | 10 – 50 | Morning/evening spikes |
| Requests/user/day | 5 – 10 (mostly Today view opens) | Read-heavy |
| LLM generations/user | 1 – 4 (regen cap 3) | Cost ~$0.10 – 0.20/user |
| Storage growth | ~1 MB/user | Health data + plan history |

**Data retention:**
- Active user data: indefinite (subscribe = keep)
- Deleted user data: hard-delete within 30 days (PDPA)
- Analytics: aggregate only, 12-month retention

### 6.5 Quality Attribute Priorities (Ranked)

**เมื่อต้อง trade-off, priority ranking นี้ทำหน้าที่ referee:**

| Rank | Quality Attribute | Priority | Trade-off ที่ยอมได้ |
|---|---|---|---|
| 1 | **Safety (health / legal)** | Absolute | ยอม slow / ugly เพื่อ safety |
| 2 | **Simplicity / maintainability** | High | Less features เพื่อ solo dev sustainable |
| 3 | **User experience (glanceable, fast)** | High | Core UX ห้าม compromise |
| 4 | **Offline capability** | High | REQ-N-002 บังคับ |
| 5 | **Time-to-market** | Medium | Wizard-of-Oz — validate ก่อน scale |
| 6 | **Cost (infra)** | Medium | Free tier where possible, but not at UX cost |
| 7 | **Scalability** | Low (Phase 1) | Design for extension, no premature optim |
| 8 | **Rich features** | Low | MoSCoW cut list พร้อม |

**Guiding principle:** *When in doubt, favor Safety > Simplicity > UX > everything else.*

---

## 7. Assumptions (SA ควรท้าทายถ้าไม่เห็นด้วย)

| # | Assumption | Impact if false |
|---|---|---|
| A1 | Tech stack familiar to owner (ไม่ต้อง learn new) | Effort estimate ต้อง +25% |
| A2 | Backend as-a-service (Firebase/Supabase) ตอบโจทย์ | Custom backend = +เยอะ ชม. |
| A3 | ChatGPT UI สำหรับ Wizard-of-Oz พอ (ไม่ต้อง build integration ใน Phase 1) | ต้อง build LLM integration ล่วงหน้า |
| A4 | Email notification (owner) พอสำหรับ Phase 1 (ไม่ต้อง push) | UX ช้าลง, cohort อาจ drop |
| A5 | F&F cohort เข้าใจ Wizard-of-Oz (owner manual) | Positioning ต้องชัดกว่านี้ |
| A6 | Phase 1 ไม่ต้อง user account (device-only + email in form) | Migration ตอน Phase 2 มี pain |
| A7 | Offline-first สำหรับ Today view เพียงพอ (ไม่ต้อง real-time sync) | Multi-device use = pain |

---

## 8. Kickoff Meeting

### 8.1 Meeting Details

| Item | Value |
|---|---|
| Meeting name | SA Kickoff — Daily Fitness Companion Phase 1 |
| Duration | 90 นาที (recommended) |
| Format | Video call หรือ in-person |
| Attendees | PO (mandatory), PM (mandatory), SA (mandatory), Tech Lead (recommended if separate) |
| Prerequisite | ทุกคน read PRD + REQ + WBS ก่อนประชุม |

### 8.2 Agenda

| # | Topic | Duration | Owner |
|---|---|---|---|
| 1 | Welcome + attendees | 5 นาที | PO |
| 2 | Project context & business goal | 15 นาที | PO |
| 3 | Doc walkthrough (PRD → REQ → WBS → EST → SCH) | 20 นาที | PM |
| 4 | Wizard-of-Oz approach — why + how (Phase 1 vs Phase 2) | 10 นาที | PO |
| 5 | Open questions Q1–Q3 (blocking) — discuss + decide | 20 นาที | ALL |
| 6 | SA deliverables expected — confirm scope + priority | 10 นาที | SA + PM |
| 7 | Timeline expectations — SA estimates | 5 นาที | SA |
| 8 | Communication cadence + review schedule | 3 นาที | PM |
| 9 | Sign-off + action items | 2 นาที | ALL |

### 8.3 Materials to Bring

- All 7 docs (this + 6 formal) — printed หรือ shared link
- Demo of current state (if any prototype)
- Prompt playbook draft (WBS 1.1.5)
- Constraints list (§5)
- Assumptions list (§7)

---

## 9. Handoff Checklist

**PO/PM ต้องทำก่อน handoff meeting:**

- [ ] ทุก doc (PRD, REQ, WBS, EST, SCH, Stories) sign-off เป็น v0.6 DRAFT ขึ้นไป
- [ ] HND.md (this doc) เขียนเสร็จ + review
- [ ] Access ให้ SA (read + comment ต่อทุก doc)
- [ ] Meeting scheduled + calendar invite ส่งแล้ว
- [ ] Prompt playbook draft พร้อม (WBS 1.1.5)
- [ ] Open questions §3 ระบุครบ (SA จะได้ prep)

**SA ต้องทำก่อน handoff meeting:**

- [ ] Read PRD (understand product)
- [ ] Skim REQ (get sense of scope)
- [ ] Skim WBS + EST (understand deliverables + effort)
- [ ] Prep initial thoughts on Q1, Q2, Q3
- [ ] List clarifying questions

**During handoff meeting:**

- [ ] Cover ทุก agenda item §8.2
- [ ] Decide Q1 + Q2 (or set decision deadline)
- [ ] Confirm SA deliverable priority (§4)
- [ ] Agree on communication cadence

**After handoff meeting:**

- [ ] Meeting minutes ส่ง within 24 ชม.
- [ ] Action items assigned พร้อม deadline
- [ ] Next review meeting scheduled (recommend 1 สัปดาห์ post-handoff เพื่อ SA แสดง initial SRS draft)

---

## 10. Communication After Handoff

### 10.1 Cadence

| Interaction | Frequency | Owner |
|---|---|---|
| SA questions → PO (async) | As-needed via Slack/email | SA |
| SRS review | Within 1 wk of draft | PO + PM |
| SAD review | Within 1 wk of draft | PO + PM + Tech Lead |
| Weekly sync | Weekly ระหว่าง SA phase | ALL |
| Phase gate — SA to Dev | Formal review + sign-off | ALL |

### 10.2 Change Management

หาก **PRD ต้อง change ระหว่าง SA phase:**

1. PO เขียน change request (what/why)
2. PM ประเมิน impact ต่อ WBS/EST/SCH
3. SA ประเมิน impact ต่อ SA deliverables + timeline
4. Decision — accept, defer, or reject
5. Update ทุก doc affected + revision bump
6. Communicate to team

---

## 11. Post-Handoff SA Phase — Next Milestones

| Milestone | SA Deliverable | Sign-off by |
|---|---|---|
| SA-M1 | SRS draft (10 วันหลัง kickoff) | PO |
| SA-M2 | SAD draft (2 สัปดาห์หลัง SRS) | PO + PM |
| SA-M3 | DDD + API + DB (3 สัปดาห์หลัง SAD) | PM + Tech Lead |
| SA-M4 | Sec Arch + Deploy Arch (1 สัปดาห์หลัง DDD) | PO + PM |
| SA-M5 | SA phase complete → Dev kickoff | ALL |

**Handoff to Dev** = separate handoff document (not in scope of this HND)

---

## 12. Sign-off Block

**Handed by:**

| Role | Name | Signature | Date |
|---|---|---|---|
| Product Owner | ___________ | ___________ | _______ |
| Project Manager | ___________ | ___________ | _______ |

**Accepted by:**

| Role | Name | Signature | Date |
|---|---|---|---|
| Systems Analyst | ___________ | ___________ | _______ |
| Tech Lead (if applicable) | ___________ | ___________ | _______ |

**Handoff status:**

- [ ] All PO/PM checklist items complete
- [ ] All SA checklist items complete
- [ ] Kickoff meeting held
- [ ] Q1, Q2 decisions made (or deadline set)
- [ ] Communication cadence agreed
- [ ] SA phase officially started

---

## 13. Appendix — Quick Reference

### 13.1 Document Map

```
Product spec        PRD.md      → SA reads for context
Requirements       REQ.md      → SA extends into SRS
Work breakdown     WBS.md      → SA maps to system components
Effort estimates   EST.md      → SA calibrates for tech
Schedule           SCH.md      → SA adds architecture milestones
Stories + AC       Stories.md  → SA references for behavior detail
Handover           HND.md      → THIS doc — bridge
```

### 13.2 Key REQ IDs สำหรับ SA

- **REQ-N-001 to 010** — All non-functional (SA's primary concern)
- **REQ-R-001 to 006** — Regulatory (SA design implications)
- **REQ-F-005 to 007** — Owner input flow (unique to Wizard-of-Oz)
- **REQ-F-008** — Today view (offline-first critical)
- **REQ-F-017 to 023** — Phase 2 items SA ควรรับรู้ (design for extensibility)

### 13.3 Contact Points

| Role | Name | Contact | Availability |
|---|---|---|---|
| Product Owner | ___________ | ___________ | ___________ |
| Project Manager | ___________ | ___________ | ___________ |
| Systems Analyst | ___________ | ___________ | ___________ |
