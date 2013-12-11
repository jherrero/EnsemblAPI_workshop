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

my $transcripts = $gene->get_all_Transcripts();

foreach my $this_transcript (@$transcripts) {
  print
      $this_transcript->stable_id, " -- ",
      $this_transcript->seq_region_name, ":",
      $this_transcript->seq_region_start, "-",
      $this_transcript->seq_region_end, "[",
      $this_transcript->seq_region_strand, "]";
  if ($this_transcript->translation) {
    print " -- prot:", $this_transcript->translation->stable_id;
  }
  print "\n";

  my $exons = $this_transcript->get_all_Exons();
  print "  Exons:";
  foreach my $this_exon (@$exons) {
    print " - ", $this_exon->stable_id;
  }
  print "\n";
}
