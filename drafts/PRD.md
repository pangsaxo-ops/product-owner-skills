# Daily Fitness Companion — PRD

**Owner:** [you]
**Status:** Approved for build
**Last updated:** 2026-07-25
**Timeline:** TBD — จะอัปเดตเมื่อพร้อม

> Personal experimental project · ผ่าน discovery/refine 5 รอบ (ดู iteration
> history ที่ `PRD-workout-tracker.md`)

---

## 1. Summary

แอปมือถือที่ **generate แผนการออกกำลังกาย + โภชนาการ + supplement + cardio +
recovery ครบทั้งชุด** จาก profile ของ user (ตอบคำถาม 10–12 ข้อ) แล้วแสดง
**Today view** ทุกวันเพื่อเตือนว่าวันนี้ต้องทำอะไร กี่ set กี่ reps กินอะไร
ปริมาณเท่าไหร่ กิน supplement ตัวไหนตอนไหน

Business model: **freemium** — trial 30 วัน แล้ว lock ทั้งแอปจนกว่าจะ subscribe.

## 2. Problem

แอปนี้แก้ 2 problem ในผลิตภัณฑ์เดียว:

### Problem A · Discovery — ไม่รู้จะเริ่มยังไง
- อยากออกกำลังกาย/คุมอาหาร แต่ไม่รู้เล่นท่าอะไร กี่ set กินเท่าไหร่ macros ประมาณไหน
- ค้นข้อมูล YouTube/Reddit/บทความ ได้เยอะจนล้น ตัดสินใจไม่ได้
- ปรึกษาโค้ชแพง — 3,000–10,000 บาท/แผน

### Problem B · Reminder — มี plan แล้ว แต่จำไม่ได้
- Plan อยู่ใน Notion / iPhone Notes กระจายหลายหน้า
- เปิดหา "วันนี้ต้องทำอะไร" ใช้เวลาประมาณ 30 วินาที
- แก้ plan ตอน deload/สลับวัน ต้องแก้หลายจุด
- ไม่มี view รวมของวันเดียว (workout + meal + supplement)

**Evidence:** ยังไม่มี — assumption จาก owner
(ควร validate 5–10 interview ก่อน invest หนัก — Q5)

## 3. Why now

- LLM API ราคาลงมาถึงจุดที่ทำ personal project ได้ (~$0.05–0.20/user)
- Fitness AI coach เริ่ม mainstream (Whoop, Freeletics, Peloton) แต่ยังไม่ตอบโจทย์
  "reminder view" ที่ owner ต้องการ
- Owner อยาก dogfood + validate hypothesis

## 4. Goals and success metrics

### Product metrics

| Metric | Baseline | Target | Measured by |
|---|---|---|---|
| Onboarding completion | — | ≥ 70% | Funnel event |
| Time to first plan (submit → รับ plan) | — | < 24 ชม. | Timestamp |
| Plan acceptance rate (ไม่ regen/edit หนัก) | — | ≥ 60% | User action |
| เวลาตอบ "วันนี้ต้องทำอะไร" | 30 วิ (Notion) | < 5 วิ | Manual timing |
| Adherence — % วันที่เปิด Today view ก่อน 10:00 | — | ≥ 80% เดือนที่ 1 | In-app event |

### Business metrics (Phase 2 onwards)

| Metric | Target | Notes |
|---|---|---|
| Trial → Subscription conversion | ≥ 15% | Industry avg ~5–20% |
| LLM cost / user / onboarding | < $0.20 | Cap regenerate 3 ครั้ง |
| Subscription churn (monthly) | < 8% | Personal project = tolerable |

### Guardrail metrics

- **จำนวน user ที่กลับไปเปิด Notion** — ต้อง trending ลง
- **จำนวนครั้ง regenerate เฉลี่ย/user** — ≤ 2 (ถ้าเกินแปลว่า prompt/model
  quality ยังไม่พอ, cost จะพุ่ง)

## 5. Non-goals

- ไม่ใช่ real-time chat coach (LLM one-shot generation only)
- ไม่ใช่แอปสำหรับเทรนเนอร์ assign plan ให้ลูกค้า
- ไม่ใช่ marketplace หา coach หรือ program ขาย
- ไม่มี ongoing plan adjustments อัตโนมัติ (v2+ hypothesis)
- ไม่มี auto-macro tracking (แอปแสดง plan ที่ user set — ไม่ใช่ MyFitnessPal)
- ไม่ใช่ social / community / leaderboard
- ไม่รองรับ wearable sync
- ไม่มี ads (freemium ล้วน)
- **ไม่ใช่ medical advice** — มี disclaimer ชัด, ไม่รับ user ที่ระบุ medical
  condition (block or bypass with explicit consent)

## 6. Users and use cases

### Primary — Anyone starting or restructuring fitness routine

- **New user** ไม่มี plan → ตอบ onboarding → รับ plan → ใช้ Today view ทุกวัน
- **Existing user** มี routine อยู่แล้ว → generate จาก AI (เปรียบเทียบ)
  หรือ manual import (Should tier)

### Use frequency

- **Onboarding:** 1 ครั้ง (regenerate ≤ 3 ครั้ง)
- **Daily open:** 2–4 ครั้ง/วัน (เช้า, ก่อนมื้อ, ก่อนเทรน, ก่อนนอน)
- **Weekly re-plan:** 0–1 ครั้ง (deload, เปลี่ยน goal)

## 7. Requirements

Ordered ด้วย **MoSCoW** (fixed-scope, flex-timeline)

### Must — Phase 1 (Validation)

จะใช้ **Wizard-of-Oz approach** — owner generate plan ด้วย ChatGPT manual
เพื่อ validate hypothesis ก่อน invest LLM integration:

- **M1** Onboarding form — 10–12 คำถาม (profile + goal + preferences + medical flag);
  save partial + resume
- **M2** Submission queue — form → owner ดูได้
- **M3** Plan input UI — owner กรอก plan (structured fields สำหรับ workout / meal /
  supplement / cardio / recovery)
- **M4** Save plan → auto-populate weekly schedule
- **M5** **Today view** — เปิดปุ๊บเห็นทุก domain ของวันนี้เรียงตามเวลา
- **M6** Manual edit — user แก้รายวัน/รายสัปดาห์ได้ทุกเมื่อ
- **M7** Safety guardrails:
  - LLM prompt (Phase 2) บังคับ conservative + disclaimer
  - Screen แสดง disclaimer ตอน onboarding + plan review
  - Block medical condition หรือ bypass with explicit consent

### Must — Phase 2 (Full product)

หลัง validate hypothesis จาก Phase 1:

- **P2-M1** LLM integration — replace owner manual step (M3)
- **P2-M2** Review + edit + regenerate UI (cap 3 ครั้ง)
- **P2-M3** Safety guardrails — prompt engineering + blocked keywords
- **P2-M4** LLM cost monitoring + rate limit
- **P2-M5** User auth — email + password / magic link; migrate Phase 1 device data
- **P2-M6** Trial state — 30 วันนับจาก account creation; countdown UI
- **P2-M7** Lock screen — เมื่อ trial หมด → paywall
- **P2-M8** Payment integration — subscription checkout, webhook, cancel flow
- **P2-M9** Grandfathering — Phase 1 F&F cohort → lifetime free

### Should

- Regenerate specific domain (regenerate แค่ meal, workout เดิม)
- Tomorrow view + notification เตือน
- Check-off ต่อ item — เห็น progress ของวัน
- Repeat / duplicate week
- Override รายวัน (ยกเลิก workout, แทน cardio)
- Manual import (existing routine → typing เข้า)

### Could

- Log actual — บันทึกว่าจริง ๆ ทำ/กินไปเท่าไหร่
- History view + streak
- Body weight tracking
- Photo per meal / video per exercise (link)
- Adjust plan based on feedback (v2 hypothesis — ยังไม่ทำ)
- Export CSV / share

### Won't (this release)

- Chat coach, real coach assignment, social sharing
- Wearable sync, auto-macro tracking, ongoing AI adjustments
- Video demos, ads

## 8. Experience

**Platform:** TBD — ดู Q1

### Key flows

**Phase 1 (Wizard-of-Oz):**
1. First open → Onboarding wizard (10–12 คำถาม) → "รอ owner ~24 ชม." → notification เมื่อพร้อม → Today view
2. Daily open → Today view ทันที (glanceable)
3. Owner (behind the scenes): เห็น submission → generate plan ด้วย ChatGPT → กรอกเข้าระบบ

**Phase 2 (Full LLM):**
1. First open → Onboarding → LLM loading (~15–30 วิ) → Plan review → Save → Today view
2. Daily open → Today view
3. Regenerate → confirm (cost warning) → new plan

### States ที่ต้องมี

- Onboarding progress (12 steps)
- LLM loading + tip (Phase 2) / Pending state (Phase 1)
- Plan review (edit inline)
- Empty Today view (rest day, no plan yet)
- Offline mode (cached plan)
- Trial countdown warning (Phase 2)
- Lock screen (Phase 2)

### Core UX principles

- **Glanceable** — เปิดหน้าแรกเห็น "วันนี้" ทันที ไม่ต้อง navigate
- **Trust** — plan ที่ generate ต้องดู professional, มี rationale
- **Fast** — Today view render ≤ 500ms (cached)

**Accessibility:** WCAG 2.1 AA basics
**Locales:** ไทย + อังกฤษ (เริ่ม EN ก่อนก็ได้)

## 9. Non-functional requirements

- **Performance:**
  - Onboarding form: instant navigation
  - LLM generation (Phase 2): ≤ 30 วิ with progress indicator
  - Today view: render ≤ 500ms (cached)
- **Availability:** offline-first สำหรับ Today view
- **Data:**
  - Phase 1: local storage + backend for owner queue
  - Phase 2: local + cloud sync (auth-based)
- **Privacy:**
  - Health data (weight, injuries, dietary) เก็บ local หลัก
  - Phase 2 LLM: profile ส่ง OpenAI/Anthropic — แจ้ง user ชัดใน consent
  - Owner (Phase 1) เห็น profile ของ user — แจ้งใน consent
- **Safety:**
  - Disclaimer ที่ onboarding + plan review + about page
  - Blocked keywords / flags (extreme diet, dangerous supplement dose)
- **Analytics:** onboarding_step_completed, plan_delivered, today_view_opened,
  item_edited / item_added / item_removed, subscription_started (Phase 2),
  regenerate_count (Phase 2) — ไม่ track PII
  (catalog มาตรฐาน + property spec ดู SRS §7.4)

## 10. Business Model

### Freemium — Trial 30d → Subscription

| Tier | Duration | Price | Access |
|---|---|---|---|
| **Trial** | 30 วันนับจาก account creation | ฟรี | Full app |
| **Locked** | หลัง trial | — | Lock ทั้งแอป, เห็นแค่ upgrade CTA + cancel/logout/support |
| **Subscription** | ต่อเนื่อง | TBD (Q8) | Full app + regenerate cap 3/session |

### Trial mechanics

- นับจากวัน account creation (Phase 2)
- ไม่มี grace period หลัง expire — lock ทันที
- Reminder 7 วัน + modal 24 ชม.ก่อนหมด

### Locked state UX

- **User เห็นได้:** upgrade CTA, contact support, sign out, delete account
- **User เห็นไม่ได้:** Today view, plan detail, edit, history
- **Data ยังอยู่** — subscribe เมื่อไหร่ก็ unlock กลับมา

### Grandfathering

- Phase 1 F&F cohort → **lifetime free** (reward สำหรับ validate)

### Cost economics (rough)

- LLM cost / user (onboarding + regen ≤ 3): ~$0.20
- Payment gateway fee: ~3.65% + ฿10 (Omise) / ~2.9% + $0.30 (Stripe)
- ที่ราคา ฿199/เดือน: gross margin ~85–90%
- Break-even: ~1 paying user/เดือน (personal project scale)

## 11. Dependencies and risks

### Dependencies

| Item | Type | Impact if delayed |
|---|---|---|
| Tech stack decision (Q1) | Block all build | High |
| Backend platform (Q2) | Block persistence stories | High |
| Data schema (Q3) | Block plan input + Today view | High |
| ChatGPT prompt playbook (Q5) | Block Phase 1 launch | Medium |
| LLM API selection (Q3 P2) | Block Phase 2 M1 | High (Phase 2 only) |
| Payment gateway (Q9) | Block Phase 2 M8 | High (Phase 2 only) |
| Legal disclaimer copy (Q11) | Block Phase 2 public launch | Medium |

### Risks

| Risk | Prob | Impact | Mitigation |
|---|---|---|---|
| Assumption "ต้องมี AI coach" ไม่ pain จริง | Med | High | Wizard-of-Oz Phase 1 validate; 5–10 interview |
| Plan quality (owner-generated) vary ต่อ user | Med | High | Prompt playbook; peer review 2 plans แรก |
| LLM plan quality ไม่ perceive ดี (Phase 2) | Med | High | 20 test personas manual review ก่อน expose |
| **Safety/liability** — advice ก่อบาดเจ็บ/สุขภาพเสีย | Low | High | Disclaimer + medical flag + conservative prompt |
| LLM cost scale (Phase 2) | Low | Med | Cap regenerate, monitor cost/user |
| Onboarding drop-off (12 คำถาม) | Med | Med | Progressive disclosure, save partial |
| Trial → sub conversion ต่ำ | Med | High | Reminder 7 วัน + modal 24 ชม.; ปรับ pricing |
| Subscription churn สูง | Med | Med | Weekly value reinforcement, plan freshness |

## 12. Rollout

Phases เป็นลำดับ logical — ไม่มี date. จะกำหนด date ใน sprint plan แยก

### Phase 0 — Validation prep
- Owner ทดลอง generate plan ด้วย ChatGPT 3–5 personas — evaluate quality
- Prompt playbook draft
- Legal/disclaimer copy review

### Phase 1 — Wizard-of-Oz launch
- Cohort: Friends & Family (owner-decided, ~5; up to 5–10)
- ทุก plan owner generate ด้วย ChatGPT manual
- Weekly check-in with cohort
- Measure metrics §4
- **Decision gate:** ควรลงทุน LLM integration ต่อไหม?

### Phase 2 — Full product launch
- LLM integration + safety guardrails
- Auth + trial + payment
- Grandfather Phase 1 cohort
- Cohort: expand to broader user base
- **Decision gate:** ควร invest marketing/scale?

### Phase 3+ — Growth
- TBD ตามผล Phase 2

**Rollback:** Feature flag ให้ปิด AI generation ได้ (fallback = manual setup)

## 13. Open questions

| # | Question | Owner |
|---|---|---|
| Q1 | Platform: iOS native / PWA / React Native? | you |
| Q2 | Backend: Firebase / Supabase / custom? | you |
| Q3 | Data schema — รองรับ 5 domain อย่าง flex | you |
| Q4 | "อื่น ๆ" ใน routine ครอบคลุมอะไร (cardio, mobility, sleep, water)? | you |
| Q5 | Validate กับสมาชิกฟิตเนสอื่น (5–10 interview) หรือ personal-only? | you |
| Q6 | Onboarding — 12 คำถามครั้งเดียว vs. progressive? | you |
| Q7 | Template starter (PPL/UL/Full-body) เพื่อลด onboarding friction? | you |
| Q8 | Pricing — monthly เท่าไหร่? (~99/199/299 บาท?) | you |
| Q9 | Payment gateway — Omise / Stripe / IAP? | you |
| Q10 | Refund policy — nothing / 7 days / prorated? | you |
| Q11 | T&C + Privacy — ต้องปรึกษาทนายก่อน public launch ไหม? | you |
| Q12 | Yearly plan discount? (เช่น 2 เดือนฟรีถ้าจ่ายรายปี) | you |
| Q13 | ชื่อ product | you |
| Q14 | LLM (Phase 2): GPT-4o vs. Claude Sonnet vs. local? | you |
| Q15 | Structured output — JSON schema vs. free-text parse? | you |

## 14. Decision log

| Date | Decision | Rationale |
|---|---|---|
| 2026-07-25 | Product = AI-generated fitness plan + Daily reminder | Solves 2 pain: "ไม่รู้จะเริ่ม" + "จำไม่ได้" |
| 2026-07-25 | Primary user = serious lifter ที่มี routine หรืออยากมี | Casual user ไม่มี routine → ไม่ pain |
| 2026-07-25 | Coach = LLM one-shot + user regenerate ≤ 3 | Balance value กับ complexity/cost |
| 2026-07-25 | Coach ครอบคลุม 5 domain (workout + nutrition + supplement + cardio + recovery) | User ต้องการทุกอย่างในที่เดียว |
| 2026-07-25 | ทุกคนเริ่มจาก coach (ไม่ใช่ optional path) | Simplify UX; existing user regenerate/edit ได้ |
| 2026-07-25 | Phase 1 = Wizard-of-Oz (owner manual generate) | Validate hypothesis "AI plan น่าเชื่อถือ" + "Today view มี value" ก่อน invest LLM |
| 2026-07-25 | Business model = freemium trial 30 วัน → subscription | Recurring revenue + low barrier ให้ลองก่อน |
| 2026-07-25 | Payment = Phase 2 (post-validation) | Phase 1 F&F ใช้ฟรี |
| 2026-07-25 | Phase 1 F&F = lifetime free | Reward + goodwill |
| 2026-07-25 | Safety guardrails = Must ตั้งแต่ Phase 1 | Health advice = liability risk |
| 2026-07-25 | Log actual = Could (ไม่ใช่ Must) | Core hypothesis คือ reminder/reference, ไม่ใช่ tracking |
| 2026-07-25 | Manual import = Should (ไม่ใช่ Must) | AI-generated เป็น starting point ได้ |

---

## Judgement calls ที่บันทึกไว้ (overrule ได้)

1. Safety guardrails (M7) = Must — advice สุขภาพผ่าน AI มี liability สูง
2. Regenerate cap 3 ครั้ง — cost guardrail + บังคับ user commit
3. Log actual = Could — core hypothesis คือ reminder ไม่ใช่ tracking
4. Onboarding 10–12 คำถาม — พอที่ LLM generate ดีได้ + user ยังไม่หนี
5. Wizard-of-Oz Phase 1 — validate ก่อน invest LLM (แนะนำอย่างแรง)
6. Grandfather F&F lifetime free — reward + goodwill
7. Refund manual — ประหยัด dev time, volume ต่ำ

---

## References

- **Iteration history:** `PRD-workout-tracker.md` (v1 → v5, การ refine)
- **Stories:** `stories.md` (16 user stories with AC)
- **Requirements catalog:** `REQ.md` (47 requirements + traceability)
- **Work breakdown:** `WBS.md` (deliverable hierarchy, 100% rule)
- **Effort estimates:** `EST.md` (per-WBS estimates with confidence levels)
- **Schedule framework:** `SCH.md` (milestones + owner-fills template)
- **Handover:** `HND.md` (PO/PM → SA package + system context)
- **System requirements:** `SRS.md` (IEEE 830-style, SA phase)

> หมายเหตุ: `sprint-plan.md` และ `sprint-tasks.md` ถูกแทนที่ด้วย WBS+EST+SCH
> (revision 0.3/0.4) — ดู `_archive/`
