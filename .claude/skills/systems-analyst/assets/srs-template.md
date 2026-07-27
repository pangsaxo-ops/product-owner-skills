# SRS — [System Name]

**Owner:** [SA name] · **Status:** Draft / In review / Approved · **Version:** [x.y]
**Related docs:** PRD, REQ (upstream) · SAD, DDD, API Spec, DB Schema (downstream)

---

## 1. Introduction

### 1.1 Purpose
One paragraph: what this SRS defines + who reads it.

### 1.2 Scope
Product name, what it does, in-scope and out-of-scope features.

### 1.3 Definitions, Acronyms, Abbreviations
| Term | Meaning |
|---|---|
| | |

### 1.4 References
- PRD [link]
- REQ [link]
- HND [link]

## 2. Overall Description

### 2.1 Product Perspective
Where does this system sit? Standalone / integrated / replacement.

### 2.2 Product Functions
Bullet list of major functions (extends REQ §2 with system-level detail).

### 2.3 User Classes (extends HND §6.2)
| Class | Description | Frequency | Technical expertise |
|---|---|---|---|
| | | | |

### 2.4 Operating Environment (extends HND §6.3)
- Devices: [target]
- OS: [target]
- Network: [conditions]
- Backend infra: [decision]

### 2.5 Constraints
Technical, business, regulatory.

### 2.6 Assumptions and Dependencies
- Assumption 1
- Dependency on external system X

## 3. External Interface Requirements (extends HND §6.1)

### 3.1 User Interfaces
Reference to wireframes / design system.

### 3.2 Hardware Interfaces
If applicable.

### 3.3 Software Interfaces
| # | External System | Direction | Protocol | Data format | Failure handling |
|---|---|---|---|---|---|
| E1 | | | | | |

### 3.4 Communications Interfaces
Protocols, encryption, authentication for each channel.

## 4. System Features (functional requirements — extends REQ §2)

### 4.1 [Feature Name]
- **Traces to:** REQ-F-###
- **Description:** [What the system does]
- **Priority:** P0 / P1 / P2
- **Preconditions:** [System state required]
- **Postconditions:** [System state after]
- **Main flow:** [Normal path]
- **Alternate flows:** [Error, edge cases]
- **Verification:** [How to prove it works]

(Repeat per feature)

## 5. Non-Functional Requirements (extends REQ §3)

### 5.1 Performance
| Metric | Target | Measurement |
|---|---|---|

### 5.2 Availability
| Component | SLA | Recovery time |
|---|---|---|

### 5.3 Security
Reference to Security Architecture doc.

### 5.4 Maintainability
Code standards, documentation requirements, upgrade paths.

### 5.5 Scalability
Load capacity, horizontal scaling approach.

### 5.6 Usability
Accessibility (WCAG), locales, learnability targets.

## 6. Data Requirements

### 6.1 Logical Data Model
Entity list + relationships (details in DDD).

### 6.2 Data Volume (extends HND §6.4)
| Entity | Phase 1 volume | Phase N volume | Retention |
|---|---|---|---|
| | | | |

### 6.3 Data Retention & Deletion
- Retention policy per entity
- Compliance requirements (PDPA/GDPR)

## 7. Other Requirements

Regulatory, legal, localization, i18n details.

## 8. Traceability Matrix

| SRS Item | Source REQ | Test method | Test cases |
|---|---|---|---|
| §4.1 | REQ-F-001 | Integration + E2E | TC-001 |

## 9. Open Questions

| # | Question | Owner | Needed by |
|---|---|---|---|
| | | | |

## 10. Decision Log

| Date | Decision | Rationale | Made by |
|---|---|---|---|
| | | | |
