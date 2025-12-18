# Render Deployment Guide

## Backend Root Directory

**Root Directory:** `apps/backend`

This is where your `package.json` and `server.js` are located.

## Render Configuration

### 1. Create New Web Service on Render

1. Go to [Render Dashboard](https://dashboard.render.com)
2. Click **"New +"** → **"Web Service"**
3. Connect your GitHub repository

### 2. Configure Build & Start Commands

**Root Directory:** `apps/backend`

**Build Command:**
```bash
npm install
```

**Start Command:**
```bash
npm start
```

**OR** (if Render doesn't auto-detect):
```bash
node server.js
```

### 3. Environment Variables

Add these in Render's **Environment** section:

```env
NODE_ENV=production
MONGO_URI=mongodb+srv://Ayman:Ayman2004@cluster0.ax0nlid.mongodb.net/mob-pizza?retryWrites=true&w=majority
JWT_SECRET=your-secure-random-string-here-change-this
JWT_EXPIRES_IN=7d
```

**Important Notes:**
- **DO NOT set `PORT`** - Render automatically sets `PORT` environment variable
- Your code already uses `process.env.PORT || 5000`, which will work perfectly
- `MONGO_URI` should be your MongoDB Atlas connection string
- Generate a secure `JWT_SECRET` (you can use: `openssl rand -base64 32`)

### 4. Render Settings Summary

| Setting | Value |
|---------|-------|
| **Name** | `mob-pizza-backend` (or your choice) |
| **Root Directory** | `apps/backend` |
| **Environment** | `Node` |
| **Build Command** | `npm install` |
| **Start Command** | `npm start` |
| **Instance Type** | Free tier (or paid if needed) |

### 5. After Deployment

1. **Get your Render URL:** `https://your-app-name.onrender.com`
2. **Update Mobile App:** Change `API_BASE_URL` to:
   ```env
   API_BASE_URL=https://your-app-name.onrender.com/api/v1
   ```

### 6. Health Check

Test your deployment:
```bash
curl https://your-app-name.onrender.com/api/v1/users/1234567890
```

## Troubleshooting

### Build Fails
- Check that `apps/backend/package.json` exists
- Verify all dependencies are listed
- Check build logs in Render dashboard

### App Won't Start
- Check that `server.js` exists in `apps/backend/`
- Verify `MONGO_URI` is set correctly
- Check Render logs for errors

### MongoDB Connection Issues
- Verify MongoDB Atlas IP whitelist allows all IPs (0.0.0.0/0)
- Check connection string format
- Verify database name in connection string

### Port Issues
- **DO NOT set PORT manually** - Render automatically sets `process.env.PORT`
- Your app already uses `process.env.PORT || 5000` (defaults to 5000 if not set)
- This will work automatically on Render

## Quick Checklist

- [ ] Root directory set to `apps/backend`
- [ ] Build command: `npm install`
- [ ] Start command: `npm start`
- [ ] `MONGO_URI` environment variable added
- [ ] `JWT_SECRET` environment variable added
- [ ] MongoDB Atlas IP whitelist updated
- [ ] Mobile app `API_BASE_URL` updated to Render URL

---

**Ready to deploy!** 🚀

