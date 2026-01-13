# syntax=docker/dockerfile:1

# This image expects a pre-built Next.js "standalone" output to exist in the build context
# (i.e. you have already run `npm run build` before building the image).

FROM mcr.microsoft.com/devcontainers/javascript-node:20 AS runner
WORKDIR /app

ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1
ENV PORT=3000

COPY public ./public
# Standalone output includes the server and required node_modules
COPY .next/standalone ./
COPY .next/static ./.next/static

USER node
EXPOSE 3000

CMD ["node", "server.js"]
