# 1. Install CUDA (13.0, Change Version yourself if needed)
wget https://developer.download.nvidia.com/compute/cuda/13.0.1/local_installers/cuda_13.0.1_580.82.07_linux.run
sudo sh cuda_13.0.1_580.82.07_linux.run
rm cuda_13.0.1_580.82.07_linux.run

# 2. Install UV
curl -LsSf https://astral.sh/uv/install.sh | sh
source ~/.bashrc

# 3. Install vcpkg
echo 'VCPKG_ROOT="$HOME/vcpkg"' >> ~/.bashrc
echo 'PATH="$VCPKG_ROOT:$PATH"' >> ~/.bashrc
source ~/.bashrc
mkdir -p $VCPKG_ROOT
RUN git clone https://github.com/microsoft/vcpkg.git ${VCPKG_ROOT} && \ 
    cd ${VCPKG_ROOT} && ./bootstrap-vcpkg.sh 
source ~/.bashrc

# 4. Create venv and install pytorch
uv venv -p 3.12
source ./venv/bin/activate
pip install torch