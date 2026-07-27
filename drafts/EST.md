# Estimation Document (EST) — Daily Fitness Companion (Phase 1)

**Purpose:** Formal effort estimates ต่อ WBS element พร้อม methodology,
assumptions, และ confidence levels — เพื่อใช้เป็น input ให้ owner
วางแผน schedule (SCH)

**Position in workflow:** PRD → REQ → WBS → **EST** → SCH
**Source:** WBS.md (hierarchy + task list)
**Consumed by:** SCH.md (scheduling framework)

---

## 1. Estimation Methodology

### 1.1 Approach

- **Analogous estimation** — เทียบกับ task ในอดีตของ owner (Web/mobile dev
  ที่คุ้นเคย)
- **Expert judgment** — single estimator (owner) ประเมินตาม experience
- **Bottom-up rollup** — task → deliverable → WP → project

### 1.2 Why not 3-point (PERT)?

- Single estimator → ไม่มี opinion diversity ที่ทำ PERT ให้ meaningful
- Solo project → ไม่มี historical velocity data ให้ Monte Carlo
- Alternative: **confidence levels** (H/M/L) เป็น proxy ของ uncertainty

### 1.3 Confidence Levels

| Level | Meaning | Multiplier for pessimistic (P85) |
|---|---|---|
| **H (High)** | Routine work, well-defined pattern, owner ทำหลายครั้งแล้ว | × 1.1 |
| **M (Medium)** | Some novelty (new lib, new integration) | × 1.3 |
| **L (Low)** | Significant unknowns (new tech, novel UX, external dep) | × 1.6 |

---

## 2. Assumptions

1. Tasks estimated เป็น "focused work" — ไม่รวม context-switching penalty
2. Estimates รวม own testing + basic debug (ไม่ใช่ external QA)
3. Owner familiar กับ tech stack ที่เลือก (ถ้าเลือก new tech → +25% ทั้งหมด)
4. Solo work — ไม่มี coordination / meeting overhead
5. Dependencies ภายนอกไม่ block (backend service, third-party API พร้อม)
6. ChatGPT accessible ตลอดสำหรับ prompt playbook + Wizard-of-Oz
7. Effort estimates ≠ elapsed time (owner จัดการ calendar allocation เอง)

---

## 3. Estimate by WBS Element

### 3.1 Level 2 Roll-up

| WBS | Work Package | Base Est (h) | Confidence | P85 (risk-adj) |
|---|---|---|---|---|
| 1.1 | Setup | 7.0 | M | 9.1 |
| 1.2 | Foundation | 12.5 | H | 13.8 |
| 1.3 | Owner Plan Input | 13.0 | M | 16.9 |
| 1.4 | Today View MVP | 12.0 | L | 19.2 |
| 1.5 | Today Complete + Edit | 20.0 | M | 26.0 |
| 1.6 | Polish + Soft Launch | 12–15 | M | 15.6–19.5 |
| 1.7 | Full F&F Launch | 10–13 + N × 1 | M | 13–17 + N × 1.3 |
| | **Total base** | **86.5 + N** | | **113.6 + N × 1.3** |

**N** = จำนวน F&F user (owner กำหนด — 1 user ≈ 1 ชม. onboarding + generate)

### 3.2 Level 3 & 4 (Task-level detail)

#### WP 1.1 Setup

| WBS | Task | Est (h) | Conf |
|---|---|---|---|
| 1.1.1.1 | Compare tech stack | 0.5 | H |
| 1.1.1.2 | Document decision | 0.5 | H |
| 1.1.2.1 | Compare backend | 0.5 | H |
| 1.1.2.2 | Document decision | 0.5 | H |
| 1.1.3.1 | Design ERD | 0.5 | M |
| 1.1.3.2 | Write schema + migration | 0.75 | M |
| 1.1.3.3 | Test mock data | 0.25 | M |
| 1.1.4.1 | Repo init | 0.5 | H |
| 1.1.4.2 | Deploy pipeline | 1.5 | M |
| 1.1.5.1 | ChatGPT test 3 personas | 0.75 | L |
| 1.1.5.2 | Draft playbook | 0.5 | L |
| **1.1 Total** | | **6.75** ≈ 7.0 | M |

#### WP 1.2 Foundation

| WBS | Task | Est (h) | Conf |
|---|---|---|---|
| 1.2.1.1 | 12-Q UI screens | 3.0 | M |
| 1.2.1.2 | Field validation | 1.0 | H |
| 1.2.1.3 | Backend POST /submissions | 1.0 | H |
| 1.2.1.4 | Submit integration | 1.0 | H |
| 1.2.1.5 | Owner email notification | 1.0 | M |
| 1.2.1.6 | Pending screen | 1.0 | H |
| 1.2.2.1 | Admin route + password | 0.5 | H |
| 1.2.2.2 | Queue list rendering | 1.0 | H |
| 1.2.2.3 | Sort + status badge | 1.0 | H |
| 1.2.2.4 | Empty state | 0.5 | H |
| 1.2.3.1 | Disclaimer copy TH+EN | 0.5 | H |
| 1.2.3.2 | Onboarding intro | 0.5 | H |
| 1.2.3.3 | Static About page | 1.0 | H |
| **1.2 Total** | | **12.5** | H |

#### WP 1.3 Owner Plan Input

| WBS | Task | Est (h) | Conf |
|---|---|---|---|
| 1.3.1.1 | Day picker + rest toggle | 1.0 | H |
| 1.3.1.2 | Exercise input form | 1.5 | M |
| 1.3.1.3 | Add/remove/reorder | 1.0 | M |
| 1.3.1.4 | Auto-save + optimistic UI | 0.5 | M |
| 1.3.1.5 | Backend PUT workout | 1.0 | H |
| 1.3.2.1 | Meal input | 1.5 | M |
| 1.3.2.2 | Supplement input | 0.5 | H |
| 1.3.2.3 | Cardio input | 0.5 | H |
| 1.3.2.4 | Recovery input | 0.5 | H |
| 1.3.2.5 | 4-domain backend | 1.0 | M |
| 1.3.3.1 | Mark ready + validate | 0.5 | H |
| 1.3.3.2 | Status transition | 0.5 | H |
| 1.3.3.3 | User email notify | 0.5 | M |
| 1.3.3.4 | Post-ready routing | 0.5 | M |
| 1.3.4.1 | Medical condition Q | 0.5 | H |
| 1.3.4.2 | Block screen | 0.5 | H |
| 1.3.4.3 | Bypass consent flow | 0.5 | M |
| 1.3.4.4 | Backend flag storage | 0.5 | H |
| **1.3 Total** | | **13.0** | M |

#### WP 1.4 Today View MVP (⚠️ Risk R2)

| WBS | Task | Est (h) | Conf |
|---|---|---|---|
| 1.4.1.1 | Route + skeleton | 0.5 | H |
| 1.4.1.2 | Fetch cache-first | 1.0 | M |
| 1.4.1.3 | Day type detection | 0.5 | M |
| 1.4.1.4 | Workout card | 2.0 | M |
| 1.4.1.5 | Offline cache | 1.5 | L |
| 1.4.1.6 | Analytics events | 0.5 | H |
| 1.4.1.7 | Polish + typography | 1.5 | L |
| 1.4.2.1 | Meals card | 1.5 | M |
| 1.4.2.2 | Optional macro display | 0.5 | H |
| 1.4.2.3 | Section ordering | 1.0 | M |
| 1.4.2.4 | Empty state per meal | 0.5 | H |
| 1.4.2.5 | Responsive check | 0.5 | H |
| **1.4 Total** | | **12.0** | L |

⚠️ **R2**: 1.4.1.4 + 1.4.1.7 (polish + card) มี blow-up risk — recommend timebox

#### WP 1.5 Today Complete + Edit

| WBS | Task | Est (h) | Conf |
|---|---|---|---|
| 1.5.1.1 | Supp card | 1.0 | H |
| 1.5.1.2 | Cardio card | 1.0 | H |
| 1.5.1.3 | Recovery card | 0.5 | H |
| 1.5.1.4 | Section integration | 0.5 | M |
| 1.5.2.1 | Pending state | 0.5 | H |
| 1.5.2.2 | Rest day state | 0.5 | H |
| 1.5.2.3 | No plan state | 0.5 | H |
| 1.5.2.4 | Copy review | 0.5 | H |
| 1.5.3.1 | Week navigator UI | 2.0 | M |
| 1.5.3.2 | Selected day state | 0.5 | H |
| 1.5.3.3 | Persistence | 0.5 | H |
| 1.5.3.4 | Out-of-range | 0.5 | M |
| 1.5.3.5 | Transitions | 0.5 | M |
| 1.5.4.1 | Edit action per item | 0.5 | H |
| 1.5.4.2 | Edit modal — workout | 1.5 | M |
| 1.5.4.3 | Edit modal — meal | 1.0 | M |
| 1.5.4.4 | Edit modal — supp/cardio | 1.0 | M |
| 1.5.4.5 | Save + optimistic sync | 0.5 | M |
| 1.5.4.6 | Cancel + warning | 0.5 | M |
| 1.5.5.1 | Add-item action + modal | 2.0 | M |
| 1.5.5.2 | Remove item + confirm | 1.0 | H |
| 1.5.6.1 | Duplicate week + backend copy | 2.0 | M |
| 1.5.6.2 | Overwrite confirm dialog | 1.0 | H |
| **1.5 Total** | | **20.0** | M |

#### WP 1.6 Polish + Soft Launch

| WBS | Task | Est (h) | Conf |
|---|---|---|---|
| 1.6.1.1 | localStorage save | 1.0 | M |
| 1.6.1.2 | Restore | 1.0 | M |
| 1.6.1.3 | 30-day cleanup | 0.5 | H |
| 1.6.1.4 | Test resume flow | 0.5 | H |
| 1.6.2.1 | Typography audit | 1.0 | M |
| 1.6.2.2 | Touch target audit | 0.5 | H |
| 1.6.2.3 | Loading states | 1.0 | M |
| 1.6.2.4 | Error messages | 0.5 | M |
| 1.6.2.5 | VoiceOver labels | 1.0 | L |
| 1.6.2.6 | Bug backlog buffer | 2.0 | L |
| 1.6.3.1 | Dogfood period | 0.5 | M |
| 1.6.3.2 | Select + consent | 0.5 | M |
| 1.6.3.3 | Onboard 1st user | 0.5 | M |
| 1.6.3.4 | Generate + input plan | 0.5 | M |
| 1.6.3.5 | Follow-up | 0.25 | M |
| **1.6 Total** | | **~11.75–15** | M |

#### WP 1.7 Full F&F Launch

| WBS | Task | Est (h) |
|---|---|---|
| 1.7.1.a | Invite + consent (per user) | 0.15 |
| 1.7.1.b | Watch onboarding (per user) | 0.15 |
| 1.7.1.c | Generate + input plan (per user) | 0.5 |
| 1.7.1.d | Deliver + follow-up (per user) | 0.2 |
| | **Per-user LAUNCH: ~1.0 hr** | |
| 1.7.2.1 | Triage daily | 2.0 |
| 1.7.2.2 | Fix P0 bugs | 3.0 |
| 1.7.2.3 | Fix P1 bugs (buffer) | 1.0–2.0 |
| 1.7.3.1 | Query analytics | 1.0 |
| 1.7.3.2 | Manual timing interviews | 0.5 |
| 1.7.3.3 | Owner effort logging | 0 (rolling) |
| 1.7.3.4 | Compile metric report | 1.0 |
| 1.7.4.1 | Self-retro | 0.5 |
| 1.7.4.2 | Phase 2 analysis | 1.0 |
| 1.7.4.3 | Wrap report | 1.0 |
| | **Fixed 1.7 Total (excl. LAUNCH per user):** | **~11–12** |

---

## 4. Estimate Roll-up

### 4.1 Project Total (Phase 1)

| Metric | Value |
|---|---|
| Base estimate (excl. per-user LAUNCH) | **~86.5 hours** |
| + per user (WP 1.7.1) | + N × 1.0 hour |
| **Total base** for N users | **~86.5 + N** |
| **P85 risk-adjusted** | **~113.6 + N × 1.3** |
| **Example: N=5 users** | Base 91.5 hr · P85 120.1 hr |

### 4.2 By Confidence

- **High confidence** work: ~55% (routine forms, backend endpoints, standard UI)
- **Medium confidence** work: ~35% (integration, edit UI, cross-cutting)
- **Low confidence** work: ~10% (US-08 polish, offline cache, prompt engineering)

---

## 5. Estimate Usage Guidance

### 5.1 What these estimates ARE

- Input for owner's schedule planning
- Basis for scope negotiation (cut list priority)
- Reference for tracking actual vs. planned (velocity learning)

### 5.2 What these estimates are NOT

- ❌ Commitment / promise to stakeholder
- ❌ Elapsed calendar time (task ≠ day)
- ❌ Fixed contract (may adjust as more info surfaces)
- ❌ Assumption of owner's weekly capacity

### 5.3 Recommended re-estimation triggers

- After WP0 (Setup) — recalibrate ทั้งชุดตาม actual velocity
- After WP1 (Foundation) — first user flow shipped
- Before WP4 (Today Complete) — mid-project checkpoint
- Before WP6 (Launch) — final calibration

---

## 6. Change Control

Estimate revisions:
1. Log reason (new info / scope change / tech change)
2. Update EST.md + regenerate
3. Propagate to SCH.md
4. Bump revision in doc control
