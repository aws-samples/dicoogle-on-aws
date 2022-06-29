# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do so.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

FROM amazoncorretto:11

RUN yum install shadow-utils wget unzip -y
RUN useradd -u 1001 dicoogle
RUN mkdir -p /opt/dicoogle && \
    chown dicoogle:dicoogle /opt/dicoogle

USER dicoogle 

WORKDIR /opt/dicoogle

RUN wget https://github.com/bioinformatics-ua/dicoogle/releases/download/3.0.2/Dicoogle_v3.0.2.zip && \
    unzip Dicoogle_v3.0.2.zip

COPY settings /opt/dicoogle/Dicoogle_v3.0.2/Plugins/settings
USER root
RUN chown -R dicoogle:dicoogle /opt/dicoogle/Dicoogle_v3.0.2/Plugins/settings

USER dicoogle
RUN mkdir /opt/dicoogle/Dicoogle_v3.0.2/images && \
    mkdir /opt/dicoogle/Dicoogle_v3.0.2/index

WORKDIR /opt/dicoogle/Dicoogle_v3.0.2

ENTRYPOINT ["java","-jar","dicoogle.jar","-s"]
