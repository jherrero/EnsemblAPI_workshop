#
# This script prints the LASTZ_NET alignments for pig chromosome 15 with cow
# using pig coordinates 89151597 and 89157190)
#
use strict;
use warnings;
use Bio::AlignIO;

use Bio::EnsEMBL::Registry;

#Auto-configure the registry
Bio::EnsEMBL::Registry->load_registry_from_db(
	-host=>"ensembldb.ensembl.org",
	-user=>"anonymous");

# Get the Compara Adaptor for MethodLinkSpeciesSets
my $method_link_species_set_adaptor =
    Bio::EnsEMBL::Registry->get_adaptor(
      "Multi", "compara", "MethodLinkSpeciesSet");

# Get the MethodLinkSpecieSet for pig-cow lastz-net alignments
my $methodLinkSpeciesSet = $method_link_species_set_adaptor->
	fetch_by_method_link_type_registry_aliases("LASTZ_NET", ["pig", "cow"]);

# Define the start and end positions for the alignment
my ($pig_start, $pig_end) = (89151597, 89157190);

# Get the Compara GenomeDB Adaptor
my $genome_db_adaptor = Bio::EnsEMBL::Registry->get_adaptor(
    "Multi", "compara", "GenomeDB");

# Get the GenomeDB for the pig genome
my $pig_genome_db = $genome_db_adaptor->fetch_by_registry_name("pig");

# Get the Compara DnaFrag Adaptor
my $dnafrag_adaptor = Bio::EnsEMBL::Registry->get_adaptor(
    "Multi", "compara", "DnaFrag");

# Get the DnaFrags for pig chromosome 15
my $dnafrag = $dnafrag_adaptor->fetch_by_GenomeDB_and_name($pig_genome_db, "15");

# Get the Compara Adaptor for GenomicAlignBlocks
my $genomic_align_block_adaptor = Bio::EnsEMBL::Registry->get_adaptor(
    "Multi", "compara", "GenomicAlignBlock");

# The fetch_all_by_MethodLinkSpeciesSet_DnaFrag() returns a ref.
# to an array of GenomicAlingBlock objects (pig is the reference species)
# I am using the restrict flag to trim the parts of the alignment that
# go beyond my coordinates of interest. Any true value would, I use "restrict"
# for readability.
my $all_genomic_align_blocks = $genomic_align_block_adaptor->
    fetch_all_by_MethodLinkSpeciesSet_DnaFrag(
        $methodLinkSpeciesSet, $dnafrag, $pig_start, $pig_end,
        undef, undef, "restrict");


# set up an AlignIO to format SimpleAlign output
my $alignIO = Bio::AlignIO->newFh(-interleaved => 0,
                                  -fh => \*STDOUT,
                                  -format => 'clustalw',
                                  -idlength => 20);

# print the restricted alignments
foreach my $genomic_align_block ( @{ $all_genomic_align_blocks } ) {
	print $alignIO $genomic_align_block->get_SimpleAlign;
}

