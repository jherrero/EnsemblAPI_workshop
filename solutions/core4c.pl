use strict;
use warnings;

use Bio::EnsEMBL::Registry;

## Load the registry automatically
my $reg = "Bio::EnsEMBL::Registry";
$reg->load_registry_from_url('mysql://anonymous@ensembldb.ensembl.org');

## Get the GeneAdaptor for Human
my $gene_adaptor = $reg->get_adaptor("Homo sapiens", "core", "Gene");

## Fetch the all the Gene objects corresponding to the external name BRCA2
my $genes = $gene_adaptor->fetch_all_by_external_name('BRCA2');

foreach my $this_gene (@$genes) {
  my $xrefs = $this_gene->get_all_DBLinks();
  foreach my $this_xref (@$xrefs) {
    print "BRCA2 (", $this_gene->stable_id, ") correponds to ",
        $this_xref->dbname, " -- ",
        $this_xref->display_id, "\n";
  }
}
