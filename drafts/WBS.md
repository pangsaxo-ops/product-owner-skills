# Work Breakdown Structure (WBS) — Daily Fitness Companion (Phase 1)

**Purpose:** Deliverable-oriented hierarchical decomposition ตาม **100% rule**
(children ทั้งหมด รวมกันครอบคลุม parent 100%) — ใช้เป็นฐานของ EST และ SCH

**Position in workflow:** PRD → REQ → **WBS** → EST → SCH
**Source:** REQ.md (requirements catalog)
**Consumed by:** EST.md (per-element estimates), SCH.md (dependency + milestones)

## 1. WBS Numbering Convention

- Level 1: `1.0` — Project
- Level 2: `1.n` — Work Package (7 packages)
- Level 3: `1.n.m` — Deliverable (story)
- Level 4: `1.n.m.k` — Task (implementation unit)

Each element has: **WBS Code · Name · Deliverable · Description · Predecessor · Owner**

---

## 2. Hierarchy Overview

```
1.0 Daily Fitness Companion — Phase 1 MVP (Project)
├── 1.1 Setup (WP0)
├── 1.2 Foundation — Onboarding & Owner Queue (WP1)
├── 1.3 Owner Plan Input (WP2)
├── 1.4 Today View MVP (WP3)
├── 1.5 Today Complete + Edit (WP4)
├── 1.6 Polish + Soft Launch (WP5)
└── 1.7 Full F&F Launch (WP6)
```

---

## 3. WBS Dictionary — Level 2 (Work Packages)

| WBS Code | Name | Deliverable | Predecessor | Owner |
|---|---|---|---|---|
| 1.1 | Setup | Tech chosen, backend running, empty app deployed, prompt playbook | — | Owner |
| 1.2 | Foundation | User submits form → Owner sees queue entry | 1.1 | Owner |
| 1.3 | Owner Plan Input | Owner creates plan for a submission, marks ready, user notified | 1.2 | Owner |
| 1.4 | Today View MVP | User sees today's workout + meals in one glanceable view | 1.3 | Owner |
| 1.5 | Today Complete + Edit | All 5 domains in Today view; user can browse + edit | 1.4 | Owner |
| 1.6 | Polish + Soft Launch | P0 shipped + polished; 1st friend onboarded | 1.5 | Owner |
| 1.7 | Full F&F Launch | Cohort onboarded + metrics collected + Phase 2 decision | 1.6 | Owner |

---

## 4. WBS Dictionary — Full Detail

### 1.1 Setup (WP0)

| WBS | Name | Deliverable |
|---|---|---|
| 1.1.1 | Tech stack decision | Decision doc — native / PWA / RN |
| 1.1.2 | Backend decision | Decision doc — Firebase / Supabase / custom |
| 1.1.3 | Data model schema | ERD + migration file, tested |
| 1.1.4 | Repo + deploy | Repo initialized, deployed empty app, CI green |
| 1.1.5 | Prompt playbook draft | v0.1 playbook + 3 test personas |

**Tasks under 1.1**

| WBS | Task | Predecessor |
|---|---|---|
| 1.1.1.1 | Compare iOS native / PWA / RN across criteria | — |
| 1.1.1.2 | Document decision + rationale | 1.1.1.1 |
| 1.1.2.1 | Compare Firebase / Supabase / custom | — |
| 1.1.2.2 | Document decision | 1.1.2.1 |
| 1.1.3.1 | Design ERD (User → Submission → Plan → Day → Item) | 1.1.2 |
| 1.1.3.2 | Write schema + migration | 1.1.3.1 |
| 1.1.3.3 | Test with mock data | 1.1.3.2 |
| 1.1.4.1 | Repo init + config | 1.1.1 |
| 1.1.4.2 | Deploy pipeline + verify | 1.1.4.1 |
| 1.1.5.1 | Test ChatGPT with 3 personas | — |
| 1.1.5.2 | Draft playbook v0.1 | 1.1.5.1 |

### 1.2 Foundation — Onboarding & Owner Queue (WP1)

| WBS | Name | Deliverable |
|---|---|---|
| 1.2.1 | US-01 Onboarding submission | User submits 12-Q form, saved to backend, owner notified |
| 1.2.2 | US-04 Owner queue view | Owner sees submissions list ordered by pending |
| 1.2.3 | US-16 Disclaimer | Disclaimer text at onboarding intro + About page |

**Tasks under 1.2**

| WBS | Task |
|---|---|
| 1.2.1.1 | Build UI screens for 12 questions |
| 1.2.1.2 | Field validation inline |
| 1.2.1.3 | Backend `POST /submissions` endpoint |
| 1.2.1.4 | Frontend submit integration + loading state |
| 1.2.1.5 | Owner email notification |
| 1.2.1.6 | Pending screen post-submit |
| 1.2.2.1 | Admin route + password protect |
| 1.2.2.2 | Queue list rendering |
| 1.2.2.3 | Sort + status badge |
| 1.2.2.4 | Empty state |
| 1.2.3.1 | Disclaimer copy draft (TH+EN) |
| 1.2.3.2 | Onboarding intro screen |
| 1.2.3.3 | Static About page |

### 1.3 Owner Plan Input (WP2)

| WBS | Name | Deliverable |
|---|---|---|
| 1.3.1 | US-05 Enter workout program | Owner can input day × exercises × sets/reps |
| 1.3.2 | US-06 Enter meals + supp + cardio + recovery | Owner input 4 additional domains |
| 1.3.3 | US-07 Mark ready + notify | Status transition + user email |
| 1.3.4 | US-03 Medical flag block | Onboarding blocks or explicit bypass |

**Tasks under 1.3**

| WBS | Task |
|---|---|
| 1.3.1.1 | Day picker Mon–Sun + rest toggle |
| 1.3.1.2 | Exercise input form |
| 1.3.1.3 | Add/remove/reorder exercises |
| 1.3.1.4 | Auto-save + optimistic UI |
| 1.3.1.5 | Backend `PUT /plans/{id}/workout` |
| 1.3.2.1 | Meal input (mealtime + food + portion + macros) |
| 1.3.2.2 | Supplement input (name + dose + timing) |
| 1.3.2.3 | Cardio input (type + duration + freq) |
| 1.3.2.4 | Recovery input (sleep + rest days) |
| 1.3.2.5 | Backend endpoints for 4 domains |
| 1.3.3.1 | "Mark ready" button + validation |
| 1.3.3.2 | Status transition + timestamp |
| 1.3.3.3 | User email notification |
| 1.3.3.4 | Frontend routing post-ready |
| 1.3.4.1 | Medical condition question in onboarding |
| 1.3.4.2 | Block screen + copy |
| 1.3.4.3 | Bypass with consent flow |
| 1.3.4.4 | Backend flag storage |

### 1.4 Today View MVP (WP3)

| WBS | Name | Deliverable |
|---|---|---|
| 1.4.1 | US-08 Today view workout | Glanceable workout section, offline capable |
| 1.4.2 | US-09 Today view meals | Meals section integrated in Today view |

**Tasks under 1.4**

| WBS | Task |
|---|---|
| 1.4.1.1 | Route + skeleton loader |
| 1.4.1.2 | Fetch today's plan (cache-first) |
| 1.4.1.3 | Day type detection |
| 1.4.1.4 | Workout card component |
| 1.4.1.5 | Offline cache implementation |
| 1.4.1.6 | Analytics events |
| 1.4.1.7 | Typography + polish |
| 1.4.2.1 | Meals card component |
| 1.4.2.2 | Optional macro display |
| 1.4.2.3 | Section ordering by time-of-day |
| 1.4.2.4 | Empty state per meal |
| 1.4.2.5 | Responsive check |

### 1.5 Today Complete + Edit (WP4)

| WBS | Name | Deliverable |
|---|---|---|
| 1.5.1 | US-10 Supp/cardio/recovery cards | Today view has all 5 domains |
| 1.5.2 | US-11 Empty + rest states | Clear state handling |
| 1.5.3 | US-12 Browse days | Week navigator UI |
| 1.5.4 | US-13 Edit item | Modal edit for all item types |
| 1.5.5 | US-14 Add/remove items | User adds/removes items within a day |
| 1.5.6 | US-15 Duplicate week | Copy this week's plan to next week (P2) |

**Tasks under 1.5**

| WBS | Task |
|---|---|
| 1.5.1.1 | Supplement card (sort by timing) |
| 1.5.1.2 | Cardio card |
| 1.5.1.3 | Recovery card |
| 1.5.1.4 | Section ordering integration |
| 1.5.2.1 | Pending state |
| 1.5.2.2 | Rest day state |
| 1.5.2.3 | No plan state |
| 1.5.2.4 | Copy review |
| 1.5.3.1 | Week navigator UI |
| 1.5.3.2 | Selected day state |
| 1.5.3.3 | Last viewed day persistence |
| 1.5.3.4 | Out-of-range handling |
| 1.5.3.5 | Transitions polish |
| 1.5.4.1 | Edit action per item |
| 1.5.4.2 | Edit modal — workout |
| 1.5.4.3 | Edit modal — meal |
| 1.5.4.4 | Edit modal — supp / cardio |
| 1.5.4.5 | Save + optimistic sync |
| 1.5.4.6 | Cancel + unsaved warning |
| 1.5.5.1 | Add-item action + modal (reuse edit modal) |
| 1.5.5.2 | Remove item + confirm dialog |
| 1.5.6.1 | Duplicate week action + backend copy |
| 1.5.6.2 | Overwrite confirm dialog |

### 1.6 Polish + Soft Launch (WP5)

| WBS | Name | Deliverable |
|---|---|---|
| 1.6.1 | US-02 Save partial onboarding | Resume flow works |
| 1.6.2 | OPS Polish + accessibility | Typography, touch, a11y, loading, errors |
| 1.6.3 | 1st user onboarding | 1 friend using product with real plan |

**Tasks under 1.6**

| WBS | Task |
|---|---|
| 1.6.1.1 | localStorage save per step |
| 1.6.1.2 | Restore on next open |
| 1.6.1.3 | 30-day expiration cleanup |
| 1.6.1.4 | Test resume flow |
| 1.6.2.1 | Typography audit |
| 1.6.2.2 | Touch target audit (≥ 44px) |
| 1.6.2.3 | Loading states audit |
| 1.6.2.4 | Error messages audit |
| 1.6.2.5 | VoiceOver labels |
| 1.6.2.6 | Bug backlog cleanup |
| 1.6.3.1 | Owner dogfood period |
| 1.6.3.2 | Select 1st user + consent |
| 1.6.3.3 | Onboard user (watch friction) |
| 1.6.3.4 | Generate + input plan |
| 1.6.3.5 | Follow-up |

### 1.7 Full F&F Launch (WP6)

| WBS | Name | Deliverable |
|---|---|---|
| 1.7.1 | LAUNCH additional users | Cohort onboarded (size = owner-decided) |
| 1.7.2 | OPS bug fix rolling | P0/P1 bugs fixed as reported |
| 1.7.3 | METRICS collection | PRD §4 metrics captured |
| 1.7.4 | RETRO Phase 1 wrap | Report + Phase 2 decision |

**Tasks under 1.7** (per user + rolling)

| WBS | Task |
|---|---|
| 1.7.1.a | Invite + consent (per user) |
| 1.7.1.b | Watch onboarding (per user) |
| 1.7.1.c | Generate + input plan (per user) |
| 1.7.1.d | Deliver + follow-up (per user) |
| 1.7.2.1 | Triage feedback daily |
| 1.7.2.2 | Fix P0 bugs |
| 1.7.2.3 | Fix P1 bugs (buffer) |
| 1.7.3.1 | Query analytics for §4 metrics |
| 1.7.3.2 | Manual timing interviews |
| 1.7.3.3 | Owner effort logging |
| 1.7.3.4 | Compile metric report |
| 1.7.4.1 | Self-retro |
| 1.7.4.2 | Phase 2 go/no-go analysis |
| 1.7.4.3 | Wrap report + recommendation |

---

## 5. 100% Rule Verification

Every parent element's scope = sum of children's scope

| Parent | Children | 100% cover? |
|---|---|---|
| 1.0 Project | 1.1 to 1.7 | ✓ ทุก deliverable ของ Phase 1 |
| 1.1 Setup | 1.1.1 to 1.1.5 | ✓ tech, backend, schema, deploy, playbook |
| 1.2 Foundation | 1.2.1 to 1.2.3 | ✓ submission flow, queue, disclaimer |
| 1.3 Owner Input | 1.3.1 to 1.3.4 | ✓ 5-domain input + ready + safety |
| 1.4 Today MVP | 1.4.1 to 1.4.2 | ✓ workout + meals (core view) |
| 1.5 Today Complete | 1.5.1 to 1.5.6 | ✓ 5 domains + states + browse + edit + add/remove + duplicate |
| 1.6 Polish + Launch | 1.6.1 to 1.6.3 | ✓ save/resume + polish + 1st user |
| 1.7 Full Launch | 1.7.1 to 1.7.4 | ✓ cohort + bugs + metrics + retro |

---

## 6. Change Control

Adding/removing WBS elements requires:
1. Update WBS.md hierarchy
2. Update EST.md estimates (roll-up)
3. Update REQ.md traceability if new requirement
4. Regenerate PDF/DOCX with new revision
