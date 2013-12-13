#
# This script prints the name of the MethodLinkSpeciesSets for
# the pig-cow LASTZ_NET pairwise alignments
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

# Fetch the MLSS for pig-cow LASTZ-NET alignments (Mind the square brackets!)
my $this_mlss = $mlssa->fetch_by_method_link_type_registry_aliases(
    "LASTZ_NET", ["pig", "cow"]);

print $this_mlss->name, "\n";
