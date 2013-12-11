use strict;
use warnings;

use Bio::EnsEMBL::Registry;

## Load the registry automatically
my $reg = "Bio::EnsEMBL::Registry";
$reg->load_registry_from_url('mysql://anonymous@ensembldb.ensembl.org');

## Get the GeneAdaptor for Human
my $gene_adaptor = $reg->get_adaptor("Homo sapiens", "core", "Gene");

## Fetch the Gene object for ENSG00000101266
my $gene = $gene_adaptor->fetch_by_stable_id('ENSG00000101266');

print "Gene ", $gene->stable_id, " is located in ",
    $gene->seq_region_name, ":",
    $gene->seq_region_start, "-",
    $gene->seq_region_end, "[",
    $gene->seq_region_strand, "]\n"; 

