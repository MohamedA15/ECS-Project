# BUILD STAGE
FROM node:20-slim AS builder

# Install only what's needed for building
RUN apt-get update && apt-get install -y \
    python3 \
    make \
    g++ \
    git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/outline

# Only copy the needed files first (better caching)
COPY package.json yarn.lock ./

# Install deps
RUN yarn install --frozen-lockfile

# Copy full source
COPY . .

# Build Outline (produces /build + compiled server)
RUN yarn build



# RUNTIME STAGE

FROM node:20-slim AS runtime

WORKDIR /opt/outline
ENV NODE_ENV=production

# Create non-root user
RUN addgroup --gid 1001 outline && \
    adduser --uid 1001 --ingroup outline outline && \
    mkdir -p /var/lib/outline && \
    chown -R outline:outline /var/lib/outline

# Copy only what is needed
COPY --from=builder /opt/outline/build ./build
COPY --from=builder /opt/outline/server ./server
COPY --from=builder /opt/outline/public ./public
COPY --from=builder /opt/outline/shared ./shared
COPY --from=builder /opt/outline/node_modules ./node_modules
COPY --from=builder /opt/outline/package.json ./package.json
COPY --from=builder /opt/outline/.sequelizerc ./.sequelizerc

ENV FILE_STORAGE_LOCAL_ROOT_DIR=/var/lib/outline/data
RUN mkdir -p "$FILE_STORAGE_LOCAL_ROOT_DIR" && \
    chown -R outline:outline "$FILE_STORAGE_LOCAL_ROOT_DIR" && \
    chmod 1777 "$FILE_STORAGE_LOCAL_ROOT_DIR"

VOLUME /var/lib/outline/data

USER outline

# Health Check

HEALTHCHECK --interval=30s --timeout=5s --retries=5 \
  CMD node -e "const http=require('http');http.get('http://localhost:'+(process.env.PORT||3000)+'/_health',res=>{if(res.statusCode===200)process.exit(0);else process.exit(1)}).on('error',()=>process.exit(1));"

EXPOSE 3000

CMD ["yarn", "start"] 
