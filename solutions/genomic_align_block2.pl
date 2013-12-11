#
# This script prints the mammalian EPO alignments for pig chromosome 15 from
# coordinates 89151597 till 89157190
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

# Get the MethodLinkSpecieSet for mammalian EPO alignments
my $methodLinkSpeciesSet = $method_link_species_set_adaptor->
	fetch_by_method_link_type_species_set_name("EPO","mammals");

# Define the start and end positions for the alignment
my ($pig_start, $pig_end) = (89151597, 89157190);

# Get the pig *core* Adaptor for Slices
my $pig_slice_adaptor =
    Bio::EnsEMBL::Registry->get_adaptor(
      "sus_scrofa", "core", "Slice");

# Get the slice corresponding to the region of interest
my $pig_slice = $pig_slice_adaptor->fetch_by_region(
    "chromosome", "15", $pig_start, $pig_end);

# Get the Compara Adaptor for GenomicAlignBlocks
my $genomic_align_block_adaptor =
    Bio::EnsEMBL::Registry->get_adaptor(
      "Multi", "compara", "GenomicAlignBlock");

# The fetch_all_by_MethodLinkSpeciesSet_Slice() returns a ref.
# to an array of GenomicAlingBlock objects (pig is the reference species)
my $all_genomic_align_blocks = $genomic_align_block_adaptor->
    fetch_all_by_MethodLinkSpeciesSet_Slice(
        $methodLinkSpeciesSet, $pig_slice, undef, undef, "restrict");

# set up an AlignIO to format SimpleAlign output
my $alignIO = Bio::AlignIO->newFh(-interleaved => 0,
                                  -fh => \*STDOUT,
                                  -format => 'clustalw',
                                  -idlength => 20);

# print the restricted alignments
foreach my $genomic_align_block ( @{ $all_genomic_align_blocks } ) {
	print $alignIO $genomic_align_block->get_SimpleAlign;
}

