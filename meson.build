project('BioD', 'd',
    meson_version : '>=0.46',
    license : 'MIT',
    version : '0.2.2'
)

project_soversion = '0'

src_dir = include_directories('.')
pkgc = import('pkgconfig')

#
# Dependencies
#
# undead_dep = dependency('undead', version : '>=1.0.6')
zlib_dep = dependency('zlib')

#
# Sources
#
biod_src = [
    'bio/std/hts/bam/abstractreader.d',
    'bio/std/hts/bam/bai/bin.d',
    'bio/std/hts/bam/baifile.d',
    'bio/std/hts/bam/bai/indexing.d',
    'bio/std/hts/bam/baseinfo.d',
    'bio/std/hts/bam/cigar.d',
    'bio/std/hts/bam/constants.d',
    'bio/std/hts/iontorrent/flowcall.d',
    'bio/std/hts/iontorrent/flowindex.d',
    'bio/std/hts/bam/md/core.d',
    'bio/std/hts/bam/md/operation.d',
    'bio/std/hts/bam/md/parse.d',
    'bio/std/hts/bam/md/reconstruct.d',
    'bio/std/hts/bam/multireader.d',
    'bio/std/hts/bam/pileup.d',
    'bio/std/hts/bam/randomaccessmanager.d',
    'bio/std/hts/bam/read.d',
    'bio/std/hts/bam/reader.d',
    'bio/std/hts/bam/readrange.d',
    'bio/std/hts/bam/reference.d',
    'bio/std/hts/bam/referenceinfo.d',
    'bio/std/hts/bam/region.d',
    
    'bio/std/hts/snpcallers/maq.d',
    'bio/std/hts/snpcallers/simple.d',
    
    'bio/std/hts/bam/splitter.d',
    'bio/std/hts/bam/tagvalue.d',
    
    'bio/std/hts/thirdparty/msgpack.d',
    'bio/std/hts/utils/array.d',
    'bio/std/hts/utils/graph.d',
    'bio/std/hts/utils/samheadermerger.d',
    'bio/std/bam/utils/value.d',
    'bio/std/hts/bam/validation/alignment.d',
    'bio/std/hts/bam/validation/samheader.d',
    'bio/std/hts/bam/writer.d',
    'bio/std/core/base.d',
    'bio/std/core/bgzf/block.d',
    'bio/std/core/bgzf/chunk.d',
    'bio/std/core/bgzf/compress.d',
    'bio/std/core/bgzf/constants.d',
    'bio/std/core/bgzf/inputstream.d',
    'bio/std/core/bgzf/outputstream.d',
    'bio/std/core/bgzf/virtualoffset.d',
    'bio/std/core/call.d',
    'bio/std/file/fasta.d',
    'bio/std/file/fastq.d',
    'bio/std/core/genotype.d',
    'bio/std/core/kmer.d',
    'bio/std/core/region.d',
    'bio/std/core/sequence.d',
    'bio/std/core/tinymap.d',
    'bio/std/core/utils/algo.d',
    'bio/std/core/utils/bylinefast.d',
    'bio/std/core/utils/exception.d',
    'bio/std/core/utils/format.d',
    'bio/std/core/utils/memoize.d',
    'bio/std/core/utils/outbuffer.d',
    'bio/std/core/utils/range.d',
    'bio/std/core/utils/roundbuf.d',
    'bio/std/core/utils/stream.d',
    'bio/std/core/utils/switchendianness.d',
    'bio/std/core/utils/tmpfile.d',
    'bio/std/core/utils/zlib.d',
    'bio/std/hts/maf/block.d',
    'bio/std/hts/maf/parser.d',
    'bio/std/hts/maf/reader.d',
    'bio/std/hts/sam/header.d',
    'bio/std/hts/sam/reader.d',
    'bio/std/hts/sam/utils/fastrecordparser.d',
    'bio/std/hts/sam/utils/recordparser.d',
    'bio/std/hts/sff/constants.d',
    'bio/std/hts/sff/index.d',
    'bio/std/hts/sff/read.d',
    'bio/std/hts/sff/reader.d',
    'bio/std/hts/sff/readrange.d',
    'bio/std/hts/sff/utils/roundup.d',
    'bio/std/hts/sff/writer.d'
]

bio2_src = [
    'bio/std/experimental/hts/bam/header.d',
    'bio/std/experimental/hts/bam/reader.d',
    'bio/std/experimental/hts/bam/writer.d',
    'bio/std/experimental/hts/bgzf.d',
    'bio/std/experimental/hts/bgzf_writer.d',
    'bio/std/experimental/hts/constants.d',
    'bio/std/experimental/hts/hashing.d',
    'bio/std/experimental/hts/logger.d',
    'bio/std/experimental/hts/pileup.d',
    'bio/std/experimental/hts/reads.d',
    'bio/std/experimental/hts/unpack.d'
]

#
# Includes
#
install_subdir('bio/', install_dir: 'include/d/bio/')
# install_subdir('bio2/', install_dir: 'include/d/bio/')

#
# Library and pkg-config
#
biod_lib = library('biod',
        [biod_src],
#        dependencies: [undead_dep, zlib_dep],
        install: true,
        version: meson.project_version(),
        soversion: project_soversion
)
pkgc.generate(name: 'biod',
              libraries: biod_lib,
              subdirs: 'd/bio/',
              version: meson.project_version(),
              description: 'A library for computational biology and bioinformatic'
)

#
# Tests
#
biod_test_exe = executable('biod_test',
    ['test/unittests.d',
     biod_src,
 #  bio2_src],
  #  dependencies: [undead_dep, zlib_dep],
    d_unittest: true
)
test('biod_tests', biod_test_exe)
