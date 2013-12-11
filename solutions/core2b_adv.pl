use strict;
use warnings;

use Bio::EnsEMBL::Registry;

## Load the registry automatically
my $reg = "Bio::EnsEMBL::Registry";
$reg->load_registry_from_url('mysql://anonymous@ensembldb.ensembl.org');

## Get the SliceAdaptor for Human
my $slice_adaptor = $reg->get_adaptor("Homo sapiens", "core", "Slice");

## Fetch the Slice for the gene ENSG00000101266 with 2kb of flanking sequence
my $slice = $slice_adaptor->fetch_by_gene_stable_id('ENSG00000101266', 2_000);

## Print the name of the slice
print $slice->name, "\n";

