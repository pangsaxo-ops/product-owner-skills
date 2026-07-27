# Work Plan — Daily Fitness Companion (Phase 1)

**Source:** PRD.md + stories.md
**Approach:** Wizard-of-Oz (owner-in-loop plan generation)
**Team:** Solo (owner)
**Timeline / Schedule:** จัดการโดย owner (ไม่มี assumption ในเอกสารนี้)

> เอกสารนี้เป็น **work breakdown** — บอกว่า *ต้องทำอะไรบ้าง* และ *ทำมาก
> น้อยแค่ไหน* ไม่ได้บอกว่า *เมื่อไหร่* หรือ *กี่ ชม./สัปดาห์* — owner
> จะจัดการทรัพยากร (capacity, timeline, cohort size) เอง
>
> Effort estimates เป็น **work sizing** (เวลาที่งานต้องใช้จริงเมื่อทำ)
> ไม่ใช่ scheduling — ใช้เป็น input ตอนวางแผน ไม่ใช่ commitment

---

## Work Packages Overview

Phase 1 แบ่งเป็น 7 **work packages** เรียงตาม dependency logic
(ต้องทำแพ็คก่อนจึงจะทำแพ็คหลังได้)

| # | Work Package | Goal | Stories | Est. work |
|---|---|---|---|---|
| WP0 | Setup | Tech stack + backend + data model + prompt playbook | (setup tasks) | ~10 ชม. |
| WP1 | Foundation | User ส่ง form → Owner เห็นใน queue | US-01, US-04, US-16 | ~13 ชม. |
| WP2 | Owner Plan Input | Owner กรอก plan ครบ 5 domain + mark ready | US-05, US-06, US-07, US-03 | ~13 ชม. |
| WP3 | Today View MVP | Nan เปิดแอปเห็น workout + meals ของวันนี้ | US-08, US-09 | ~12 ชม. |
| WP4 | Today Complete + Edit | Today view ครบ 5 domain + edit + browse | US-10, US-11, US-12, US-13 | ~14 ชม. |
| WP5 | Polish + Soft Launch | P0 ครบ + onboard user แรก | US-02 + polish + LAUNCH | 12–16 ชม. |
| WP6 | Full F&F Launch | F&F cohort ครบ + metrics + retro | LAUNCH + METRICS + RETRO | 13–16 ชม. |
| | **Total** | | **16 stories** | **~87–94 ชม. + testing** |

**หมายเหตุ**: จำนวน F&F ใน WP5/WP6 = owner กำหนด (แต่ละคน = ~1 ชม.
onboarding + 30 นาที generate plan)

---

## WP0 · Setup

**Goal:** ตัดสิน tech + backend + data model, deploy empty app, prompt playbook

**Deliverables:**
- Tech stack decision (documented)
- Backend platform decision
- Data model schema + migration
- Repo initialized + deployed
- ChatGPT prompt playbook draft (owner ใช้ generate plan)

**Blocks:** WP1 onwards ทั้งหมด (ต้องเสร็จก่อน)

---

## WP1 · Foundation — Onboarding & Owner Queue

**Goal:** User submit form ได้ + Owner เห็น submission

**Committed stories (P0):**
- **US-01** Onboarding submission end-to-end
- **US-04** Owner submission queue view
- **US-16** Disclaimer at key moments (safety)

**Verification:**
- User สามารถ submit form ครบ 12 ข้อ ผ่านมือถือได้
- Owner เห็น submission ใน queue view ภายใน 1 นาที
- Email notification ถึง owner
- Disclaimer แสดงตอน onboarding intro

**Depends on:** WP0 done

---

## WP2 · Owner Plan Input

**Goal:** Owner กรอก plan ครบ 5 domain แล้ว mark ready → notify user

**Committed stories:**
- **US-05** Owner enters workout program (P0)
- **US-06** Owner enters meal + supplement + cardio + recovery (P0)
- **US-07** Mark plan ready + notify user (P0)
- **US-03** Medical flag block (P0 — safety)

**Verification:**
- Owner กรอก plan ครบ 5 domain แล้ว mark ready ได้
- User ได้ email แจ้ง plan ready
- User ที่ระบุ medical condition ถูก block (หรือ bypass with consent)
- Data persist ครบ (reload → plan ยังอยู่)

**Depends on:** WP1 done

---

## WP3 · Today View MVP

**Goal:** Nan เปิดแอปเห็น workout + meals ของวันนี้ทันที

**Committed stories:**
- **US-08** Today view — workout section (P0, largest task — see risk R2)
- **US-09** Today view — meals section (P0)

**Verification:**
- Today view render ≤ 500ms
- Workout + meals แสดงถูก
- ทำงาน offline ได้ (airplane mode test)

**Depends on:** WP2 done (need plan data to display)

**⚠️ Risk R2:** US-08 มี polish/UX polish blow-up risk — recommend timebox
เข้ม ตัด polish ไป WP5 ถ้าเกิน

---

## WP4 · Today Complete + Edit

**Goal:** Today view ครบ 5 domain; user แก้ item + browse ระหว่างวันได้

**Committed stories:**
- **US-10** Supplements + cardio + recovery in Today view (P1)
- **US-11** Empty + rest-day states (P1)
- **US-12** Browse other days of week (P0)
- **US-13** Edit an item (P0)

**Verification:**
- Today view ครบ 5 sections
- User swipe ระหว่างวันได้
- User แก้ exercise/meal ผ่าน modal ได้
- Empty + rest states แสดงถูก

**Depends on:** WP3 done

---

## WP5 · Polish + Soft Launch

**Goal:** All P0 shipped + tested; onboard user แรก (deep test)

**Committed:**
- **US-02** Save partial onboarding (P1)
- Any P1 carryover from WP4
- Bug fix + polish (rolling)
- Onboard 1st friend + generate plan (owner)

**Verification:**
- All P0 stories shipped + tested end-to-end
- 1st user มี active plan + Today view เปิดใช้ได้
- Owner effort สำหรับ 1 plan measured (target < 30 นาที)
- Bug list เหลือ ≤ 5 non-critical

**Depends on:** WP4 done + owner ready to onboard

---

## WP6 · Full F&F Launch

**Goal:** F&F cohort ครบ + metrics ครบ + Phase 2 go/no-go decision

**Committed:**
- Onboard remaining F&F users (จำนวน = owner กำหนด)
- Owner generate plans สำหรับทุก user (~30 นาที/plan)
- Bug fix from real feedback (rolling)
- Metric collection + retro report

**Verification / Definition of Done for Phase 1:**
- F&F users active ≥ 5 วัน
- Metric §4 (PRD) collected: onboarding %, time-to-plan, adherence, owner effort
- Bug list residual ≤ 3 non-critical
- Wrap report เขียนเสร็จ
- Phase 2 decision made (go / iterate / pivot / stop)

**Depends on:** WP5 done + F&F consent ready

---

## Cut Priority — เรียงตัดจากบนลง

ถ้ามี pressure ต้อง cut scope ให้ตัดตามลำดับ:

1. **F&F cohort size** — ลดจำนวน user ที่ onboard (owner effort ลด)
2. **US-15 Duplicate week** — stretch อยู่แล้ว
3. **US-14 Add/remove items** — user มี edit อยู่แล้ว (US-13)
4. **US-02 Save partial onboarding** — user retype ได้ (annoying แต่ทำได้)
5. **S3.08.7 US-08 polish** — ship ugly แล้ว polish ตอนหลัง
6. **US-11 Empty + rest states** — เห็นได้ตอน launch, fix ทีหลัง
7. **US-10 Supp/cardio ใน Today view** — user ดูใน edit ได้
8. **S1.16.3 About page** — link ไป external URL

---

## Risks (product/delivery)

| # | Risk | Mitigation |
|---|---|---|
| R1 | Owner capacity variance (งานหลัก / ป่วย / holiday) | Owner จัดการเอง; cut list พร้อม |
| R2 | US-08 (Today view) polish blow up | Timebox เข้ม; ship "good enough" first |
| R3 | Data schema underdesigned | Design review ก่อน US-05 (WP2) |
| R4 | Backend friction (auth/cost/latency) | POC 2 options ใน WP0 |
| R5 | F&F drop-off — คนไม่ใช้จริง | Onboard คนใกล้ชิดสุดก่อน, weekly check-in |
| R6 | ChatGPT plan quality vary ต่อ user | Prompt playbook + peer review 2 plans แรก |
| R7 | Legal disclaimer ไม่ครอบพอ | ปรึกษาที่ปรึกษา ก่อน Phase 2 public |
| R8 | Scope creep — อยากยัด LLM ก่อน validate | ยึด PRD v5 เข้ม; LLM = Phase 2 |

---

## Assumptions ที่ owner ต้องยืนยัน

เอกสารนี้ไม่ assume:
- ❌ Timeline / duration
- ❌ Capacity per week
- ❌ F&F cohort size
- ❌ Buffer %
- ❌ Sprint duration
- ❌ Weekly cadence

Owner ต้องตัดสินเมื่อพร้อม:
- [ ] Timeline (เมื่อไหร่ Phase 1 ควรจบ?)
- [ ] Capacity (ทำเฉลี่ยกี่ ชม./สัปดาห์?)
- [ ] F&F cohort (จำนวน user? ใครบ้าง?)
- [ ] Sprint length (2 wk / 1 wk / no sprints?)
- [ ] Cadence (สัปดาห์ละครั้ง / รายวัน?)

หลังตัดสินแล้ว → เอกสารนี้จะได้ update พร้อม schedule ที่ตรงจริง
