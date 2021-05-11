#
#
#
#
# Python 3.9	Miniconda3 Linux 64-bit
MINICONDA39_64_URL="https://repo.anaconda.com/miniconda/Miniconda3-py39_4.9.2-Linux-x86_64.sh"
# Python 3.8	Miniconda3 Linux 64-bit
MINICONDA38_64_URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"
# Python 3.7	Miniconda3 Linux 32-bit
MINICONDA37_32_URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86.sh"
# Python 2.7	Miniconda3 Linux 64-bit
MINICONDA27_64_URL="https://repo.anaconda.com/miniconda/Miniconda2-latest-Linux-x86_64.sh"
# Python 2.7	Miniconda3 Linux 32-bit
MINICONDA27_32_URL="https://repo.anaconda.com/miniconda/Miniconda2-latest-Linux-x86.sh"
#
#
# Miniconda Installation
wget $MINICONDA3_URL
bash Miniconda*
rm Miniconda*
#
# Updating conda environment
conda update conda
#
#Creating conda environments for Python3 and Python2
conda create --name hivePy37 python=3.7
conda create --name hivePy27 python-2.7