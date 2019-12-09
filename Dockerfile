FROM node:12

ENV NODE_ENV production
ENV PORT 9000
ENV THELOUNGE_HOME "/var/opt/thelounge"
VOLUME "${THELOUNGE_HOME}"

# Install thelounge.
ARG THELOUNGE_VERSION=3.3.0
RUN yarn --non-interactive --frozen-lockfile global add thelounge@${THELOUNGE_VERSION} && \
    yarn --non-interactive cache clean
RUN chown node:node ${THELOUNGE_HOME}
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh


USER node:node

# Expose HTTP.
EXPOSE ${PORT}

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["thelounge", "start"]


