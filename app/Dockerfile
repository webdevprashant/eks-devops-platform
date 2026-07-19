#############################
# Build Stage
#############################

FROM node:22-alpine AS builder

WORKDIR /app

COPY package*.json ./

RUN npm ci

COPY . .

#############################
# Runtime Stage
#############################

FROM node:22-alpine

LABEL maintainer="Prashant Kumar"

WORKDIR /app

ENV NODE_ENV=production
ENV PORT=3000

COPY --from=builder /app .

RUN apk update && apk add curl 
# Create non-root user
RUN addgroup -S appgroup && \
    adduser -S appuser -G appgroup

USER appuser

EXPOSE 3000

HEALTHCHECK --interval=30s \
            --timeout=5s \
            --start-period=20s \
            --retries=3 \
CMD wget --no-verbose --tries=1 --spider http://localhost:3000/health || exit 1

CMD ["npm","start"]