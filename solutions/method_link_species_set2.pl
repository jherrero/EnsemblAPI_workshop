#
# This script lists the MethodLinkSpeciesSets stored in
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

foreach my $this_mlss (@$all_mlss) {
    print $this_mlss->name, "\n";
}
