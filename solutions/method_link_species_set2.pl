#
# This script counts the number of MethodLinkSpeciesSets by type
# stored in the compara database
#
use strict;
use warnings;

use Bio::EnsEMBL::Registry;

# Auto-configure the registry
Bio::EnsEMBL::Registry->load_registry_from_db(
	-host=>"ensembldb.ensembl.org",
	-user=>"anonymous");

# Get the Compara Adaptor for MethodLinkSpeciesSets
my $mlssa = Bio::EnsEMBL::Registry->get_adaptor(
    "Multi", "compara", "MethodLinkSpeciesSet");

# fetch_all() method returns a array ref.
my $all_mlss = $mlssa->fetch_all();

# Loop through all the MethodLinkSpeciesSet and count them by type
my %mlt_counter;
foreach my $method_link_species_set (@{ $all_mlss }){
	$mlt_counter{ $method_link_species_set->method->type }++;
}

# Print the result. "each" returns each pair of key-values in the hash
while (my ($method_link_type, $count) = each %mlt_counter) {
	print $method_link_type, ": ", $count, "\n";
}

