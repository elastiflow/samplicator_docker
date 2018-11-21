#------------------------------------------------------------------------------
# Portions of this file are Copyright (C)2018 Robert Cowart
# 
# Portions of this file are subject to the Robert Cowart Public License (the
# "License") and may not be used or distributed except in compliance with the
# License. You may obtain a copy of the License at:
# 
# http://www.koiossian.com/public/robert_cowart_public_license.txt
# 
# Software distributed under the License is distributed on an "AS IS" basis,
# WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
# the specific language governing rights and limitations under the License.
# 
# The Original Source Code was developed by Robert Cowart. Portions created by
# Robert Cowart are Copyright (C)2018 Robert Cowart. All Rights Reserved.
#------------------------------------------------------------------------------

FROM alpine:3.8

ARG BUILD_DATE

LABEL org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.authors="rob@koiossian.com" \
      org.opencontainers.image.url="https://github.com/robcowart/samplicator_docker" \
      org.opencontainers.image.documentation="https://github.com/robcowart/samplicator_docker/README.md" \
      org.opencontainers.image.source="https://github.com/robcowart/samplicator_docker" \
      org.opencontainers.image.version="1.0.0_1.3.8rc1" \
      org.opencontainers.image.revision="https://github.com/robcowart/samplicator_docker/tree/1.0.0_1.3.8rc1" \
      org.opencontainers.image.vendor="Robert Cowart" \
      org.opencontainers.image.title="samplicator" \
      org.opencontainers.image.description=""

RUN apk add --update build-base automake autoconf git && \
    git config --global http.sslVerify false && \
    git clone https://github.com/sleinen/samplicator.git && \
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
