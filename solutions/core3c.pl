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

# Declare this ref to a hash
my $biotypes = {};

foreach my $this_gene (@$genes) {
  # Get the biotype for this gene
  my $this_biotype = $this_gene->biotype;
  # Add this gene to the counter
  $biotypes->{$this_biotype}++;
}

# Print all the biotypes and the corresponding number of genes
while (my ($this_biotype, $num) = each %$biotypes) {
  print "There are $num $this_biotype genes\n";
}
