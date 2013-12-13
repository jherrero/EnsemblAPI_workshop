#
# This script prints the alignments for the mammalian constrained element
# on the pig chromosome 15 from coordinates 89151597 till 89157190
#
use strict;
use warnings;
use Bio::AlignIO;

use Bio::EnsEMBL::Registry;

#Auto-configure the registry
Bio::EnsEMBL::Registry->load_registry_from_db(
    -host=>"ensembldb.ensembl.org",
    -user=>"anonymous");

# Get the Compara Adaptor for MethodLinkSpeciesSet
my $method_link_species_set_adaptor =
    Bio::EnsEMBL::Registry->get_adaptor(
      "Multi", "compara", "MethodLinkSpeciesSet");

# Get the method_link_species_set for the alignments
my $alignments_method_link_species_set = $method_link_species_set_adaptor->
    fetch_by_method_link_type_species_set_name("EPO_LOW_COVERAGE", "mammals");

# Get the method_link_species_set for the constrained_elements
my $constrained_element_method_link_species_set = $method_link_species_set_adaptor->
   fetch_by_method_link_type_species_set_name("GERP_CONSTRAINED_ELEMENT", "mammals");

# Define the start and end positions for the alignment
my ($pig_start, $pig_end) = (89151587,89157190);

# Get the pig *core* Adaptor for Slices
my $pig_slice_adaptor = Bio::EnsEMBL::Registry->get_adaptor(
    "pig", "core", "Slice");

# Get the slice corresponding to the region of interest
my $pig_slice = $pig_slice_adaptor->fetch_by_region(
    "chromosome", "15", $pig_start, $pig_end);

# Get the Compara Adaptor for ConstrainedElements
my $constrained_element_adaptor = Bio::EnsEMBL::Registry->get_adaptor(
    "Multi", "compara", "ConstrainedElement");

# The fetch_all_by_MethodLinkSpeciesSet_Slice() returns a ref.
# to an array of ConstrainedElement objects (pig is the reference species) 
my $constrained_elements = $constrained_element_adaptor->
    fetch_all_by_MethodLinkSpeciesSet_Slice(
        $constrained_element_method_link_species_set, $pig_slice);

# set up an AlignIO to format SimpleAlign output
my $alignIO = Bio::AlignIO->newFh(-interleaved => 0,
                                  -fh => \*STDOUT,
                                  -format => 'clustalw',
                                  -idlength => 20);

# print the constrained elements
foreach my $constrained_element( @{ $constrained_elements }) {
	print $constrained_element->slice->name(), "\n";
	print $constrained_element->start(), "\n";
	print $constrained_element->end(), "\n";
	print $constrained_element->strand(), "\n";
	print $constrained_element->seq_region_start(), "\n";
	print $constrained_element->seq_region_end(), "\n";
	print $pig_slice->name(), "\n";
	
	# get_SimpleAlign requires the MLSS for the alignments
    my $simple_align = $constrained_element->get_SimpleAlign($alignments_method_link_species_set);
    print $alignIO $simple_align;
}

