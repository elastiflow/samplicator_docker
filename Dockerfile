#------------------------------------------------------------------------------
# Copyright 2021 ElastiFlow Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#------------------------------------------------------------------------------

FROM alpine:3.13.5

ARG BUILD_DATE

LABEL org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.authors="engelastiflow@elastiflow.com" \
      org.opencontainers.image.url="https://github.com/elastiflow/samplicator_docker" \
      org.opencontainers.image.documentation="https://github.com/elastiflow/samplicator_docker/README.md" \
      org.opencontainers.image.source="https://github.com/elastiflow/samplicator_docker" \
      org.opencontainers.image.version="1.0.1_1.3.8rc1" \
      org.opencontainers.image.revision="https://github.com/elastiflow/samplicator_docker/tree/1.0.1_1.3.8rc1" \
      org.opencontainers.image.vendor="ElastiFlow Inc." \
      org.opencontainers.image.title="samplicator" \
      org.opencontainers.image.description="Samplicator can be used to forward UDP packets to multiple destinations."

RUN apk add --update build-base automake autoconf git && \
    git config --global http.sslVerify false && \
    git clone https://github.com/elastiflow/samplicator.git && \
    cd samplicator && \
    git checkout -b 1.3.8rc1 && \
    ./autogen.sh && \
    ./configure && \
    make && \
    make install && \
    cd .. && \
    rm -rf /samplicator && \
    apk del --purge build-base automake autoconf

ENTRYPOINT ["/usr/local/bin/samplicate"]
CMD []
