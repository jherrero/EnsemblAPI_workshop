#
# This script outputs the species in the mammalian EPO alignment
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

# Get the MethodLinkSpeciesSet for the mammalian EPO set
my $mlss = $mlssa->fetch_by_method_link_type_species_set_name("EPO", "mammals");

print "# method_link_species_set_id : ", $mlss->dbID, "\n";
# $mlss->species_set_obj->genome_dbs() brings back a list ref of genome_db objects
foreach my $genome_db (@{ $mlss->species_set_obj->genome_dbs }){
	print $genome_db->name, "\n";
}
