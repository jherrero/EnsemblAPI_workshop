use strict;
use warnings;

use Bio::EnsEMBL::Registry;

## Load the registry automatically
my $reg = "Bio::EnsEMBL::Registry";
$reg->load_registry_from_url('mysql://anonymous@ensembldb.ensembl.org');

## Get the GeneAdaptor for Human
my $gene_adaptor = $reg->get_adaptor("Homo sapiens", "core", "Gene");

## Fetch the all the Gene objects corresponding to the external name p23
my $genes = $gene_adaptor->fetch_all_by_external_name('SNORA1');

foreach my $this_gene (@$genes) {
  print "SNORA1 correponds to ",
      $this_gene->stable_id, " -- ",
      $this_gene->seq_region_name, ":",
      $this_gene->seq_region_start, "-",
      $this_gene->seq_region_end, "[",
      $this_gene->seq_region_strand, "]";
  print "\n";
}
