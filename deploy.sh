#!/bin/sh

PANDOC_VERSION="3.1.11.1"
curl -L -o pandoc.tar.gz "https://github.com/jgm/pandoc/releases/download/${PANDOC_VERSION}/pandoc-${PANDOC_VERSION}-linux-amd64.tar.gz"
tar -xzf pandoc.tar.gz

export PATH="$PATH:$(pwd)/pandoc-${PANDOC_VERSION}/bin"

curl https://sh.rustup.rs -sSf | sh -s -- -y
export PATH="$HOME/.cargo/bin:$PATH"

git clone --depth 1 https://github.com/pykello/ssg.git
cd ssg
cargo build --release

export PATH="$PATH:$(pwd)/target/release"

cd ..
make -j8
