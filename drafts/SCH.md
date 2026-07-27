# Schedule (SCH) — Daily Fitness Companion (Phase 1)

**Purpose:** Framework สำหรับ scheduling — dependency, milestones, และ template
ที่ owner กรอกเมื่อพร้อมกำหนด calendar. เอกสารนี้**ไม่มี date จริง** —
รอ owner ตัดสิน capacity/timeline

**Position in workflow:** PRD → REQ → WBS → EST → **SCH**
**Source:** WBS.md (structure) + EST.md (effort)
**Consumed by:** (owner's own calendar / task tracker)

---

## 1. Scheduling Approach

### 1.1 Method

- **Milestone-based** — 7 milestones ตาม WBS Level 2 (WP0–WP6)
- **Dependency-driven** — WP ถัดไปเริ่มได้เมื่อ WP ก่อนเสร็จ (linear critical path)
- **Owner-managed capacity** — owner ตัดสินเวลาต่อสัปดาห์เอง
- **Milestone-level tracking** — ไม่ manage daily; แค่ track ว่า WP นี้เสร็จเมื่อไหร่

### 1.2 Why milestone-based (not sprint-based)

- Solo developer + variable capacity → fixed sprints ไม่ align กับ reality
- Personal project → ไม่มี stakeholder ที่ต้องส่ง status รายสัปดาห์
- Milestone-based ทำให้ owner focus ที่ "next deliverable" ไม่ใช่ "next sprint"

---

## 2. Dependency Graph (Critical Path)

Phase 1 มี **linear critical path** — ไม่มี parallel work:

```
[Start] → WP0 → WP1 → WP2 → WP3 → WP4 → WP5 → WP6 → [Phase 1 done]
        (Setup)(Found.)(Owner)(Today)(Complete)(Polish)(Launch)
```

**Reason:** solo dev → ทำงานได้ครั้งละ 1 WP; WP หลังต้องการ output ของ WP ก่อน

**Note:** ใน WP เดียวกัน อาจมีความคู่ขนานได้บ้าง (เช่น 1.2.1 กับ 1.2.3 ทำสลับ
ได้) แต่ระดับ WP → sequential

---

## 3. Milestones (unscheduled)

| ID | Milestone | Completion criteria | Depends on WP |
|---|---|---|---|
| **M0** | Kickoff | Q1 (platform) + Q2 (backend) ตอบแล้ว | (project start) |
| **M-A** | Setup complete | Deployed empty app + prompt playbook draft | WP0 ✓ |
| **M-B** | Foundation live | User submit form → owner เห็นใน queue | WP1 ✓ |
| **M-C** | Owner generates plans | Owner input plan ครบ 5 domain + mark ready | WP2 ✓ |
| **M-D** | Today view usable | User เปิด Today view เห็น workout + meals | WP3 ✓ |
| **M-E** | All P0 shipped | Today view ครบ 5 domain + edit + browse | WP4 ✓ |
| **M-F** | 1st user onboarded | 1 F&F user ได้ plan + active | WP5 ✓ |
| **M-G** | Phase 1 done | Cohort ครบ + metrics + Phase 2 decision | WP6 ✓ |

---

## 4. Schedule Template — Owner Fills

### 4.1 Timeline Input

| Item | Value (owner fills) |
|---|---|
| Project start date | ___________ |
| Weekly capacity (hr/week) | ___________ |
| F&F cohort size | ___________ |
| Buffer % (recommend 15–20%) | ___________ |
| Target Phase 1 end | ___________ |

### 4.2 Milestone Schedule

Owner กรอก forecast date **เป็น range** (best / expected / worst)
per PM best practice ("forecast with ranges, never single dates")

| ID | Milestone | Est effort (h) | Best | Expected | Worst | Actual |
|---|---|---|---|---|---|---|
| M0 | Kickoff | — | | | | |
| M-A | Setup complete | 7 | | | | |
| M-B | Foundation live | 12.5 | | | | |
| M-C | Owner generates plans | 13 | | | | |
| M-D | Today view usable | 12 | | | | |
| M-E | All P0 shipped | 20 | | | | |
| M-F | 1st user onboarded | 12–15 | | | | |
| M-G | Phase 1 done | 10–13 + N × 1 | | | | |

**Formula ช่วยคำนวณ:**
```
Best case (P50):     hours ÷ weekly_capacity           = weeks
Expected (typical):  hours ÷ (weekly_capacity × 0.85)  = weeks (with 15% buffer)
Worst (P85):         hours × 1.3 ÷ (weekly_capacity × 0.80) = weeks (buffered + risk-adj)
```

### 4.3 Milestone Sequence — Cumulative Forecast

หลังกรอก weekly capacity แล้ว owner คำนวณ cumulative:

| ID | Milestone | Cumulative effort | Est weeks from start |
|---|---|---|---|
| M-A | Setup complete | 7 hr | ___________ |
| M-B | Foundation live | 19.5 hr | ___________ |
| M-C | Owner generates plans | 32.5 hr | ___________ |
| M-D | Today view usable | 44.5 hr | ___________ |
| M-E | All P0 shipped | 64.5 hr | ___________ |
| M-F | 1st user onboarded | 76.5–79.5 hr | ___________ |
| M-G | Phase 1 done | 86.5 + N × 1 hr | ___________ |

---

## 5. Cadence Options (Owner Chooses)

| Option | Ceremony | Frequency | Time budget |
|---|---|---|---|
| **A. Milestone-only** | Milestone review + retro | Per WP completion | 0.5–1 hr per milestone |
| **B. Weekly light** | Self-standup (progress + blockers) | Monday morning | 15 min/week |
| **C. Sprint-style** | Sprint plan + retro | Every 2 weeks | 30–60 min per sprint |
| **D. Daily journal** | End-of-day note (what I did / what next) | Daily | 5 min/day |

**Recommended:** A + B (milestone + weekly light) — เพียงพอสำหรับ solo project,
ไม่มี stakeholder ที่ต้อง report

---

## 6. Recovery Playbook (if slipping)

หาก **actual effort ต่อ WP > estimated × 1.3** ให้ evaluate:

### 6.1 Diagnose (before acting)

- **Under-estimated?** → recalibrate remaining WP estimates
- **Scope creep?** → freeze scope; cut per EST §5 cut list
- **Capacity dip?** → adjust target date, communicate expectations to self
- **Blocker (tech/external)?** → identify + resolve or work around

### 6.2 Three Recovery Options

| Option | Trade-off |
|---|---|
| **A. Cut scope** | ตัด P1/P2 stories (US-15, US-14, US-11, US-10, US-02, etc.) ตามลำดับ. Ship on original target |
| **B. Extend time** | ยึด scope + ยอมรับ target date เลื่อน. Rebaseline once, publicly |
| **C. Phase split** | Ship subset now, remainder later. ตัดสินว่า minimum viable subset คืออะไร |

**Owner decides** — ไม่มี stakeholder ให้ escalate ใน personal project

### 6.3 Rebaseline Rules

- **Rebaseline once, honestly** — ไม่ chain slip เรื่อย ๆ
- Document เหตุผลใน EST.md + SCH.md revision history
- Regenerate PDF/DOCX พร้อม note

---

## 7. Tracking Template — Owner Uses

### 7.1 Per-WP Tracking

| WP | Est (h) | Started | Completed | Actual (h) | Variance % | Notes |
|---|---|---|---|---|---|---|
| WP0 Setup | 7 | | | | | |
| WP1 Foundation | 12.5 | | | | | |
| WP2 Owner Input | 13 | | | | | |
| WP3 Today MVP | 12 | | | | | |
| WP4 Today Complete | 20 | | | | | |
| WP5 Polish + Launch | 12–15 | | | | | |
| WP6 Full Launch | 10–13 + N | | | | | |

### 7.2 Velocity Learning

หลัง WP1 (ครั้งแรกที่มี actual data):
- Actual hours ÷ Est hours = velocity ratio
- ถ้า > 1.3 → adjust remaining estimates × ratio
- ถ้า 0.8–1.2 → estimates OK, ทำต่อ
- ถ้า < 0.8 → over-estimated, มี buffer เพิ่ม

---

## 8. Owner Inputs Required (Before Kickoff)

Checklist สำหรับ owner ก่อนเริ่ม project:

- [ ] **Q1 Platform** — iOS native / PWA / React Native
- [ ] **Q2 Backend** — Firebase / Supabase / custom
- [ ] **Start date** — วันที่จะเริ่ม WP0
- [ ] **Weekly capacity** — hr/week ที่จะทำ (average)
- [ ] **F&F cohort** — ใครบ้าง / จำนวน (สำหรับ WP6)
- [ ] **Cadence** — เลือก option A/B/C/D ตาม §5
- [ ] **Communication** — ใครจะรู้ progress (self only / partner / community?)

---

## 9. Change Control

Schedule changes:
1. Log ทุก rebaseline พร้อมเหตุผล (variance, blocker, scope change)
2. Update SCH.md table §4.2 + revision history
3. Regenerate PDF/DOCX
4. Communicate updated target (แม้เป็น personal project — เขียนไว้ให้ตัวเองรู้)
