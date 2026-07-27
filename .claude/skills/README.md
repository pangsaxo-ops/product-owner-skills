# Claude Skills

Skills ที่ติดตั้งไว้ในโปรเจกต์นี้ — Claude Code จะโหลดอัตโนมัติเมื่อคำขอตรงกับ trigger ใน `SKILL.md` ของแต่ละ skill

## Workflow

```
product-owner  →  project-manager  →  systems-analyst  →  (dev / QA)
   WHAT/WHY         WHEN/HOW           HOW (system)
   PRD, stories    Sprint, EST, SCH   SRS, SAD, DDD, API, DB
```

## Skills

### `product-owner/`
กำหนดว่า **จะสร้างอะไรและทำไม** — PRD, epic, user story, acceptance criteria, การจัดลำดับ backlog

- ทริกเกอร์: "write me a spec", "break this feature down", "what should we build first", "is this ready for dev"
- ครอบคลุม: INVEST, Given/When/Then, Definition of Ready, RICE / WSJF / MoSCoW / Kano
- `assets/` — เทมเพลต PRD และ user story
- `references/` — แนวทางการหั่น story และรายละเอียดการจัดลำดับความสำคัญ

### `project-manager/`
วางแผนและส่งมอบงาน — **จะเสร็จเมื่อไหร่และอย่างไร** — sprint planning, estimation, forecasting, timeline, risk, การสื่อสารกับ stakeholder

- ทริกเกอร์: "will we make the deadline", "we're behind", "how many points can we take", "what's blocking us"
- ครอบคลุม: capacity math, PERT / reference class, critical path, recovery playbook, status / escalation templates
- `assets/` — เทมเพลต sprint plan, risk register, status update
- `references/` — estimation & velocity, risk management, stakeholder comms

### `systems-analyst/` 🆕
แปลง requirements เป็น **system design** — SRS, SAD, DDD, API contracts, DB schema, security & deployment architecture

- ทริกเกอร์: "write SRS", "design the API", "what's the data model", "how do we handle auth", "which architecture pattern"
- ครอบคลุม: IEEE 830-style SRS, ATAM quality attributes, architecture patterns (layered/hexagonal/event-driven/modular monolith), API contracts, DB schema, security patterns (auth/authz/encryption), PDPA/GDPR/PCI compliance
- `assets/` — เทมเพลต SRS, SAD, API spec, DB schema
- `references/` — quality attributes, architecture patterns, security patterns

## ขอบเขตของแต่ละ skill

| Skill | Owns question |
|---|---|
| **product-owner** | *อะไร / ทำไม* (WHAT / WHY) |
| **project-manager** | *เมื่อไหร่ / อย่างไรจะเสร็จ* (WHEN / HOW-TO-DELIVER) |
| **systems-analyst** | *ระบบจะออกแบบยังไง* (HOW to build) |

ทั้งสาม skill มี frontmatter ระบุขอบเขตชัดเจน — อ่าน `SKILL.md` ก่อนใช้งาน

## โครงสร้าง

```
.claude/skills/
├── product-owner/
│   ├── SKILL.md
│   ├── assets/           (PRD template, story template)
│   └── references/       (prioritization, story writing)
├── project-manager/
│   ├── SKILL.md
│   ├── assets/           (sprint plan, risk register, status update)
│   └── references/       (estimation, risk management, stakeholder comms)
├── systems-analyst/      ← ใหม่
│   ├── SKILL.md
│   ├── assets/           (SRS, SAD, API spec, DB schema templates)
│   └── references/       (quality attributes, architecture patterns, security patterns)
└── README.md
```

## Workflow ตัวอย่าง

**PO → PM → SA → Dev/QA:**

1. `/product-owner` — เขียน PRD, REQ (via product-owner workflow)
2. `/project-manager` — วาง WBS, EST, SCH
3. `/systems-analyst` — ต่อจาก HND (handover) → SRS → SAD → DDD → API/DB/Sec/Deploy
4. Dev / QA — implement + verify (คนละ role)

**ไฟล์ต้นฉบับ** (`.skill` bundle + สำเนา SKILL.md ของ product-owner + project-manager) เก็บไว้ที่ `../../source/` ของโปรเจกต์
