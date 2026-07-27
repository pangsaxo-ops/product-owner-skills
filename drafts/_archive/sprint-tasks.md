# Task Breakdown — Phase 1

**Source:** stories.md + sprint-plan.md (Work Packages WP0–WP6)
**Format:** Task ID + description + effort estimate + dependency
**Grouping:** By work package (WP0–WP6) — ไม่ผูก sprint/week

> **สำคัญ**: Effort estimates เป็น **work sizing** — เวลาที่งานต้องใช้จริงเมื่อ
> ทำ session เดียว ไม่ใช่ schedule commitment. Owner จัดการ scheduling
> และ resource allocation เอง

## Task ID convention

- `WP{n}.{story}.{seq}` — เช่น `WP1.01.3` = Work Package 1, story US-01, task ที่ 3
- Setup tasks: `WP0.T{seq}`
- Ops/polish (rolling): `WP{n}.OPS.{seq}`
- Launch: `WP{n}.LN.{seq}`
- Metrics: `WP{n}.MT.{seq}`
- Retro: `WP{n}.RT.{seq}`

---

# WP0 · Setup

**Deliverable:** Tech chosen, backend deployed, data model designed, prompt playbook drafted

| ID | Task | Est | Depends |
|---|---|---|---|
| WP0.T1 | เปรียบเทียบ iOS native / PWA / RN → เขียน decision + rationale | 1h | — |
| WP0.T2 | เปรียบเทียบ Firebase / Supabase / custom → เขียน decision | 1h | — |
| WP0.T3 | ออกแบบ ERD: User → Submission → Plan → Day → Item | 0.75h | T2 |
| WP0.T4 | เขียน schema / migration + test mock data | 1h | T3 |
| WP0.T5 | Repo init: package.json, TypeScript, linter, formatter | 0.5h | T1 |
| WP0.T6 | Deploy empty app + verify CI | 1.5h | T5 |
| WP0.T7 | ทดลอง ChatGPT generate plan 3 personas | 0.75h | — |
| WP0.T8 | Draft prompt playbook v0.1 | 0.5h | T7 |

**Total: ~7 ชม.**

### Verification checklist
- [ ] Deployed URL เปิดได้จาก mobile
- [ ] Backend save/read test record ได้
- [ ] ChatGPT generate plan สำเร็จ 3 test personas
- [ ] Decision log มี Q1, Q2 ตอบแล้ว

---

# WP1 · Foundation — Onboarding & Owner Queue

**Deliverable:** User submit form ได้ → Owner เห็น submission ใน queue

## US-01 · Onboarding submission end-to-end

| ID | Task | Est | Depends |
|---|---|---|---|
| WP1.01.1 | UI screens: welcome + 12 คำถาม (goal/level/age/gender/weight/height/days/session/equipment/diet/allergies/dislikes) | 3h | WP0 |
| WP1.01.2 | Field validation inline (required, min/max) | 1h | 1.01.1 |
| WP1.01.3 | Backend API: POST /submissions + persist | 1h | WP0.T4 |
| WP1.01.4 | Frontend integration — submit call + loading state | 1h | 1.01.1, 1.01.3 |
| WP1.01.5 | Owner email notification เมื่อ submission มา | 1h | 1.01.3 |
| WP1.01.6 | "Pending — รอ owner ~24 ชม." screen หลัง submit | 1h | 1.01.4 |

## US-04 · Owner submission queue

| ID | Task | Est | Depends |
|---|---|---|---|
| WP1.04.1 | Admin route + password protect (.env secret) | 0.5h | WP0.T6 |
| WP1.04.2 | Queue list — fetch + render (name/email/submitted_at/status) | 1h | 1.01.3 |
| WP1.04.3 | Sort oldest pending first + status badge | 1h | 1.04.2 |
| WP1.04.4 | Empty state "ยังไม่มี user ใหม่" | 0.5h | 1.04.2 |

## US-16 · Disclaimer

| ID | Task | Est | Depends |
|---|---|---|---|
| WP1.16.1 | Disclaimer copy draft (Thai + EN) | 0.5h | — |
| WP1.16.2 | Onboarding intro screen + "ยอมรับและเริ่ม" | 0.5h | 1.16.1, 1.01.1 |
| WP1.16.3 | Static About page (Terms/Privacy/Disclaimer) | 1h | 1.16.1 |

**Total: ~12.5 ชม.**

### Verification
- [ ] Nan submit form ครบ 12 ข้อ ผ่านมือถือได้
- [ ] Owner เห็น submission ใน queue ภายใน 1 นาที
- [ ] Email notification ถึง owner
- [ ] Disclaimer แสดงตอน onboarding intro

---

# WP2 · Owner Plan Input (5 domains)

**Deliverable:** Owner กรอก plan ครบ 5 domain แล้ว mark ready → notify user

## US-05 · Owner enters workout program

| ID | Task | Est | Depends |
|---|---|---|---|
| WP2.05.1 | Day picker Mon–Sun + rest day toggle | 1h | WP1.04.2 |
| WP2.05.2 | Exercise input form: name / sets / reps / rest / note | 1.5h | 2.05.1 |
| WP2.05.3 | Add / remove / reorder exercises | 1h | 2.05.2 |
| WP2.05.4 | Auto-save (debounced) + optimistic UI | 0.5h | 2.05.3 |
| WP2.05.5 | Backend PUT /plans/{id}/workout | 1h | WP0.T4 |

## US-06 · Meal + supplement + cardio + recovery

| ID | Task | Est | Depends |
|---|---|---|---|
| WP2.06.1 | Meal input: mealtime + food items + portion (+ macros) | 1.5h | 2.05.1 |
| WP2.06.2 | Supplement input: name + dose + timing | 0.5h | 2.05.1 |
| WP2.06.3 | Cardio input: type + duration + frequency | 0.5h | 2.05.1 |
| WP2.06.4 | Recovery input: sleep target + rest days + mobility | 0.5h | 2.05.1 |
| WP2.06.5 | Backend endpoints for 4 domains + save all-at-once | 1h | 2.05.5 |

## US-07 · Mark ready + notify user

| ID | Task | Est | Depends |
|---|---|---|---|
| WP2.07.1 | "Mark as ready" button + validate (workout required) | 0.5h | 2.05.5, 2.06.5 |
| WP2.07.2 | Status transition + timestamp | 0.5h | 2.07.1 |
| WP2.07.3 | User email notification | 0.5h | 2.07.2 |
| WP2.07.4 | User routing: หลัง plan ready → Today view | 0.5h | 2.07.2 |

## US-03 · Medical flag block (safety)

| ID | Task | Est | Depends |
|---|---|---|---|
| WP2.03.1 | คำถามใน onboarding (heart/diabetes/injury/pregnancy) | 0.5h | WP1.01.1 |
| WP2.03.2 | Block screen + copy "แนะนำปรึกษาแพทย์" | 0.5h | 2.03.1 |
| WP2.03.3 | Bypass with explicit consent + flag | 0.5h | 2.03.2 |
| WP2.03.4 | Backend flag storage + owner เห็นใน queue | 0.5h | WP1.04.2 |

**Total: ~13 ชม.**

### Verification
- [ ] Owner กรอก plan ครบ 5 domain แล้ว mark ready ได้
- [ ] User ได้ email แจ้ง plan ready
- [ ] User ที่ระบุ medical condition ถูก block (หรือ bypass with consent)
- [ ] Data persist ครบ (reload → plan ยังอยู่)

---

# WP3 · Today View MVP (⚠️ Risk R2)

**Deliverable:** Nan เปิดแอปเห็น workout + meals ของวันนี้ทันที (< 5 วิ)

## US-08 · Today view — workout section (biggest, ⚠️ timebox)

| ID | Task | Est | Depends |
|---|---|---|---|
| WP3.08.1 | Route setup + skeleton loader | 0.5h | WP0.T6 |
| WP3.08.2 | Fetch today's plan (cache-first) | 1h | WP2.07.4 |
| WP3.08.3 | Day type detection (workout / rest / no plan) | 0.5h | 3.08.2 |
| WP3.08.4 | Workout card component: day + exercises + sets × reps + rest | 2h | 3.08.3 |
| WP3.08.5 | Offline cache — localStorage/IndexedDB + sync | 1.5h | 3.08.2 |
| WP3.08.6 | Analytics: today_view_opened with time_of_day | 0.5h | 3.08.1 |
| WP3.08.7 | Polish — typography, glanceable, big touch targets | 1.5h | 3.08.4 |
| WP3.08.8 | ⚠️ Timebox check — เกิน 8 ชม. → cut polish ไป WP5 | — | ongoing |

## US-09 · Today view — meals section

| ID | Task | Est | Depends |
|---|---|---|---|
| WP3.09.1 | Meals card: mealtime + food + portion | 1.5h | 3.08.4 |
| WP3.09.2 | Optional macro display | 0.5h | 3.09.1 |
| WP3.09.3 | Section ordering ตาม time-of-day | 1h | 3.09.1 |
| WP3.09.4 | Empty state per meal | 0.5h | 3.09.1 |
| WP3.09.5 | Polish + responsive check | 0.5h | — |

**Total: ~12 ชม.**

### Verification
- [ ] Today view render ≤ 500ms
- [ ] Workout + meals แสดงถูก
- [ ] ทำงาน offline ได้ (airplane mode test)

---

# WP4 · Today Complete + Edit

**Deliverable:** Today view ครบ 5 domain; user แก้ item + browse days ได้

## US-10 · Supplements + cardio + recovery in Today view

| ID | Task | Est | Depends |
|---|---|---|---|
| WP4.10.1 | Supplement card — sort ตาม timing | 1h | WP3.08.4 |
| WP4.10.2 | Cardio card — type + duration | 1h | WP3.08.4 |
| WP4.10.3 | Recovery card — sleep target + rest day flag | 0.5h | WP3.08.4 |
| WP4.10.4 | Integrate ordering ทุก section ตาม time-of-day | 0.5h | WP3.09.3 |

## US-11 · Empty + rest-day states

| ID | Task | Est | Depends |
|---|---|---|---|
| WP4.11.1 | Pending state + email support link | 0.5h | WP3.08.3 |
| WP4.11.2 | Rest day state — "พักผ่อน" + meals ยังแสดง | 0.5h | WP3.08.3 |
| WP4.11.3 | No plan state (never onboarded) + CTA | 0.5h | WP3.08.3 |
| WP4.11.4 | Copy review — clear + tone friendly | 0.5h | — |

## US-12 · Browse other days of week

| ID | Task | Est | Depends |
|---|---|---|---|
| WP4.12.1 | Week navigator UI — 7 pills or swipe | 2h | WP3.08.1 |
| WP4.12.2 | State management — selected day + fetch on switch | 0.5h | 4.12.1 |
| WP4.12.3 | Persistence — remember last viewed day | 0.5h | 4.12.2 |
| WP4.12.4 | Handle out-of-range days (future weeks) | 0.5h | 4.12.1 |
| WP4.12.5 | Polish transitions | 0.5h | — |

## US-13 · Edit an item

| ID | Task | Est | Depends |
|---|---|---|---|
| WP4.13.1 | Edit action button per item | 0.5h | WP3.08.4, WP3.09.1 |
| WP4.13.2 | Edit modal — workout item | 1.5h | 4.13.1 |
| WP4.13.3 | Edit modal — meal item | 1h | 4.13.1 |
| WP4.13.4 | Edit modal — supp / cardio | 1h | 4.13.1 |
| WP4.13.5 | Save + optimistic update + backend sync | 0.5h | 4.13.2 |
| WP4.13.6 | Cancel flow + unsaved changes warning | 0.5h | 4.13.2 |

**Total: ~14 ชม.**

### Verification
- [ ] Today view ครบ 5 sections
- [ ] User swipe ระหว่างวันได้
- [ ] User แก้ exercise/meal ผ่าน modal ได้
- [ ] Empty + rest states แสดงถูก

---

# WP5 · Polish + Soft Launch

**Deliverable:** All P0 shipped + tested; onboard 1st user (deep test)

## US-02 · Save partial onboarding (P1)

| ID | Task | Est | Depends |
|---|---|---|---|
| WP5.02.1 | Save state to localStorage ทุก step change | 1h | WP1.01.1 |
| WP5.02.2 | Restore on next open — resume at last step | 1h | 5.02.1 |
| WP5.02.3 | 30-day expiration + auto-cleanup | 0.5h | 5.02.1 |
| WP5.02.4 | Test resume flow (interrupt + reopen ทุกจุด) | 0.5h | 5.02.2 |

## OPS · Bug fix + polish (rolling)

| ID | Task | Est |
|---|---|---|
| WP5.OPS.1 | Typography audit — scale + spacing consistent | 1h |
| WP5.OPS.2 | Touch target audit (≥ 44px) | 0.5h |
| WP5.OPS.3 | Loading states ทุก async action | 1h |
| WP5.OPS.4 | Error message audit — actionable | 0.5h |
| WP5.OPS.5 | VoiceOver labels — form navigate ได้ | 1h |
| WP5.OPS.6 | Bug list จาก WP1–WP4 (buffer) | 2h |

## LAUNCH · 1st user onboarding

| ID | Task | Est |
|---|---|---|
| WP5.LN.1 | Owner dogfood ตัวเอง หลายวัน — บันทึกปัญหา | 0.5h |
| WP5.LN.2 | คัด 1st user + brief consent | 0.5h |
| WP5.LN.3 | Onboard user (watch) + note friction | 0.5h |
| WP5.LN.4 | Generate plan ChatGPT + input เข้าระบบ | 0.5h |
| WP5.LN.5 | Follow-up next day — เขาใช้ Today view ไหม | 0.25h |

**Total: ~12–15 ชม.**

### Verification
- [ ] All P0 stories shipped + tested end-to-end
- [ ] 1st user มี active plan + Today view เปิดใช้ได้
- [ ] Owner effort สำหรับ 1 plan measured (target < 30 นาที)
- [ ] Bug list เหลือ ≤ 5 non-critical

---

# WP6 · Full F&F Launch

**Deliverable:** F&F cohort ครบ + metrics + Phase 2 go/no-go decision

**หมายเหตุ**: จำนวน user ที่ onboard = owner กำหนดตามเวลาที่มี

## LAUNCH · additional users (per user)

| ID | Task | Est / user |
|---|---|---|
| WP6.LN.a | Invite + brief consent (LINE/DM) | 0.15h |
| WP6.LN.b | Watch onboarding + note friction | 0.15h |
| WP6.LN.c | Generate plan (ChatGPT + input) | 0.5h |
| WP6.LN.d | Deliver + follow-up next day | 0.2h |

**Total per user: ~1 ชม.**

## OPS · Bug fix from real feedback

| ID | Task | Est |
|---|---|---|
| WP6.OPS.1 | Triage feedback รายวัน — tag P0/P1/nice | 2h |
| WP6.OPS.2 | Fix P0 bugs (crash, data loss, blocker) | 3h |
| WP6.OPS.3 | Fix P1 bugs ที่ทำได้ (buffer) | 1–2h |

## METRICS · Data collection

| ID | Task | Est |
|---|---|---|
| WP6.MT.1 | Query analytics: onboarding, time-to-plan, today_view_opened, acceptance | 1h |
| WP6.MT.2 | Manual timing: "วันนี้ต้องทำอะไร" (interview) | 0.5h |
| WP6.MT.3 | Owner effort log — timing per plan | — |
| WP6.MT.4 | Compile metric report — actual vs. target (PRD §4) | 1h |

## RETRO · Phase 1 wrap

| ID | Task | Est |
|---|---|---|
| WP6.RT.1 | Self-retro (what worked / didn't / 1 change) | 0.5h |
| WP6.RT.2 | Phase 2 go/no-go analysis — metric ผ่านไหม / hypothesis ใช่ไหม | 1h |
| WP6.RT.3 | Wrap report + Phase 2 recommendation | 1h |

**Total: ~10–13 ชม. base + ~1 ชม./user**

### Definition of Done — Phase 1
- [ ] F&F users active ≥ 5 วัน
- [ ] Metric §4 (PRD) collected: onboarding %, time-to-plan, adherence, owner effort
- [ ] Bug list residual ≤ 3 non-critical
- [ ] Wrap report เขียนเสร็จ
- [ ] Phase 2 decision made (go / iterate / pivot / stop)

---

# Summary — All Work Packages

| WP | Tasks | Est (base) |
|---|---|---|
| WP0 Setup | 8 | ~7 ชม. |
| WP1 Foundation | 13 | ~12.5 ชม. |
| WP2 Owner Plan Input | 18 | ~13 ชม. |
| WP3 Today View MVP | 13 | ~12 ชม. |
| WP4 Today Complete + Edit | 20 | ~14 ชม. |
| WP5 Polish + Soft Launch | 15 | ~12–15 ชม. |
| WP6 Full F&F Launch | 13 base | ~10–13 ชม. + ~1 ชม./user |
| **Total** | **~100 tasks** | **~80–90 ชม. + per-user work** |

**Scheduling, capacity planning, และ resource allocation = owner ตัดสิน**

---

# Cut Priority (ถ้ามี pressure)

เรียงตัดจากบนลง:

1. **F&F cohort size** — ลดจำนวน user (owner effort ลด per WP6.LN)
2. **WP4.13.4** Edit modal supp/cardio (1h)
3. **WP5.02** US-02 Save partial (3h)
4. **WP3.08.7** US-08 polish (1.5h)
5. **WP4.11** US-11 empty states (2h)
6. **WP4.10** US-10 supp/cardio in Today view (3h)
7. **US-15** Duplicate week (stretch)
8. **WP1.16.3** Static About page (1h → external link)
