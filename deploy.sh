#!/bin/sh
set -e

PANDOC_VERSION="3.1.11.1"
GEOMDSL_DIR=".geomdsl"

curl -L -o pandoc.tar.gz "https://github.com/jgm/pandoc/releases/download/${PANDOC_VERSION}/pandoc-${PANDOC_VERSION}-linux-amd64.tar.gz"
tar -xzf pandoc.tar.gz

export PATH="$PATH:$(pwd)/pandoc-${PANDOC_VERSION}/bin"

git clone --depth 1 https://github.com/pykello/geomdsl.git "$GEOMDSL_DIR"
python3 -m pip install --user "$GEOMDSL_DIR"

curl https://sh.rustup.rs -sSf | sh -s -- -y
export PATH="$HOME/.cargo/bin:$PATH"

git clone --depth 1 https://github.com/pykello/ssg.git
cd ssg
cargo build --release

export PATH="$PATH:$(pwd)/target/release"

cd ..

if [ -n "${VIRTQIO_PRIVATE_REPO_URL:-}" ]; then
    echo "Cloning private content repo"
    private_repo_url="$VIRTQIO_PRIVATE_REPO_URL"

    if [ -n "${VIRTQIO_PRIVATE_REPO_TOKEN:-}" ]; then
        case "$private_repo_url" in
            https://github.com/*)
                private_repo_url="https://x-access-token:${VIRTQIO_PRIVATE_REPO_TOKEN}@${private_repo_url#https://}"
                ;;
            *)
                echo "VIRTQIO_PRIVATE_REPO_TOKEN only supports https://github.com/... URLs" >&2
                exit 1
                ;;
        esac
    fi

    if [ -e content/private ]; then
        if [ "${CF_PAGES:-}" = "1" ]; then
            rm -rf content/private
        else
            echo "content/private already exists; remove it before cloning private content" >&2
            exit 1
        fi
    fi

    if [ -n "${VIRTQIO_PRIVATE_REPO_REF:-}" ]; then
        git clone --depth 1 --branch "$VIRTQIO_PRIVATE_REPO_REF" "$private_repo_url" content/private
    else
        git clone --depth 1 "$private_repo_url" content/private
    fi
fi

make -j8
