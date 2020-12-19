FROM registry.gitlab.com/datadrivendiscovery/images/libs:ubuntu-bionic-python36-stable

# This assumes "build.sh" cloned the repository.
COPY ./primitives /primitives
COPY ./install-primitives.py /install-primitives.py

# After installing all primitives, we check that the image has consistent dependencies
# using "pip3 check". The goal here is that image building fails if this is not true.
# We remove all /src/*/build directories as a workaround for the pip bug.
# See: https://github.com/pypa/pip/issues/6521
RUN cd / && \
 python3 /install-primitives.py --annotations primitives/primitives && \
 rm -rf /primitives /install-primitives.py && \
 pip3 --disable-pip-version-check check && \
 rm -rf /src/*/build && \
 apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache ~/.npm

ARG org_datadrivendiscovery_public_source_commit
ENV ORG_DATADRIVENDISCOVERY_PUBLIC_SOURCE_COMMIT=$org_datadrivendiscovery_public_source_commit

ARG org_datadrivendiscovery_public_base_digest
ENV ORG_DATADRIVENDISCOVERY_PUBLIC_BASE_DIGEST=$org_datadrivendiscovery_public_base_digest

ARG org_datadrivendiscovery_public_primitives_commit
ENV ORG_DATADRIVENDISCOVERY_PUBLIC_PRIMITIVES_COMMIT=$org_datadrivendiscovery_public_primitives_commit

ARG org_datadrivendiscovery_public_timestamp
ENV ORG_DATADRIVENDISCOVERY_PUBLIC_TIMESTAMP=$org_datadrivendiscovery_public_timestamp
