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

# Get the GenomeDB for the pig genome
my $pig_genome_db = $genome_db_adaptor->fetch_by_registry_name("pig");

# Get the Compara DnaFrag Adaptor
my $dnafrag_adaptor = Bio::EnsEMBL::Registry->get_adaptor(
    "Multi", "compara", "DnaFrag");

# Get the DnaFrags for pig chromosome 15
## Note fetch_by... returns one single object
my $dnafrag = $dnafrag_adaptor->fetch_by_GenomeDB_and_name(
    $pig_genome_db, "15");

print "Chromsome ", $dnafrag->name, " contains ", $dnafrag->length, " bp.\n";
