use strict;
use warnings;

use Bio::EnsEMBL::Registry;

## Load the registry automatically
my $reg = "Bio::EnsEMBL::Registry";
$reg->load_registry_from_url('mysql://anonymous@ensembldb.ensembl.org');

## Get the SliceAdaptor for Human
my $slice_adaptor = $reg->get_adaptor("Homo sapiens", "core", "Slice");

## Fetch the Slice for the first 20Mb of chr.20
my $slice = $slice_adaptor->fetch_by_region('chromosome', '20', 1, 2_000_000);

## Get the genes on that slice (this is a ref. to an array)
my $genes = $slice->get_all_Genes();

## Get the number of genes:
my $num_of_genes = scalar(@$genes);

## Print this information
print "The number of genes on ", $slice->name, " is ", $num_of_genes, "\n";

