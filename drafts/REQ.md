# Requirements Document — Daily Fitness Companion (Phase 1)

**Purpose:** Formal catalog ของ requirements ทั้งหมด — Business, Functional,
Non-Functional, และ Regulatory — พร้อม traceability matrix เชื่อมกับ stories
และ WBS

**Source docs:** PRD.md, stories.md
**Related docs:** WBS.md (implementation), EST.md (effort), SCH.md (schedule)

## Requirement ID Convention

- `REQ-B-###` — Business requirement (ต้องการทางธุรกิจ)
- `REQ-F-###` — Functional requirement (ระบบต้องทำได้)
- `REQ-N-###` — Non-functional requirement (คุณภาพ / performance)
- `REQ-R-###` — Regulatory / Compliance / Safety
- Priority: **P0** (Must, Phase 1) · **P1** (Should) · **P2** (Could) · **P3** (Phase 2)

---

## 1. Business Requirements

| ID | Requirement | Priority | Source | Verification |
|---|---|---|---|---|
| REQ-B-001 | Product ต้องแก้ pain "ไม่รู้จะเริ่มยังไง" ของสมาชิกฟิตเนสที่ไม่มี routine | P0 | PRD §2A | User interview post-launch |
| REQ-B-002 | Product ต้องแก้ pain "จำ plan ไม่ได้" ของผู้ใช้ที่มี routine อยู่แล้ว | P0 | PRD §2B | Metric: time-to-answer "วันนี้ทำอะไร" < 5 วิ |
| REQ-B-003 | Phase 1 ต้อง validate hypothesis "AI plan น่าเชื่อถือ" ผ่าน Wizard-of-Oz | P0 | PRD §11, decision 2026-07-25 | F&F feedback + plan acceptance rate ≥ 60% |
| REQ-B-004 | Business model = Freemium (trial 30 วัน → subscription) | P3 (Phase 2) | PRD §10 | Payment flow ทำงานได้ |
| REQ-B-005 | Phase 1 F&F cohort ได้ lifetime free access | P3 (Phase 2) | PRD §10, decision log | Grandfather flag ใน account |
| REQ-B-006 | LLM cost / user / onboarding ≤ USD 0.20 | P3 (Phase 2) | PRD §4 | API bill / user count |
| REQ-B-007 | Onboarding completion rate ≥ 70% | P0 | PRD §4 | Funnel analytics |
| REQ-B-008 | Daily adherence — % วันที่เปิด Today view ก่อน 10:00 ≥ 80% เดือนที่ 1 | P0 | PRD §4 | In-app event tracking |

---

## 2. Functional Requirements

### 2.1 Phase 1 (Wizard-of-Oz)

| ID | Requirement | Priority | Source Story | WBS |
|---|---|---|---|---|
| REQ-F-001 | ระบบต้องมี onboarding form 12 คำถาม profile (goal, level, age, gender, weight, height, days/week, session length, equipment, diet, allergies, dislikes) — คำถาม medical-condition screening เป็นคำถามแยกต่างหาก ตาม REQ-F-003 | P0 | US-01 | 1.2.1 |
| REQ-F-002 | ระบบต้อง save partial onboarding และ resume ได้เมื่อเปิดกลับใน 30 วัน | P1 | US-02 | 1.6.1 |
| REQ-F-003 | ระบบต้อง block user ที่ระบุ medical condition หรือให้ bypass ผ่าน explicit consent | P0 | US-03 | 1.3.4 |
| REQ-F-004 | Owner ต้องเห็น queue ของ submissions พร้อม name/email/timestamp/status เรียงตาม oldest pending first | P0 | US-04 | 1.2.2 |
| REQ-F-005 | Owner ต้อง input weekly workout program (day × exercises × sets/reps/rest/note) พร้อม auto-save | P0 | US-05 | 1.3.1 |
| REQ-F-006 | Owner ต้อง input meals + supplements + cardio + recovery ผ่าน structured fields (ไม่ใช่ free text) | P0 | US-06 | 1.3.2 |
| REQ-F-007 | Owner ต้องกด "Mark ready" แล้วส่ง email notification ให้ user | P0 | US-07 | 1.3.3 |
| REQ-F-008 | User ต้องเห็น Today view ที่แสดง workout ของวันนี้ทันทีเมื่อเปิดแอป | P0 | US-08 | 1.4.1 |
| REQ-F-009 | Today view ต้องแสดง meals ของวันนี้ในหน้าเดียวกันกับ workout | P0 | US-09 | 1.4.2 |
| REQ-F-010 | Today view ต้องแสดง supplements + cardio + recovery ตาม timing | P1 | US-10 | 1.5.1 |
| REQ-F-011 | Today view ต้อง handle empty state (pending / rest day / no plan) | P1 | US-11 | 1.5.2 |
| REQ-F-012 | User ต้อง browse วันอื่นของสัปดาห์ได้ (swipe or tap) | P0 | US-12 | 1.5.3 |
| REQ-F-013 | User ต้องแก้ item (exercise/meal/supp) ผ่าน modal ได้ | P0 | US-13 | 1.5.4 |
| REQ-F-014 | User ต้อง add/remove item ใน day ได้ | P1 | US-14 | 1.5.5 |
| REQ-F-015 | User ต้อง duplicate สัปดาห์นี้ไปสัปดาห์ถัดไปได้ | P2 | US-15 | 1.5.6 |
| REQ-F-016 | ระบบต้องแสดง disclaimer "ไม่ใช่คำแนะนำทางการแพทย์" ที่ onboarding + plan review + About | P0 | US-16 | 1.2.3 |

### 2.2 Phase 2 (Full Product)

| ID | Requirement | Priority | Source | Phase |
|---|---|---|---|---|
| REQ-F-017 | ระบบต้อง generate plan อัตโนมัติผ่าน LLM (replace owner manual step) | P3 | PRD §7 P2-M1 | 2 |
| REQ-F-018 | User ต้อง regenerate plan ได้สูงสุด 3 ครั้ง/onboarding | P3 | PRD §7 P2-M2 | 2 |
| REQ-F-019 | ระบบต้องมี user auth (email + password หรือ magic link) | P3 | PRD §7 P2-M5 | 2 |
| REQ-F-020 | ระบบต้อง track trial state 30 วันนับจาก account creation พร้อม countdown UI | P3 | PRD §7 P2-M6 | 2 |
| REQ-F-021 | เมื่อ trial หมด → lock ทั้งแอป เห็นแค่ upgrade CTA + cancel/logout/support | P3 | PRD §7 P2-M7 | 2 |
| REQ-F-022 | ระบบต้องรองรับ subscription payment (checkout, webhook, cancel) | P3 | PRD §7 P2-M8 | 2 |
| REQ-F-023 | Phase 1 F&F cohort ต้องได้ lifetime free access อัตโนมัติเมื่อ Phase 2 launch | P3 | PRD §7 P2-M9 | 2 |

---

## 3. Non-Functional Requirements

| ID | Requirement | Category | Target | Verification |
|---|---|---|---|---|
| REQ-N-001 | Today view ต้อง render ≤ 500ms (cached) | Performance | 500ms p95 | Manual timing 10 sessions |
| REQ-N-002 | Today view ต้องทำงาน offline ได้เต็มที่ (offline-first) | Availability | 100% offline | Airplane mode test |
| REQ-N-003 | Onboarding form ต้อง navigate instant (≤ 200ms per step) | Performance | 200ms | UX test |
| REQ-N-004 | User data (health, workout) ต้องเก็บ local เป็นหลัก | Privacy | Local storage priority | Code review |
| REQ-N-005 | UI ต้องผ่าน WCAG 2.1 AA basics (contrast, touch target ≥ 44px, keyboard, screen reader labels) | Accessibility | WCAG 2.1 AA | axe / VoiceOver test |
| REQ-N-006 | ระบบต้องรองรับ 2 locales: Thai + English | i18n | 2 locales | Locale switch test |
| REQ-N-007 | Consent flow ต้องแจ้งชัดว่า owner (Phase 1) เห็น profile ของ user | Privacy | Explicit consent | Consent screen present |
| REQ-N-008 | Analytics ต้องไม่ track PII (email, name, health data) | Privacy | 0 PII in events | Analytics review |
| REQ-N-009 | LLM generation ต้อง response ≤ 30 วิ (Phase 2) | Performance | 30s max | Timing test |
| REQ-N-010 | Backend availability ≥ 99% (uptime, non-launch) | Reliability | 99% uptime | Monitoring |

---

## 4. Regulatory / Compliance / Safety

| ID | Requirement | Category | Source |
|---|---|---|---|
| REQ-R-001 | Disclaimer "ไม่ใช่คำแนะนำทางการแพทย์" ต้องแสดง onboarding intro, plan review, About page | Safety | PRD §5 non-goals, US-16 |
| REQ-R-002 | User ที่ระบุ medical condition (heart, diabetes, injury, pregnancy) ต้องถูก block; bypass ต้องมี explicit consent + flag | Safety | US-03 |
| REQ-R-003 | LLM prompt (Phase 2) ต้อง include disclaimer + block extreme (< 1200 kcal, ยกเกิน 1RM ประมาณ) | Safety | PRD §7 M7 |
| REQ-R-004 | T&C + Privacy Policy ต้องพร้อมก่อน Phase 2 public launch | Legal | PRD Q11 |
| REQ-R-005 | Personal data handling ต้อง compliant กับ พ.ร.บ. คุ้มครองข้อมูลส่วนบุคคล (PDPA) | Legal | PDPA (Thailand) |
| REQ-R-006 | Payment gateway (Phase 2) ต้อง PCI DSS compliant ผ่าน provider (Omise/Stripe) | Regulatory | Payment industry standard |

---

## 5. Traceability Matrix

**REQ ↔ Story ↔ WBS ↔ SA Design (Phase 1 only — Phase 2 pending)**

**หมายเหตุ:** column "SA Reference" เติมจาก SRS v0.6 (§8 traceability) แล้ว.
SAD/DDD references จะเติมเมื่อ SA สร้างเอกสารถัดไป

| REQ ID | Requirement | Story | WBS Code | Priority | SA Reference | Verification |
|---|---|---|---|---|---|---|
| REQ-B-001 | Discovery pain | (none direct) | (business goal) | P0 | SRS §1.2 | Interview |
| REQ-B-002 | Reminder pain | (none direct) | (business goal) | P0 | SRS §5.6 (N-6.3) | Metric |
| REQ-B-003 | Validate hypothesis | (none direct) | 1.6, 1.7 | P0 | SRS §2.1 | Retro |
| REQ-B-007 | Onboarding completion 70% | US-01, US-02, US-03 | 1.2.1, 1.6.1, 1.3.4 | P0 | SRS §4.1 | Funnel |
| REQ-B-008 | Adherence 80% | US-08 | 1.4.1 | P0 | SRS §4.4 | Event |
| REQ-F-001 | Onboarding form | US-01 | 1.2.1.* | P0 | SRS §4.1 | AC US-01 |
| REQ-F-002 | Save/resume | US-02 | 1.6.1.* | P1 | SRS §4.1.4 AF3 | AC US-02 |
| REQ-F-003 | Medical block | US-03 | 1.3.4.* | P0 | SRS §4.1.4 AF1, §4.6 | AC US-03 |
| REQ-F-004 | Owner queue | US-04 | 1.2.2.* | P0 | SRS §4.2 | AC US-04 |
| REQ-F-005 | Owner workout input | US-05 | 1.3.1.* | P0 | SRS §4.3 | AC US-05 |
| REQ-F-006 | Owner nutrition input | US-06 | 1.3.2.* | P0 | SRS §4.3 | AC US-06 |
| REQ-F-007 | Mark ready + notify | US-07 | 1.3.3.* | P0 | SRS §4.3 | AC US-07 |
| REQ-F-008 | Today view workout | US-08 | 1.4.1.* | P0 | SRS §4.4 | AC US-08 |
| REQ-F-009 | Today view meals | US-09 | 1.4.2.* | P0 | SRS §4.4 | AC US-09 |
| REQ-F-010 | Today view supp/cardio | US-10 | 1.5.1.* | P1 | SRS §4.4 | AC US-10 |
| REQ-F-011 | Empty/rest states | US-11 | 1.5.2.* | P1 | SRS §4.4 AF | AC US-11 |
| REQ-F-012 | Browse days | US-12 | 1.5.3.* | P0 | SRS §4.5 | AC US-12 |
| REQ-F-013 | Edit item | US-13 | 1.5.4.* | P0 | SRS §4.5 | AC US-13 |
| REQ-F-014 | Add/remove item | US-14 | 1.5.5.* | P1 | SRS §4.5 | AC US-14 |
| REQ-F-015 | Duplicate week | US-15 | 1.5.6.* | P2 | SRS §4.5 | AC US-15 |
| REQ-F-016 | Disclaimer | US-16 | 1.2.3.* | P0 | SRS §4.6 | AC US-16 |
| REQ-N-001 | Perf 500ms | US-08 | 1.4.1.* | P0 | SRS §5.1 (N-1.1) | Timing |
| REQ-N-002 | Offline | US-08 | 1.4.1.5 | P0 | SRS §5.2 (N-2.2), §4.4 AF2 | Airplane test |
| REQ-N-003 | Onboarding nav ≤ 200ms | US-01 | 1.2.1.* | P0 | SRS §5.1 (N-1.2) | Timing |
| REQ-N-004 | Health data local | (cross-cutting) | 1.1.3 | P0 | SRS §5.4 (N-4.2), §6.3 | Code review |
| REQ-N-005 | WCAG AA | (cross-cutting) | 1.6.2 | P0 | SRS §5.6 (N-6.1), §7.3 | Audit |
| REQ-N-006 | Thai + English | (cross-cutting) | 1.2.3.1 | P0 | SRS §5.6 (N-6.2), §7.2 | Locale switch |
| REQ-N-007 | Owner viewing consent | US-01 | 1.2.1.* | P0 | SRS §5.4 (N-4.3) | Consent screen present |
| REQ-N-008 | No-PII analytics | (cross-cutting) | 1.4.1.6 | P0 | SRS §5.4 (N-4.4), §7.4 | Analytics review |
| REQ-N-010 | Backend ≥ 99% uptime | (cross-cutting) | 1.1.4 | P0 | SRS §5.2 (N-2.1) | Uptime monitor |
| REQ-R-001 | Disclaimer | US-16 | 1.2.3.* | P0 | SRS §4.6, §7.1 | AC US-16 |
| REQ-R-002 | Medical block/bypass | US-03 | 1.3.4.* | P0 | SRS §4.1.4 AF1, §4.6 | AC US-03 |
| REQ-R-005 | PDPA compliance | (cross-cutting) | (design) | P0 | SRS §6.3, §7.1 | Legal review |

---

## 6. Change Control

Requirements changes require:
1. Documented change request (ที่ไหน / อะไร / ทำไม)
2. Impact analysis (traceability — story, WBS, cost)
3. Approval (owner สำหรับ personal project)
4. Update REQ.md revision + all downstream docs
5. Regenerate PDF/DOCX

---

## 7. Notes

- **Phase 1 requirements**: 16 stories (P0×11 + P1×4 + P2×1). Effort ที่เป็นทางการ = **base ~86.5 ชม. + N×1/user** — ดู EST.md (authoritative); story-level breakdown ใน stories.md
- **Phase 2 requirements** (REQ-F-017 to 023): parked จนกว่า validate hypothesis
- **Regulatory (REQ-R-004, 005, 006)**: กระทบก่อน public launch เท่านั้น — Phase 1 F&F อยู่ใน internal use scope
