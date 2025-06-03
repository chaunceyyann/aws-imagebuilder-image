FROM public.ecr.aws/amazonlinux/amazonlinux:2023

# Install Python 3.13.3
RUN yum -y groupinstall "Development Tools" \
    && yum -y install openssl-devel bzip2-devel libffi-devel wget \
    && wget https://www.python.org/ftp/python/3.13.3/Python-3.13.3.tgz \
    && tar xzf Python-3.13.3.tgz \
    && cd Python-3.13.3 \
    && ./configure --enable-optimizations \
    && make altinstall \
    && cd .. \
    && rm -rf Python-3.13.3* \
    && ln -s /usr/local/bin/python3.13 /usr/bin/python3 \
    && ln -s /usr/local/bin/pip3.13 /usr/bin/pip3

# Install AWS CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm -rf awscliv2.zip aws

# Install PyYAML and argparse for validator
RUN pip3 install --no-cache-dir pyyaml argparse

CMD ["/bin/bash"] 