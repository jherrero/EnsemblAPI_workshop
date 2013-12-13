use strict;
use warnings;
use Data::Dumper;
use Bio::AlignIO;

use Bio::EnsEMBL::Registry;

# Auto-configure the registry
Bio::EnsEMBL::Registry->load_registry_from_db(
	-host=>'ensembldb.ensembl.org',
	-user=>"anonymous");

# Get the Compara GenomeDB Adaptor
my $genome_db_adaptor = Bio::EnsEMBL::Registry->get_adaptor(
"Multi", "compara", "GenomeDB");

# Get the GenomeDB for the pig genome
my $pig_genome_db = $genome_db_adaptor->fetch_by_registry_name("pig");

print "Name: ", $pig_genome_db->name, "\n";
print "Assembly: ", $pig_genome_db->assembly, "\n";
print "GeneBuild: ", $pig_genome_db->genebuild, "\n";
