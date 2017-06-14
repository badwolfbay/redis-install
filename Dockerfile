# Copyright 2016 The Kubernetes Authors All rights reserved.
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

# TODO: get rid of bash dependency and switch to plain busybox.
# The tar in busybox also doesn't seem to understand compression.
FROM alpine:3.4
MAINTAINER Prashanth.B <beeps@google.com>

# TODO: just use standard redis when there is one for 3.2.0.
RUN apk -U add curl make gcc sed bash musl-dev linux-headers \
  && rm -rf /var/cache/apk/*

# See contrib/pets/peer-finder for details
RUN curl -sSL -o /peer-finder https://storage.googleapis.com/kubernetes-release/pets/peer-finder

COPY on-start.sh /
COPY install.sh /

RUN chmod -c 755 /install.sh /on-start.sh /peer-finder
Entrypoint ["/install.sh"]