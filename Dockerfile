# Copyright (c) 2016-present Sonatype, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# Modified 05/2020 by CPasternack

FROM centos:centos8 as openjdk-11

RUN yum install -q -y java-11-openjdk-headless.x86_64 \
  openssl

FROM openjdk-11 as nexus3 
LABEL name="Sonatype Nexus3 on CentOS8 openJDK-11" \
      maintainer="(you) <you@your.org.localhost>" \
      version="3.25.0-03" \
      release="latest" \
      url="https://nexus.your.org.localhost" \
      summary="Nexus Repository Manager by \
          Sonatype, packaged for docker." \
      description="Nexus Repository Manager by \
          Sonatype, packaged for docker." \
      run="docker run -d --name NAME \
          -p 8081:8081 \
          IMAGE" \
      stop="docker stop NAME"

COPY ["ansible/", "/ansible/"]

RUN yum install -q -y centos-release-ansible-29.noarch \
    && yum install -q -y ansible
 
RUN cd /ansible \
  && ansible-playbook -vvv playbook.yml \
  && yum remove -q -y ansible

# all other environmental variables are set in ansible configuration
ENV NEXUS_DATA=/nexus-data \
  SONATYPE_DIR=/opt/sonatype 

VOLUME ${NEXUS_DATA}

EXPOSE 8081
USER nexus

ENV INSTALL4J_ADD_VM_PARAMS="-Xms2703m -Xmx2703m -XX:MaxDirectMemorySize=2703m -Djava.util.prefs.userRoot=${NEXUS_DATA}/javaprefs"

CMD ["sh", "-c", "${SONATYPE_DIR}/start-nexus-repository-manager.sh"]

