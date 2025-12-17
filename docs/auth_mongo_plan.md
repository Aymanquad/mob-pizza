# Auth & Identity Plan (MongoDB) for Mob Pizza

## Goals
- Secure, stateless auth (JWT) with refresh tokens.
- Support email/phone login, optional social later.
- Track roles (customer, admin, delivery) and MFA readiness.
- Centralize session/refresh tokens per device for revocation.
- Store minimal PII; encrypt sensitive fields; strong indexing.

## Collections

### users
```jsonc
{
  "_id": ObjectId,
  "email": "a@b.com",          // unique, lowercase
  "phone": "+19998887777",     // E.164, unique (nullable if email-only)
  "passwordHash": "...",       // bcrypt
  "roles": ["customer"],       // enum: customer|admin|delivery
  "status": "active",          // active|disabled|deleted
  "emailVerified": true,
  "phoneVerified": false,
  "address": {
    "street": "123 Main St",
    "city": "Gotham",
    "state": "NY",
    "zip": "10001",
    "country": "US",
    "coords": { "lat": 0, "lng": 0 } // optional
  },
  "mfa": {
    "enabled": false,
    "secret": null,            // for TOTP if enabled
    "backupCodes": []          // hashed codes if used
  },
  "profile": {
    "firstName": "John",
    "lastName": "Doe",
    "avatarUrl": null
  },
  "preferences": {
    "dietary": [],
    "spiceLevel": "mild",
    "allergies": []
  },
  "createdAt": ISODate,
  "updatedAt": ISODate
}
```
**Indexes**
- `{ email: 1 } unique, sparse:false`
- `{ phone: 1 } unique, sparse:true`
- `{ roles: 1 }`
- `{ status: 1 }`
- `{ "address.city": 1, "address.state": 1 }` (optional for analytics)

### auth_sessions
Tracks refresh tokens per device for revocation and anomaly checks.
```jsonc
{
  "_id": ObjectId,
  "userId": ObjectId,
  "deviceId": "uuid-per-device",
  "userAgent": "Android;Pixel;15",
  "ip": "1.2.3.4",
  "refreshTokenHash": "...",   // hash of refresh token
  "createdAt": ISODate,
  "expiresAt": ISODate,
  "revokedAt": ISODate|null
}
```
**Indexes**
- `{ userId: 1, deviceId: 1 } unique`
- `{ refreshTokenHash: 1 }`
- `{ expiresAt: 1 }`

### login_events (audit)
```jsonc
{
  "_id": ObjectId,
  "userId": ObjectId|null,    // null for failed before user resolution
  "email": "a@b.com",
  "phone": "+1999...",
  "status": "success|failure",
  "reason": "bad_password|locked|mfa_failed|ok",
  "ip": "1.2.3.4",
  "userAgent": "Chrome|Android",
  "createdAt": ISODate,
  "geo": { "lat": 0, "lng": 0 } // optional if using IP intel
}
```
**Indexes**
- `{ userId: 1, createdAt: -1 }`
- `{ status: 1, createdAt: -1 }`

### password_resets
```jsonc
{
  "_id": ObjectId,
  "userId": ObjectId,
  "tokenHash": "...",         // hashed reset token
  "expiresAt": ISODate,
  "usedAt": ISODate|null,
  "createdAt": ISODate
}
```
**Indexes**
- `{ userId: 1, expiresAt: 1 }`
- `{ tokenHash: 1 }`

### phone_otps
```jsonc
{
  "_id": ObjectId,
  "phone": "+1999...",
  "codeHash": "...",
  "expiresAt": ISODate,
  "usedAt": ISODate|null,
  "attempts": 0,
  "createdAt": ISODate
}
```
**Indexes**
- `{ phone: 1, expiresAt: 1 }`

## Tokens & Flows
- **Access JWT**: short-lived (10–15 min), contains `sub`, `roles`, `deviceId`.
- **Refresh JWT**: longer-lived (14–30 days), rotated on use; stored hashed in `auth_sessions`.
- On refresh: validate stored hash, rotate token, upsert session with new hash/expiry.
- Logout: revoke session (set `revokedAt`), delete refresh cookie/client.
- MFA (future-ready): TOTP secret stored only if `mfa.enabled`; enforce on login if enabled.

## Passwords & Secrets
- Hash: bcrypt with strong cost (e.g., 12).
- Never store plaintext tokens; store hashes for refresh, reset tokens, OTPs.
- Config in env: `JWT_SECRET`, `JWT_REFRESH_SECRET`, `BCRYPT_SALT_ROUNDS`.
- Enforce password policy at API: min 8 chars, 1 uppercase, 1 digit (match client validation).
- Enforce email lowercase; phone in E.164.

## Validation & Rate Limits
- Per-IP and per-identifier rate limit on login/otp/reset.
- Lockout or step-up (captcha/MFA) after N failed attempts in `login_events`.

## Data Minimization & Privacy
- Store only required PII (email/phone/name).
- Avoid logging raw OTPs/tokens; log status only.
- Support soft-delete by `status: deleted` if needed; keep audit minimal.

## Required APIs (auth scope)
- POST /auth/register (email/phone, password)
- POST /auth/login (email/phone + password)
- POST /auth/refresh (refresh JWT)
- POST /auth/logout (revoke session)
- POST /auth/forgot-password (issue reset token)
- POST /auth/reset-password (consume reset)
- POST /auth/verify-phone (OTP start/verify) — optional
- GET  /auth/me (profile)

## Implementation Notes
- Use Mongoose schemas with required/enum validation; trim/lowercase email.
- Middleware: auth guard (access token), role guard (roles array).
- Clock skew tolerance on JWT (~30s).
- Background cleanup: expire `auth_sessions`, `phone_otps`, `password_resets` via TTL indexes (set `expiresAt` with TTL).

## TTL Indexes
- `auth_sessions.expiresAt` (TTL)
- `password_resets.expiresAt` (TTL)
- `phone_otps.expiresAt` (TTL)

## Ready to Implement
- Create Mongoose models per above.
- Add indexes and TTLs.
- Wire auth controller to use `auth_sessions` for refresh handling.
- Add audit logging to `login_events`.

