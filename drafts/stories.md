# Phase 1 User Stories — Daily Fitness Companion

**Source:** `PRD.md` (canonical) · iteration history: `PRD-workout-tracker.md` v1→v5 (Wizard-of-Oz)
**Cohort:** Friends & Family (จำนวน = owner กำหนด) · Timeline TBD (owner-managed, ดู SCH.md) · Solo dev
**Format:** ทุก story ผ่าน INVEST + ตัว AC ครอบ happy + edge อย่างน้อย 1

**Personas ใน stories:**
- **Nan** = new user (friend of owner), ตอบ onboarding, ใช้ Today view รายวัน
- **Owner** = คุณเอง (Wizard-of-Oz coach), generate plan จาก ChatGPT + กรอกเข้าระบบ

**Estimate** = solo dev hours (ไม่รวม testing/polish; ถูกรวมใน sprint budget)

---

## Epic overview

| Musts | Stories | Total estimate |
|---|---|---|
| P1-M1 Onboarding | US-01, US-02, US-03 | 13 ชม. |
| P1-M2 Submission queue | US-04 | 3 ชม. |
| P1-M3 Plan input (owner) | US-05, US-06, US-07 | 11 ชม. |
| P1-M4 + P1-M5 Save + Today view | US-08, US-09, US-10, US-11 | 17 ชม. |
| P1-M6 Manual edit | US-12, US-13, US-14, US-15 | 15 ชม. |
| P1-M7 Disclaimer | US-16 | 2 ชม. |
| **Total story dev** | 16 stories | **61 ชม.** |

> **หมายเหตุ effort:** ตัวเลขข้างบนเป็น story-level rough sizing (รวม US-14/US-15).
> **แหล่งอ้างอิง effort ที่ถือเป็นทางการคือ EST.md** — base ~86.5 ชม. + N×1/user
> (กระจาย testing/setup/polish เข้าไปใน task ระดับ WBS แล้ว ตาม EST assumption #2).
> Timeline/capacity อยู่ใน SCH.md (owner-managed) — ไม่ผูก schedule ที่นี่ ตาม revision 0.3

---

# Epic 1 — Onboarding & Submission (P1-M1 + P1-M2)

**Goal:** user ตอบ 12 คำถาม → submission ไปถึง owner ให้ generate plan ได้

## US-01 · Nan submits onboarding form end-to-end

**Priority:** P0 · **Estimate:** 8 ชม.

**Story**
> As Nan (a first-time user), I want to answer a short questionnaire about my
> fitness goal and situation, so that I can request a personalized plan.

**Context**
เป็นประตูของทั้ง product — ถ้าอันนี้ไม่ work, ทั้ง flow พัง. ครอบคลุมทั้ง UI + backend
save + notify owner ใน slice เดียว

**Acceptance criteria**

```
Given Nan เปิดแอปครั้งแรก
When เธอตอบคำถามครบทั้ง 12 ข้อ (goal, level, age, gender, weight, height,
     days/week, session length, equipment, diet type, allergies, dislikes)
     และกด submit
Then submission ถูกบันทึกใน backend พร้อม timestamp
And owner ได้รับ email notification ว่ามี submission ใหม่
And Nan เห็นหน้า "รอ owner สร้าง plan ให้ ~24 ชม." พร้อม email confirm
```

```
Given Nan ตอบคำถามไม่ครบ (ข้ามข้อบังคับ)
When เธอกด submit
Then กด submit ไม่ได้ / แสดง error inline ที่ข้อที่ขาด
And ไม่มี submission ถูกบันทึก
```

```
Given network fail ตอน submit
When Nan กด submit
Then แสดง error ที่แก้ไขได้ ("ลองใหม่")
And form state ไม่หาย (ไม่ต้องกรอกใหม่)
```

**Non-functional**
- Form navigation: ต้อง swipe/tap ไปข้อถัดไปได้ ≤ 200ms
- Analytics: `onboarding_started`, `onboarding_step_completed` (with step #),
  `onboarding_submitted`
- Accessibility: label ทุกช่อง, error message screen-reader-friendly

**Out of scope**
- Save partial (→ US-02)
- Medical condition handling (→ US-03)
- Login/account (Phase 1 = anonymous device)

**Dependencies**
- Tech stack + backend ต้องพร้อม (Sprint 0)

---

## US-02 · Nan can save partial and resume later

**Priority:** P1 · **Estimate:** 3 ชม.

**Story**
> As Nan (interrupted mid-onboarding), I want the form to remember my answers
> when I close the app, so that I can finish later without re-typing.

**Acceptance criteria**

```
Given Nan ตอบไป 5 ข้อจาก 12 ข้อ
When เธอปิดแอป แล้วเปิดกลับภายใน 30 วัน
Then form กลับมาที่ข้อที่ 6 พร้อมคำตอบ 5 ข้อก่อนหน้ายังอยู่
```

```
Given Nan ทิ้ง form ค้างไว้ > 30 วัน
When เธอเปิดแอปกลับ
Then partial data ถูก discard และเริ่มใหม่ (privacy)
```

**Dependencies:** US-01

---

## US-03 · Onboarding blocks users with medical conditions

**Priority:** P0 (safety) · **Estimate:** 2 ชม.

**Story**
> As Nan (who happens to have a heart condition), I want the app to acknowledge
> my situation and refer me to a professional, so that I don't get plan
> recommendations that could harm me.

**Acceptance criteria**

```
Given Nan ตอบ "ใช่" ในข้อ "มีโรคประจำตัวที่กระทบต่อการออกกำลังกาย?"
     (heart, diabetes, injury, pregnancy)
When เธอกด next
Then form หยุด และแสดงหน้า "แนะนำปรึกษาแพทย์ก่อน" พร้อม disclaimer
And submission ไม่ถูกส่งไป owner
And Nan ยังสามารถ "ข้าม & ยอมรับความเสี่ยง" ได้ (checkbox + explicit consent)
     ถ้าเลือก skip → submission ส่งพร้อม flag "user_bypass_medical_flag"
```

**Non-functional:** disclaimer text ต้องเรียบเรียงกับ owner ก่อน launch (Q11 legal)

**Dependencies:** US-01

---

# Epic 2 — Owner Plan Generation (P1-M2 + P1-M3)

**Goal:** owner เห็น submission → generate plan ด้วย ChatGPT → กรอกเข้าระบบ →
mark ready

## US-04 · Owner views submission queue

**Priority:** P0 · **Estimate:** 3 ชม.

**Story**
> As Owner, I want to see a list of user submissions with their status, so that
> I know who needs a plan and how long they've been waiting.

**Acceptance criteria**

```
Given มี user 3 คนที่ submit form (2 ยังไม่มี plan, 1 plan ready แล้ว)
When Owner เปิด admin queue
Then เห็น list ทั้ง 3 คน พร้อม name, email, submitted_at, status
     (pending / plan_ready / delivered)
And เรียงตาม oldest pending first
```

```
Given ยังไม่มี submission เลย
When Owner เปิด queue
Then เห็น empty state "ยังไม่มี user ใหม่"
```

**Non-functional:** owner-only route — password protect หรือ hidden URL

**Dependencies:** US-01

---

## US-05 · Owner enters workout program for a submission

**Priority:** P0 · **Estimate:** 5 ชม.

**Story**
> As Owner, I want to enter a weekly workout program (day × exercises ×
> sets/reps/notes) for a user, so that their weekly schedule gets populated.

**Acceptance criteria**

```
Given Owner เปิด submission ของ Nan
When Owner เพิ่ม "Monday = Push Day" พร้อม 5 exercises แต่ละอันมี name +
     sets + reps + rest + optional note
Then ข้อมูลถูกบันทึกใน backend เชื่อมกับ user
```

```
Given Owner เพิ่ม 3 exercises แล้วปิดหน้า
When Owner เปิด plan อันเดิมกลับ
Then 3 exercises ยังอยู่ (auto-save)
```

```
Given Owner ต้องการ mark Sunday เป็น "rest day"
When Owner เลือก day type = rest
Then day นั้นไม่ต้องมี exercises
```

**Non-functional:** structured input (ไม่ใช่ free text) เพื่อให้ Today view render ได้ถูก

**Dependencies:** US-04

---

## US-06 · Owner enters meal + supplement + cardio + recovery

**Priority:** P0 · **Estimate:** 4 ชม.

**Story**
> As Owner, I want to enter meal plan, supplement schedule, cardio, and
> recovery targets alongside the workout, so that Today view is complete
> across all 5 domains.

**Acceptance criteria**

```
Given Owner เปิด plan ของ Nan
When Owner เพิ่ม meals ต่อวัน (breakfast/lunch/dinner + food items + portion +
     macros optional) + supplements (name + dose + timing) + cardio (type +
     duration + frequency) + recovery (sleep target + rest day count)
Then ข้อมูลถูกบันทึกแยกตาม domain
```

```
Given Owner ไม่ได้ใส่ meal สำหรับวันหนึ่ง
When user เปิด Today view วันนั้น
Then section meal แสดง "ยังไม่ระบุ" (ไม่ error)
```

**Dependencies:** US-05

---

## US-07 · Owner marks plan ready → Nan gets notified

**Priority:** P0 · **Estimate:** 2 ชม.

**Story**
> As Owner, I want to mark a plan as ready when I've finished entering all
> domains, so that the user is notified and can start using it.

**Acceptance criteria**

```
Given Owner กรอก workout + meals + supplement + cardio + recovery ครบแล้ว
When Owner กด "Mark as ready"
Then submission status เปลี่ยนเป็น "plan_ready"
And Nan ได้ email แจ้ง "plan พร้อมแล้ว เปิดแอปดูได้เลย"
And ครั้งต่อไป Nan เปิดแอป → เจอ Today view (ไม่ใช่ waiting screen)
```

```
Given Owner ยังไม่กรอก workout
When Owner กด "Mark as ready"
Then กดไม่ได้ / แสดง warning "ยังขาด workout"
```

**Dependencies:** US-05, US-06

---

# Epic 3 — Today View (P1-M4 + P1-M5)

**Goal:** user เปิดแอป → เห็นทุกอย่างของวันนี้ในหน้าเดียว < 5 วินาที

## US-08 · Nan sees today's workout as the main card

**Priority:** P0 · **Estimate:** 8 ชม.

**Story**
> As Nan (on a workout day), I want to open the app and immediately see today's
> workout with exercises, sets, and reps, so that I know what to do at the
> gym without hunting.

**Context**
Vertical slice แรกของ Today view — deliver workout only ก่อน; sections อื่นเพิ่มทีหลัง

**Acceptance criteria**

```
Given Nan มี plan ที่ owner mark ready แล้ว
And วันนี้เป็นวัน workout (Monday = Push)
When Nan เปิดแอป
Then หน้าแรกแสดง workout ของวันนี้ทันที (ไม่ใช่ splash + navigate):
     ชื่อวัน (Push Day) + list exercises + sets × reps + rest per exercise
```

```
Given Nan เปิดแอปไม่มี network
When หน้าโหลด
Then Today view ยัง render ได้จาก local cache
```

```
Given render Today view
Then p95 ≤ 500ms บน mid-tier phone
```

**Non-functional**
- Glanceable — text ใหญ่พออ่านจากระยะแขนขวาถือดัมเบล
- Analytics: `today_view_opened` with `time_of_day`

**Dependencies:** US-07

---

## US-09 · Today view shows today's meals

**Priority:** P0 · **Estimate:** 4 ชม.

**Story**
> As Nan (planning her day), I want to see today's meals with portions in the
> same view as the workout, so that I don't need to switch to another screen.

**Acceptance criteria**

```
Given Nan มี plan + วันนี้มี meals กำหนดไว้
When Nan เปิด Today view
Then เห็น meals section ใต้ workout: breakfast / lunch / dinner
     พร้อม food items + portions
```

```
Given meal บางมื้อไม่มี macro info
When section render
Then แสดงแค่ food + portion (ไม่มี blank macro row)
```

**Dependencies:** US-08, US-06

---

## US-10 · Today view shows supplements, cardio, recovery

**Priority:** P1 · **Estimate:** 3 ชม.

**Story**
> As Nan, I want to see today's supplements (with timing), cardio, and
> recovery targets in the same view, so that I have everything in one glance.

**Acceptance criteria**

```
Given Nan มี plan
When Nan เปิด Today view
Then supplements section แสดง items เรียงตาม timing (pre-workout / with meal /
     before sleep)
And cardio section แสดง type + duration ถ้ามี
And recovery section แสดง sleep target + "rest day" หรือไม่
```

**Dependencies:** US-08

---

## US-11 · Today view empty & rest-day states

**Priority:** P1 · **Estimate:** 2 ชม.

**Story**
> As Nan (on a rest day / before plan is ready), I want a clear empty or
> rest state, so that I don't wonder if the app is broken.

**Acceptance criteria**

```
Given Nan submit form แต่ owner ยังไม่ mark ready
When Nan เปิดแอป
Then เห็น "รอ owner สร้าง plan ให้ ~24 ชม." พร้อม email support
```

```
Given วันนี้ owner mark เป็น rest day
When Nan เปิด Today view
Then เห็น "Rest day — พักผ่อน กินตาม maintenance"
And meals ยัง show ถ้าระบุไว้; workout section หายไป
```

**Dependencies:** US-08

---

# Epic 4 — Manual Edit (P1-M6)

**Goal:** user แก้ plan ที่ owner สร้างได้ (เพราะไม่มี LLM regenerate ใน Phase 1)

## US-12 · Nan browses other days of the week

**Priority:** P0 · **Estimate:** 4 ชม.

**Story**
> As Nan (planning tomorrow's meal prep), I want to swipe or tap through other
> days of the week, so that I can see what's coming up without waiting for
> the day to arrive.

**Acceptance criteria**

```
Given Nan อยู่ที่ Today view (Wednesday)
When เธอ swipe ซ้ายหรือกด "Thursday"
Then view เปลี่ยนแสดง Thursday's workout + meals + etc.
```

```
Given Nan เลือกวันในอนาคตที่ไม่มีข้อมูล (rest day)
When view render
Then แสดง state ที่ตรง (rest day / empty)
```

**Non-functional:** date picker header persistent ที่ด้านบน

**Dependencies:** US-08

---

## US-13 · Nan edits an item in her plan

**Priority:** P0 · **Estimate:** 5 ชม.

**Story**
> As Nan (who wants to swap dumbbell press for barbell), I want to edit an
> exercise's name/sets/reps in-place, so that the plan matches what I actually
> want to do.

**Acceptance criteria**

```
Given Nan เปิด Today view
When Nan tap exercise แล้วเลือก "แก้ไข"
Then modal / inline edit เปิด พร้อม name + sets + reps + rest editable
And กด save → item updated + Today view refresh
```

```
Given Nan tap meal item
When Nan แก้ portion จาก "150g" เป็น "200g"
Then saved + display update
```

```
Given Nan tap "cancel" ระหว่างแก้
Then ไม่มี change ถูก save
```

**Non-functional:** edits ทำ optimistic UI (แสดงทันที, sync backend)

**Dependencies:** US-08, US-09

---

## US-14 · Nan adds and removes items in a day

**Priority:** P1 · **Estimate:** 3 ชม.

**Story**
> As Nan (who wants to add face pulls after her main exercises), I want to add
> or remove items from a day, so that I can customize beyond the owner's plan.

**Acceptance criteria**

```
Given Nan อยู่ที่ Wednesday workout
When Nan กด "+ เพิ่ม exercise" ที่ท้าย list
Then modal เปิดให้กรอก name/sets/reps → save → item ต่อท้าย list
```

```
Given Nan tap exercise → เลือก "ลบ"
Then confirm dialog ("ลบ Bench Press?") → confirm → item หายไป
```

**Dependencies:** US-13

---

## US-15 · Nan duplicates this week's plan to next week

**Priority:** P2 · **Estimate:** 3 ชม.

**Story**
> As Nan (following the same program next week), I want to copy this week's
> plan to next week, so that I don't need to wait for owner to regenerate.

**Acceptance criteria**

```
Given Nan มี plan สำหรับสัปดาห์นี้ครบ
When Nan กด "Duplicate this week"
Then สัปดาห์ถัดไป (Mon–Sun) มี plan เดียวกันเป็น starting point
And Nan แก้อะไรใน week ใหม่ ไม่กระทบ week เดิม
```

```
Given Nan มี plan อยู่แล้วในสัปดาห์ถัดไป
When Nan กด "Duplicate"
Then confirm dialog เตือน "จะเขียนทับ plan เดิม" ก่อน confirm
```

**Dependencies:** US-12, US-13, US-14

---

# Epic 5 — Safety & Legal (P1-M7)

## US-16 · Disclaimer appears at key moments

**Priority:** P0 (safety) · **Estimate:** 2 ชม.

**Story**
> As Nan, I want to see a clear disclaimer explaining this isn't medical advice
> at the right moments (onboarding, plan review, first launch), so that I
> understand the app's limits and my own responsibility.

**Acceptance criteria**

```
Given Nan เปิดแอปครั้งแรก
When splash / onboarding intro screen
Then disclaimer แสดง ("ไม่ใช่คำแนะนำทางการแพทย์ — โปรดปรึกษาแพทย์ถ้ามีเงื่อนไข
     ทางสุขภาพ") + link "อ่านเพิ่ม"
And ปุ่ม "ยอมรับและเริ่ม"
```

```
Given Nan รับ plan ครั้งแรก (Today view เปิดครั้งแรกหลัง plan ready)
When view โหลด
Then banner disclaimer ปรากฏด้านบน (ปิดได้ครั้งเดียว, save state)
```

```
Given Nan เปิดหน้า setting → about
Then มี link "Terms" + "Privacy" + "Disclaimer" (Phase 1 = simple static page)
```

**Non-functional:** copy ต้องปรึกษาที่ปรึกษาก่อน public launch (Q11)

**Dependencies:** US-01, US-08

---

# Definition of Ready — checked

ทุก story ผ่านเกณฑ์ 7 ข้อของ DoR:

- [x] Problem + user ระบุชัด (persona = Nan / Owner)
- [x] AC มี unhappy path อย่างน้อย 1 อัน
- [x] Design — Phase 1 ใช้ pattern พื้นฐาน (list, card, modal), ยังไม่มี
      dedicated design (Q1 platform)
- [x] Dependencies ระบุใน bottom ของแต่ละ story
- [x] Non-functional ระบุที่จำเป็น (perf, accessibility, analytics)
- [x] Measurement — เชื่อมกับ metric §4 ของ PRD
- [x] Estimate — hours โดย owner (คนเดียว)

**Open items ที่ยังต้องปิด (ก่อน Sprint 1 เริ่ม):**
- Q1 Platform (iOS native / PWA / RN) — blocks setup
- Q2 Backend (Firebase / Supabase / custom) — blocks US-01
- Q3 Data model schema — blocks US-05, US-06
- Q11 Legal copy for disclaimer — blocks US-16 launch

---

# Priority summary

| Priority | Stories | Rationale |
|---|---|---|
| **P0 (Must ship)** | US-01, US-03, US-04, US-05, US-06, US-07, US-08, US-09, US-12, US-13, US-16 | Core flow + safety |
| **P1 (Should ship)** | US-02, US-10, US-11, US-14 | Nice UX; ตัดได้ถ้า slip |
| **P2 (Could ship)** | US-15 | Duplicate week — user แก้เองก็ได้ |

**ถ้าต้อง cut ใน sprint แต่ละครั้ง เรียงตัดจากล่างขึ้น:** US-15 → US-14 → US-11 → US-10 → US-02
