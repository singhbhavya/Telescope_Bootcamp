##Telescope Installation 
"""
conda create -n telescope_env python=3.6 future pyyaml cython=0.29.7 \
  numpy=1.16.3 pandas=1.1.3 scipy=1.2.1 pysam=0.15.2 htslib=1.9 intervaltree=3.0.2

conda activate telescope_env
pip install git+git://github.com/mlbendall/telescope.git
telescope assign -h
"""

##Test
"""
eval $(telescope bulk test)
"""


##running


##telescope bulk assign [samfile][gtffile]
"""
telescope bulk assign [C:/Users/17729/.conda/envs/results/star_alignment/{samid}/{samid}_GDC38.Aligned.out.bam][C:/Users/17729/.conda/envs/STAR/genome/refs/SA]
"""
##SAMfile: [results/star_alignment/{samid}/{samid}_GDC38.Aligned.out.bam] ?
##gtfile: [C:/Users/17729/.conda/envs/STAR/genome/refs/SA] ?