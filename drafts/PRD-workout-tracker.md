# Daily Fitness Companion (ชื่อชั่วคราว — TBD)

**Owner:** [you] · **Status:** Draft v5 · **Last updated:** 2026-07-25
**Engineering:** solo · **Design:** solo · **Sign-off:** solo
**Timeline:** 3 เดือน · **Capacity:** 8–10 ชม./สัปดาห์ · **Team:** Solo
**Business model:** Freemium — trial 30 วัน → lock → subscription (Phase 2)

> **v5 revised:** เพิ่ม business model — freemium trial 30 วัน แล้ว lock ทั้งแอป
> จนกว่า subscribe. Payment integration = Phase 2 (หลัง validate); Phase 1
> F&F ใช้ฟรีทั้งหมด. ดู §15 Business Model
>
> **v4:** Timeline 3 เดือน + 8–10 ชม./สัปดาห์ (solo) — scope v3 เกิน budget
> จึงเลือก Path A: Wizard-of-Oz. LLM = Phase 2. ดู §14

---

## 1. Summary

แอปมือถือที่ให้ **plan การออกกำลังกาย + โภชนาการ + supplement + cardio +
recovery ครบทั้งชุด** ผ่านการตอบ onboarding form แล้วแสดง **Today view** ทุกวัน
เพื่อเตือนว่าวันนี้ต้องทำอะไร กี่ set กี่ reps กินอะไร ปริมาณเท่าไหร่ กิน
supplement ตัวไหนตอนไหน

**Phase 1 (3 เดือนแรก):** Wizard-of-Oz — owner generate plan ด้วย ChatGPT
manual แล้ว input เข้าระบบ. Validate ว่า plan มีคุณภาพและ Today view มี value
ก่อน invest LLM integration

**Phase 2 (หลัง validation):** เพิ่ม LLM integration + safety guardrails
+ regeneration + **payment (freemium trial 30d)**

## 2. Problem

**สอง problem ที่ product นี้แก้:**

### Problem A: ไม่รู้จะเริ่มยังไง (คนไม่มี routine)
- อยากออกกำลัง แต่ไม่รู้เล่นท่าอะไร กี่วัน/สัปดาห์ กี่ set
- อยากคุมอาหาร แต่ไม่รู้ควรกินเท่าไหร่
- ปรึกษาโค้ชแพง — 3,000–10,000 บาท/แผน

### Problem B: มี plan แล้ว แต่จำไม่ได้ (คนมี routine)
- Plan อยู่ใน Notion/Notes กระจายหลายหน้า
- เปิดหา "วันนี้ต้องทำอะไร" ใช้เวลา ~30 วิ
- แก้ plan ตอน deload/สลับวัน ต้องแก้หลายจุด

**Evidence:** ยังไม่มี — assumption จาก owner
(**Wizard-of-Oz Phase 1 คือกลไก validate หลัก** — ก่อน invest LLM)

## 3. Why now

- Personal experiment + timeline 3 เดือน
- LLM API ราคาลง (Phase 2 economics ทำได้)
- Owner อยาก dogfood + validate hypothesis เร็ว

## 4. Goals and success metrics

### Phase 1 metrics (3 เดือน)

| Metric | Baseline | Target | Measured by |
|---|---|---|---|
| Onboarding completion | — | ≥ 70% | Funnel event |
| Time to first plan (form submit → รับ plan) | — | < 24 ชม. (manual) | Owner turnaround |
| Plan acceptance rate (user รับ plan โดยไม่ขอแก้หนัก) | — | ≥ 60% | User action |
| เวลาตอบ "วันนี้ต้องทำอะไร" | 30 วิ (Notion) | < 5 วิ | Manual timing |
| Adherence — % วันที่เปิด Today view ก่อน 10:00 | — | ≥ 80% เดือนที่ 1 | Event |
| Owner effort / user / plan | — | < 30 นาที | Manual timing |

**Guardrail Phase 1:**
- Owner effort ต่อ user ต้อง trending ลง (เรียนรู้ pattern → เร็วขึ้น)
- % user ที่กลับไป Notion ต้อง trending ลง

### Phase 2 metrics (หลัง validate)
- LLM cost/user < $0.20
- Plan quality ≥ manual baseline (Phase 1)
- Owner effort → 0

## 5. Non-goals

- ไม่ใช่ real-time chat coach
- ไม่ใช่แอปสำหรับเทรนเนอร์ assign plan
- ไม่ใช่ marketplace
- Phase 1: **ไม่มี LLM integration** (owner manual)
- ไม่มี ongoing AI adjustments (v2 hypothesis, ยังไม่ทำ)
- ไม่มี auto-macro tracking
- ไม่ใช่ social / community
- ไม่รองรับ wearable sync
- **Phase 1: ไม่มี payment** (F&F ใช้ฟรี); Phase 2 = freemium trial 30d
- ไม่มี ads (freemium ล้วน ไม่มี ad-supported tier)
- ไม่มี refund automated (Phase 2 = manual refund ผ่าน owner)
- **ไม่ใช่ medical advice** — plan มี disclaimer, ไม่รับ user ที่ระบุ medical condition

## 6. Users and use cases

**Primary — Friends & family cohort (3–5 คน)**
- Mix ของ "ไม่มี plan" + "มี plan อยู่แล้ว"
- ยินดี provide feedback สัปดาห์ละครั้ง
- อยู่ในสังคมของ owner (เข้าถึง feedback ง่าย)

**Use frequency:**
- Onboarding: 1 ครั้ง
- Daily open: 2–4 ครั้ง/วัน
- Feedback loop: weekly conversation กับ owner

## 7. Requirements

### Phase 1 Musts (Wizard-of-Oz) — ship ใน 3 เดือน

- **P1-M1** Onboarding form — 10–12 คำถาม (profile + goal + preferences +
  medical flag). Save partial, resume-able
- **P1-M2** Submission queue — form → owner ดูได้ (simple admin view หรือ
  email notification ก็พอ)
- **P1-M3** Plan input UI — owner กรอก plan ที่ generate จาก ChatGPT
  เข้าระบบ (structured fields: workout / meal / supplement / cardio / recovery)
- **P1-M4** Save plan → auto-populate weekly schedule
- **P1-M5** **Today view** — เปิดปุ๊บเห็นทุก domain ของวันนี้เรียงตามเวลา
- **P1-M6** Manual edit — user แก้รายวัน/รายสัปดาห์ได้ทุกเมื่อ
- **P1-M7** Disclaimer copy — "ไม่ใช่คำแนะนำทางการแพทย์" ทั้ง onboarding
  และ plan review; block medical condition ที่ระบุใน form

### Phase 1 Shoulds (ถ้ามีเวลาเหลือ)
- **P1-S1** Notification เตือนก่อนเทรน / ก่อนมื้อ
- **P1-S2** Check-off ต่อ item
- **P1-S3** Tomorrow view

### Phase 2 Musts (หลัง validation, ~เดือน 4–6)
- **P2-M1** LLM integration — replace owner manual step (M3)
- **P2-M2** Review + edit + regenerate UI (cap 3 ครั้ง)
- **P2-M3** Safety guardrails — prompt engineering + blocked keywords
- **P2-M4** LLM cost monitoring + rate limit
- **P2-M5** User auth — email + password / magic link; migrate Phase 1 device data → account
- **P2-M6** Trial state — 30 วันนับจาก account creation; countdown UI ก่อน expire
- **P2-M7** Lock screen — เมื่อ trial หมด → full-app paywall (except cancel/logout/support)
- **P2-M8** Payment integration — subscription checkout, webhook, subscription state, cancel flow
- **P2-M9** Grandfathering — Phase 1 F&F cohort ได้ lifetime free (reward สำหรับ validate)

### Could (any phase)
- Log actual, history/streak, body weight, meal photo, export CSV

### Won't (v1)
- Chat coach, coach marketplace, social, subscription, wearable, AI adjust

## 8. Experience

**Platform:** TBD — ดู Q1

**Phase 1 flow:**
1. User: open app → onboarding (12 Qs, ~3 นาที) → "รอ owner สร้าง plan
   ให้ ~24 ชม." → notification เมื่อพร้อม → Today view
2. Owner (behind the scenes): เห็น submission → เปิด ChatGPT →
   generate plan → กรอกเข้าระบบ (~30 นาที/user)
3. Daily: user เปิด → Today view ทันที

**States ที่ต้องมี:**
- Onboarding progress (12 steps)
- **Pending plan** (waiting for owner) — ต้องดูโปรอย่าให้ user สงสัย
- Plan ready notification
- Empty Today view (rest day)
- Offline (cached plan)

**Core UX principle:** *Glanceable* + Phase 1: จัดการ expectation ให้ดี
เรื่อง "24 ชม. รอ plan"

**Accessibility:** WCAG 2.1 AA basics
**Locales:** ไทย + อังกฤษ

## 9. Non-functional requirements

- **Performance:** Today view render ≤ 500ms
- **Availability:** offline-first สำหรับ Today view
- **Data:**
  - Health data (weight, injuries, dietary) เก็บ local หลัก
  - Backend เก็บ submission + plan
- **Privacy:**
  - Owner เห็น profile ของ user Phase 1 (แจ้งใน consent)
  - ไม่ track PII เกินจำเป็น
- **Analytics:** onboarding_step, plan_delivered, today_view_opened,
  item_engaged
- **Safety:** disclaimer + medical flag block

## 10. Dependencies and risks

| Item | Type | Impact | Mitigation |
|---|---|---|---|
| ตัดสินใจ tech stack | Dep | Block build | ตัดสิน week 1 |
| Backend simple (Firebase/Supabase) | Dep | Storage + auth | POC week 1 |
| Owner turnaround time | Risk | UX ช้า / drop-off | Cap 5 user Phase 1 |
| **Plan quality (owner-generated)** | Risk | Hypothesis fail | Iterate ChatGPT prompt owner ใช้เอง; peer review 2 plan แรก |
| **Safety/liability** | Risk | Legal, credibility | Disclaimer + medical flag + F&F only |
| Onboarding drop-off (12 คำถาม) | Risk | Low completion | Progressive disclosure, save partial |
| Timeline slip (part-time, weekend only) | Risk | Miss deadline | Cut S1–S3 first; weekly review |
| Scope creep — อยาก build LLM ก่อน validate | Risk | Miss deadline | ยึด Path A เข้ม — LLM = Phase 2 |

## 11. Rollout

### Phase 0 — Setup + validate approach (สัปดาห์ 1)
- ตัดสิน tech stack (Q1) + backend (Q2)
- Owner ทดลอง generate plan ด้วย ChatGPT 3 ครั้ง (self-test) — evaluate quality
- Setup analytics + basic infrastructure

### Phase 1 — Build MVP (สัปดาห์ 2–10)
- Week 2–3: P1-M1 Onboarding form
- Week 4: P1-M2 + P1-M3 Submission queue + plan input UI
- Week 5: P1-M4 Data model + schedule
- Week 6–7: P1-M5 Today view (core UX)
- Week 8: P1-M6 Manual edit
- Week 9: P1-M7 Disclaimer + polish
- Week 10: End-to-end testing + owner dogfood

### Phase 1 Launch — Friends & family (สัปดาห์ 11–13)
- Week 11: 1 friend (deep test, owner ใกล้ชิด)
- Week 12: เพิ่ม 2–3 friend
- Week 13: 4–5 friend + collect feedback + measure metrics

### Phase 2 — Decide (เดือน 4+)
- ถ้า metric §4 ผ่าน → invest LLM integration
- ถ้าไม่ผ่าน → iterate หรือ pivot

**Rollback:** ไม่มี — feature flag เอา P1-S1/S2/S3 ปิดได้ถ้ากินเวลาเกิน

## 12. Open questions

| # | Question | Owner | Needed by |
|---|---|---|---|
| Q1 | Platform: iOS native / PWA / RN? | you | Week 1 |
| Q2 | Backend: Firebase / Supabase / custom? | you | Week 1 |
| Q3 | Structured plan schema — ต้องออกแบบ data model ที่รองรับ 5 domain | you | Week 4 |
| Q4 | Notification — Phase 1 มี push หรือแค่ in-app? | you | Week 6 |
| Q5 | ChatGPT prompt สำหรับ owner ใช้ generate — ต้อง iterate ก่อน launch | you | Week 10 |
| Q6 | Friends & family cohort — 5 คนไหน? เข้าใจ Wizard-of-Oz หรือไม่ | you | Week 11 |
| Q7 | ชื่อ product | you | Week 10 |
| Q8 | **Pricing** — monthly เท่าไหร่? (~99/199/299 บาท?) | you | Phase 2 planning |
| Q9 | **Payment gateway** — Omise / Stripe / Google Play + App Store IAP? | you | Phase 2 planning |
| Q10 | **Refund policy** — nothing / 7 days / prorated? | you | Phase 2 launch |
| Q11 | **T&C + Privacy policy** — ต้องปรึกษาที่ปรึกษาไหมก่อนเปิด payment? | you | Phase 2 launch |
| Q12 | Yearly plan discount? (เช่น 2 เดือนฟรีถ้าจ่ายรายปี) | you | Phase 2 planning |

## 13. Decision log

| Date | Decision | Made by | Rationale |
|---|---|---|---|
| 2026-07-25 | v3 → v4: เลือก Path A (Wizard-of-Oz) สำหรับ Phase 1 | owner | Scope v3 (150–200 ชม.) เกิน budget (104–130 ชม.) — cut LLM integration ไป Phase 2 |
| 2026-07-25 | Timeline 3 เดือน + 8–10 ชม./สัปดาห์ solo | owner | Confirm capacity constraint |
| 2026-07-25 | Target Phase 1 = friends & family (3–5 คน) | owner | Realistic สำหรับ solo + wizard-of-oz (owner-in-loop) |
| 2026-07-25 | Cap Phase 1 ที่ 5 user | Claude (judgement) | Owner effort 30 นาที × 5 = 2.5 ชม./รอบ generate — สูงสุดที่จัดการได้ |
| 2026-07-25 | LLM = Phase 2, ไม่ใช่ Phase 1 | owner + Claude | Wizard-of-Oz validate hypothesis "plan น่าเชื่อถือ" + "Today view มี value" ได้โดยไม่ต้องเสียเวลา build LLM |
| 2026-07-25 | Notification (S1) = Should ไม่ใช่ Must | Claude (judgement) | Nice-to-have, ตัดได้ถ้า timeline แน่น |
| 2026-07-25 | **v4 → v5:** Business model = freemium trial 30 วัน → lock → subscription | owner | Recurring revenue model |
| 2026-07-25 | Payment integration = Phase 2 ไม่ใช่ Phase 1 | owner + Claude | F&F 5 คนไม่จ่ายเงินอยู่แล้ว + payment 25–30 ชม. เกิน budget Phase 1 |
| 2026-07-25 | Phase 1 = ไม่มี auth (device-only + email in form) | Claude (judgement) | Save ~15 ชม.; Phase 2 add auth + migrate |
| 2026-07-25 | Phase 1 F&F ได้ **lifetime free** (grandfathering) เมื่อ Phase 2 launch | Claude (judgement) | Reward สำหรับ validate + สร้าง goodwill; 5 คนไม่กระทบ economics |

---

## 14. Timeline & realistic scope (สำหรับ Phase 1)

### Budget vs. estimate

| Item | Effort (ชม.) |
|---|---|
| Tech setup + decisions | 10 |
| P1-M1 Onboarding form | 15 |
| P1-M2 Submission queue | 5 |
| P1-M3 Plan input UI | 10 |
| P1-M4 Save plan → schedule | 8 |
| P1-M5 Today view | 15 |
| P1-M6 Manual edit | 12 |
| P1-M7 Disclaimer + medical flag | 5 |
| Testing / bug fix / polish (20%) | 20 |
| Prompt iteration + owner practice | 10 |
| **Phase 1 total** | **~110 ชม.** |
| Budget (13 weeks × 8–10 ชม.) | 104–130 ชม. |

**Verdict:** เข้า budget แบบพอดี (fit tight) — buffer ~10–20% เท่านั้น

### Levers ถ้า slip
1. ตัด P1-S1/S2/S3 (Should) — ไม่กระทบ core hypothesis
2. Reduce cohort จาก 5 → 3 คน — ลด owner effort week 11–13
3. เลื่อน P1-M7 (medical flag) เป็น week 11 (grace period)
4. Notification manual (LINE/SMS จาก owner) แทน build ในแอป

### Do NOT do
- **อย่า** ตัด testing / polish — buggy MVP กับ F&F = อับอาย + feedback ผิด
- **อย่า** ย้าย LLM ขึ้น Phase 1 กลางทาง — จะ slip แน่นอน
- **อย่า** เพิ่ม cohort > 5 — owner effort จะ blow up

---

## Judgement calls ที่ Claude ตัดสินให้ (overrule ได้)

1. **Path A (Wizard-of-Oz) แนะนำสุด** — validate 2 hypothesis ด้วย effort ต่ำสุด;
   ป้องกัน invest LLM แล้วพบว่า plan quality ไม่ perceive ว่าดี
2. **Cap cohort ที่ 5 คน** — เพราะ owner effort 30 นาที × 5 = 2.5 ชม./รอบ =
   สูงสุดที่ทำได้สัปดาห์ละครั้ง
3. **P1-M7 Disclaimer เป็น Must** — แม้ Wizard-of-Oz ก็ยังให้คำแนะนำสุขภาพ,
   ต้องมี legal cover พื้นฐาน
4. **Notification (S1) เป็น Should** — first thing to cut ถ้า timeline แน่น
5. **แนะนำ prompt iteration ให้ owner** — ก่อน launch, owner ต้องมี playbook
   generate plan ให้ consistent (ไม่งั้น plan quality จะ vary ต่อ user)
6. **Phase 1 = ไม่มี auth** — save 15 ชม.; ยอมรับว่า Phase 2 ต้อง migrate data
7. **Grandfather Phase 1 F&F ให้ lifetime free** — reward + goodwill; 5 คนไม่กระทบ economics
8. **Refund manual ผ่าน owner** — Phase 2 ไม่ทำ auto-refund flow (save dev time,
   volume ยังต่ำ)

---

## 15. Business Model

### Freemium Trial (Phase 2)

| Tier | ระยะเวลา | ราคา | สิ่งที่ได้ |
|---|---|---|---|
| **Trial** | 30 วันนับจากสมัคร | ฟรี | Full app access |
| **Locked** | หลัง trial | — | Lock ทั้งแอป — เห็นแค่ upgrade CTA + cancel/logout/support |
| **Subscription** | ต่อเนื่อง | TBD — Q8 | Full app + regenerate ไม่จำกัด (cap เดิม 3/session) |

### Trial mechanics
- นับจากวัน account creation (ไม่ใช่วัน generate plan แรก)
- ไม่มี grace period หลัง expire — lock ทันที
- ก่อน expire 7 วัน: banner reminder ทุกครั้งที่เปิดแอป
- ก่อน expire 24 ชม.: modal เตือน + one-tap upgrade

### Locked state UX
- User เห็นได้: upgrade CTA, contact support, sign out, delete account
- User เห็นไม่ได้: Today view, plan detail, edit, history
- Data ยังอยู่ — subscribe เมื่อไหร่ก็ unlock กลับมา (ไม่ลบ)

### Grandfathering
- Phase 1 F&F cohort (5 คนแรก) → lifetime free
- Marker: `account.created_before === "2026-11-01"` (สมมติ Phase 2 launch)

### Cost economics (rough)
- LLM cost / user (onboarding + regen ≤ 3 ครั้ง): ~$0.20
- Payment gateway fee: 3.65% + ฿10 (Omise) / 2.9% + $0.30 (Stripe)
- ที่ราคา ฿199/เดือน: gross margin ~85–90% หลัง fee + LLM
- Break-even: ~1 paying user / เดือน (personal project, ไม่รวม dev time)

### Open economic questions (ดู §12)
- Q8 Pricing, Q9 Gateway, Q10 Refund, Q11 T&C legal, Q12 Yearly discount

---

## ⚠️ Next step แนะนำ

การวางแผน sprint-by-sprint (สัปดาห์ไหนทำอะไร, capacity ต่อสัปดาห์, risk register
ระหว่างทาง, status update) คือ**งานของ /project-manager** ไม่ใช่ /product-owner
แล้ว — PRD ตอนนี้ ready พอที่จะ handoff

**PO deliverables ที่เหลือก่อน handoff:**
- หั่น P1-M1 ถึง P1-M7 เป็น user stories พร้อม Given/When/Then AC
- Run Definition of Ready checklist ต่อ story
- ตอบ Q1, Q2 (platform + backend) — เพราะเป็น dependency

**PM ควรเริ่ม:**
- Sprint plan (13 สัปดาห์ = 6 sprint ละ 2 สัปดาห์ หรือ 13 weekly)
- Burn-down tracking
- Weekly self-review + adjust
