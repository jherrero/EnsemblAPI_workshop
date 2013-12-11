#
# This script counts the number of MethodLinkSpeciesSets stored in
# the compara database
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

# Count the total number of MethodLinkSpeciesSet. In Perl, assigning
# an array to a scalar returns the number of elements in the array.
my $total_count = @{ $all_mlss };

# Print the result
print "Total number of analyses: ", $total_count, "\n";

