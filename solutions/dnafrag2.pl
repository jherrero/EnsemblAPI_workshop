use strict;
use warnings;
use Data::Dumper;
use Bio::AlignIO;

use Bio::EnsEMBL::Registry;

# Auto-configure the registry
Bio::EnsEMBL::Registry->load_registry_from_db(
	-host=>"ensembldb.ensembl.org",
	-user=>"anonymous");

# Get the Compara GenomeDB Adaptor
my $genome_db_adaptor = Bio::EnsEMBL::Registry->get_adaptor(
    "Multi", "compara", "GenomeDB");

# Get the GenomeDB for the chimp genome
my $chimp_genome_db = $genome_db_adaptor->fetch_by_registry_name("chimp");

# Get the Compara DnaFrag Adaptor
my $dnafrag_adaptor = Bio::EnsEMBL::Registry->get_adaptor(
    "Multi", "compara", "DnaFrag");

# Get all the DnaFrags for chimp
## Note fetch_all_by... returns a (reference to a) list of objects
my $dnafrags = $dnafrag_adaptor->fetch_all_by_GenomeDB_region(
    $chimp_genome_db);

print "For ", $chimp_genome_db->name, " :\n";
# Loop through all the DnaFrags and print their name
foreach my $dnafrag(@{ $dnafrags }){
	print "Chromsome ", $dnafrag->name,
    	" contains ", $dnafrag->length, " bp.\n";
}
