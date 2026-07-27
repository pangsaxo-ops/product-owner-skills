# Security Patterns — Auth, Authz, Encryption, Compliance

Practical patterns for the common cases. Not a comprehensive security course —
consult a specialist for regulated data (health, finance) at scale.

## 1. Authentication

### 1.1 Password
- **Storage:** bcrypt/argon2 with cost factor ≥ 12
- **Requirements:** minimum length 8 (NIST doesn't require complex chars anymore)
- **Rate limiting:** login attempts (5/min per IP, 10/hour per account)
- **Breach detection:** check against Have I Been Pwned API
- **Reset flow:** signed token, short-lived (15 min), single-use

### 1.2 Magic Link
- Email a signed, short-lived (10–15 min) single-use token
- Better UX than password for casual apps
- Rate limit send frequency (1/min per email)
- **Trade-off:** email is a single point of failure

### 1.3 OAuth / OIDC
- Use for social login (Google, Apple, GitHub)
- Store provider ID + email; never store OAuth token long-term
- Handle account linking (email conflict resolution)
- **Trade-off:** dependency on provider uptime

### 1.4 Multi-Factor (MFA)
- TOTP (Google Authenticator, 1Password) — good default
- SMS — deprecated (SIM swap risk); use only as fallback
- Passkey / WebAuthn — best UX + security if platform supports
- **When to require:** admin accounts, sensitive operations (payment, delete account)

### 1.5 Session Management
- JWT (stateless) or session cookie (stateful) — both fine
- **JWT:** short-lived access token (15 min) + refresh token (7–30 days)
- **Session cookie:** `HttpOnly`, `Secure`, `SameSite=Lax`
- Invalidate on logout, password change, suspicious activity

## 2. Authorization

### 2.1 RBAC (Role-Based Access Control)
- Predefined roles: `admin`, `user`, `guest`
- Each role has permissions
- Simple, easy to reason about
- **Good for:** most apps

### 2.2 ABAC (Attribute-Based Access Control)
- Rules based on user + resource attributes
- E.g., "user can edit if `user.id == resource.owner_id`"
- More flexible, harder to audit
- **Good for:** multi-tenant, resource-scoped permissions

### 2.3 Resource ownership
Most apps need: "user can access their own data."

**Implementation options:**
- Row-level security (PostgreSQL RLS, Firestore rules)
- Application-layer check (every query filters by user_id)
- Both (defense in depth)

**Never rely only on client-side checks.**

## 3. Encryption

### 3.1 In Transit
- **HTTPS everywhere** — no exceptions
- TLS 1.2 minimum, 1.3 preferred
- HSTS header for public sites
- Certificate: Let's Encrypt (free) or managed by hosting platform

### 3.2 At Rest
- **Database:** rely on cloud provider encryption (default in most)
- **Field-level encryption:** for extra-sensitive fields (health data, PII)
  - Use envelope encryption (KMS)
  - Never in application code without proper key mgmt
- **Backups:** encrypted, tested restore

### 3.3 Secrets Management
- **Never in code / git** — use env vars + secret manager
- Rotation policy (quarterly for high-value, yearly minimum)
- Options: cloud KMS (AWS/GCP/Azure), Vault, Doppler, 1Password Secrets

### 3.4 Password Hashing
- **bcrypt** (cost 12+) or **argon2id**
- Never MD5, SHA1, plain SHA256
- Never store plaintext or reversibly encrypted

## 4. Input Validation & Output Encoding

### 4.1 Validate at boundary
- **Never trust client input** — validate at API layer, not just UI
- Use schema validation library (Zod, Joi, Pydantic, etc.)
- Whitelist > blacklist

### 4.2 Prevent injection
- **SQL:** use parameterized queries (never string concat)
- **NoSQL:** use ORM/library methods (avoid raw operators from user input)
- **Command:** avoid `shell=True`, use argument arrays
- **LDAP:** escape special chars

### 4.3 Prevent XSS
- Encode output based on context (HTML / JS / URL / CSS)
- Use framework's built-in escaping (React auto-escapes; Django templates too)
- **Never** trust user-provided HTML — sanitize with allowlist (DOMPurify)

### 4.4 CSRF Protection
- SameSite cookies (modern default)
- CSRF token for state-changing requests (if using cookies)
- Not needed for pure JWT bearer token flows

## 5. Compliance

### 5.1 PDPA (Thailand)
Applies to any personal data of Thai residents.

**Key requirements:**
- **Consent:** explicit, purpose-specific, withdrawable
- **Data minimization:** collect only what's needed
- **Right to access:** user can request their data
- **Right to delete:** hard-delete on request within 30 days
- **Right to rectification:** user can update their data
- **Breach notification:** authorities within 72 hours
- **DPO:** required if data processing is a "core activity"

**Design implications:**
- Consent screen at first launch (log timestamp + version)
- Account deletion flow (cascade + audit trail)
- Export data feature (JSON dump)
- Encrypt PII at rest (health data especially)
- Audit log of access to sensitive data

### 5.2 GDPR (EU users)
Similar to PDPA + stricter in some areas (Data Protection Officer, DPIA).
If not targeting EU users, technically not required, but good practice.

### 5.3 PCI DSS (payment)
**Rule:** Never touch card details in your system.
- Use payment gateway (Stripe, Omise) — they handle PCI
- Only receive tokenized reference back
- If you must touch card data → hire specialist, plan for 6+ months

### 5.4 HIPAA (US health)
Applies if serving US health customers. Not applicable for consumer fitness
app usually — but disclaimer required to avoid it.

## 6. Threat Model

Simple STRIDE at design time:

| Threat | Mitigation |
|---|---|
| **S**poofing | Strong auth, MFA for privileged |
| **T**ampering | Signed requests, HTTPS, integrity checks |
| **R**epudiation | Audit logs, timestamped events |
| **I**nformation disclosure | Encryption, access control, PII masking in logs |
| **D**enial of service | Rate limits, WAF, auto-scale |
| **E**levation of privilege | Least privilege, RBAC audit, separation of duties |

## 7. Monitoring & Response

- **Audit log:** who did what when, immutable
- **Anomaly detection:** login from new location, unusual data access
- **Alerts:** failed auth spike, DB error spike, unusual API pattern
- **Incident response plan:** who to call, how to isolate, how to communicate

## 8. Anti-patterns

- **Security through obscurity** — hidden endpoints, custom crypto
- **Client-side security** — trusting the browser
- **Roll-your-own crypto** — always use vetted libraries
- **Storing tokens in localStorage** for high-value apps (XSS risk)
- **PII in URLs** — GET params logged everywhere
- **Verbose error messages** to unauth users ("user not found" vs "invalid credentials")
- **No rate limiting** — trivially DoS-able
- **Ignoring dependency vulnerabilities** — run `npm audit` / equivalent regularly
