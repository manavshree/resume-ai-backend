# Render Deployment Guide

This guide explains how to deploy the AI-based Resume Generator project on Render.

## Project Structure

- `resume-ai-backend/` - Spring Boot backend service
- `resume_frontend/` - React frontend application

## Prerequisites

1. A Render account
2. OpenAI API key
3. Git repository with your code

## Environment Variables

### Backend Service
Set these environment variables in your Render backend service:

- `OPENAI_API_KEY` - Your OpenAI API key (required)
- `OPENAI_MODEL` - OpenAI model to use (default: gpt-3.5-turbo)
- `FRONTEND_URL` - Frontend URL for CORS (default: https://resume-frontend.onrender.com)

### Frontend Service
Set these environment variables in your Render frontend service:

- `VITE_API_URL` - Backend API URL (default: https://resume-ai-backend.onrender.com)

## Deployment Steps

### 1. Deploy Backend Service

1. Go to Render Dashboard
2. Click "New" → "Web Service"
3. Connect your Git repository
4. Configure the service:
   - **Name**: `resume-ai-backend`
   - **Environment**: `Docker`
   - **Dockerfile Path**: `./Dockerfile`
   - **Root Directory**: Leave empty (uses project root)
   - **Plan**: Free tier
5. Set environment variables (see above)
6. Click "Create Web Service"

### 2. Deploy Frontend Service

1. In Render Dashboard, click "New" → "Web Service"
2. Connect the same Git repository
3. Configure the service:
   - **Name**: `resume-frontend`
   - **Environment**: `Docker`
   - **Dockerfile Path**: `./resume_frontend/Dockerfile`
   - **Root Directory**: Leave empty (uses project root)
   - **Plan**: Free tier
4. Set environment variables (see above)
5. Click "Create Web Service"

### 3. Update URLs

After both services are deployed:

1. Note the URLs provided by Render for each service
2. Update the `FRONTEND_URL` in your backend service with the actual frontend URL
3. Update the `VITE_API_URL` in your frontend service with the actual backend URL
4. Redeploy both services

## Alternative: Using render.yaml

The project includes a `render.yaml` file that can be used for automatic deployment:

1. Go to Render Dashboard
2. Click "New" → "Blueprint"
3. Connect your Git repository
4. Render will automatically detect and use the `render.yaml` configuration

## Health Checks

The backend service includes health check endpoints:
- Health: `https://your-backend-url.onrender.com/actuator/health`
- Info: `https://your-backend-url.onrender.com/actuator/info`

## Troubleshooting

### Common Issues

1. **CORS Errors**: Ensure `FRONTEND_URL` is set correctly in the backend
2. **API Connection Issues**: Verify `VITE_API_URL` is set correctly in the frontend
3. **OpenAI API Errors**: Check that your `OPENAI_API_KEY` is valid and has sufficient credits
4. **Build Failures**: Check the build logs in Render dashboard for specific error messages

### Logs

Access logs through the Render dashboard:
1. Go to your service
2. Click on the "Logs" tab
3. Monitor for any errors or issues

## Security Notes

- Never commit API keys to your repository
- Use environment variables for all sensitive configuration
- The OpenAI API key is marked as `sync: false` in render.yaml for security

## Free Tier Limitations

- Services may sleep after 15 minutes of inactivity
- Cold starts may take 30-60 seconds
- Limited to 750 hours per month per service
- Consider upgrading to paid plans for production use
