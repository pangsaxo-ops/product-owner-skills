# API Spec — [System Name] v[x.y]

**Owner:** [SA name] · **Status:** Draft / Approved · **Base URL:** `https://api.example.com`
**Related:** SAD (upstream) · DDD (data model)

---

## 1. Conventions

### 1.1 Versioning
URL-based: `/v1/...` for public. Breaking change → new major version (`/v2`).

### 1.2 Authentication
- Public endpoints: none
- Protected: `Authorization: Bearer <jwt>` header

### 1.3 Content-Type
- Request: `application/json`
- Response: `application/json` (always)
- Encoding: UTF-8

### 1.4 HTTP Status Codes
| Code | Meaning | When |
|---|---|---|
| 200 | OK | Successful GET/PUT |
| 201 | Created | Successful POST |
| 204 | No Content | Successful DELETE |
| 400 | Bad Request | Validation error, malformed JSON |
| 401 | Unauthorized | Missing/invalid auth |
| 403 | Forbidden | Auth OK, permission denied |
| 404 | Not Found | Resource missing |
| 409 | Conflict | State conflict (duplicate, version mismatch) |
| 422 | Unprocessable | Semantic validation failed |
| 429 | Too Many Requests | Rate limited |
| 500 | Internal Error | Server bug |
| 503 | Service Unavailable | Down / degraded |

### 1.5 Error Response Schema
```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Human-readable message",
    "details": { "field": "why" },
    "trace_id": "req-abc123"
  }
}
```

### 1.6 Pagination
Cursor-based: `?cursor=<opaque>&limit=<n>` · Response includes `next_cursor`.

### 1.7 Rate Limiting
Per-user: [N] requests/minute · Response headers: `X-RateLimit-Remaining`,
`X-RateLimit-Reset`.

## 2. Endpoints

### 2.1 [Resource Name]

#### `POST /v1/[resource]`
Create a new [resource].

**Auth:** required (role: user)

**Request:**
```json
{
  "field1": "string, required, max 100",
  "field2": 123,
  "field3": ["array of enum values"]
}
```

**Response (201):**
```json
{
  "id": "uuid",
  "field1": "...",
  "created_at": "ISO 8601"
}
```

**Errors:**
- 400 — validation
- 409 — duplicate

**Rate limit:** N/minute

**Example:**
```bash
curl -X POST https://api.example.com/v1/resource \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"field1": "value"}'
```

---

#### `GET /v1/[resource]/{id}`
[Description]

**Auth:** ...

**Path parameters:**
- `id` — UUID

**Query parameters:**
- `include` — comma-separated related resources (optional)

**Response (200):** [schema]
**Errors:** 401, 403, 404

---

(Repeat per endpoint)

## 3. Webhooks (if applicable)

### 3.1 Event: [event_name]
Triggered when: [condition]

**Payload:**
```json
{
  "event": "resource.created",
  "timestamp": "ISO 8601",
  "data": { ... }
}
```

**Signature verification:** HMAC-SHA256 of body using `WEBHOOK_SECRET`.
Header: `X-Signature: sha256=<hex>`

## 4. Deprecation Policy

- Announce deprecation ≥ 6 months before removal
- Mark endpoints with `Deprecation: true` header
- Provide migration guide to new version
- Never break v1 in place; add v2

## 5. Change Log

| Date | Version | Change | Breaking? |
|---|---|---|---|
| | | | |
