use strict;
use warnings;

use Bio::EnsEMBL::Registry;

## Load the registry automatically
my $reg = "Bio::EnsEMBL::Registry";
$reg->load_registry_from_url('mysql://anonymous@ensembldb.ensembl.org');

## Get the human gene adaptor
my $human_gene_adaptor =
    $reg->get_adaptor("Homo sapiens", "core", "Gene");

## Get the compara member adaptor
my $member_adaptor =
    $reg->get_adaptor("Multi", "compara", "Member");

## Get the compara homology adaptor
my $homology_adaptor =
    $reg->get_adaptor("Multi", "compara", "Homology");

## Get all existing gene object with the name CTDP1
my $ctdp1_genes = $human_gene_adaptor->fetch_all_by_external_name('CTDP1');

## For each of these genes...
foreach my $ctdp1_gene (@$ctdp1_genes) {
  ## Get the compara member
  my $member = $member_adaptor->fetch_by_source_stable_id(
      "ENSEMBLGENE", $ctdp1_gene->stable_id);

  ## Get all the homologues in mouse
  my $all_homologies = $homology_adaptor->fetch_all_by_Member_paired_species(
      $member, "mus_musculus");

  ## For each homology
  foreach my $this_homology (@$all_homologies) {
    ## print the description (type of homology) and the
    ## subtype (taxonomy level of the event: duplic. or speciation)
    print $this_homology->description, " [", $this_homology->subtype, "]\n";

    ## get the members in this homology (they are sorted)
    my $homologous_members = $this_homology->get_all_Members();
    my ($query_member, $other_member) = @$homologous_members;

    ## print info about the "other" member
    print $other_member->source_name, " ",
        $other_member->stable_id, " ",
        ($other_member->display_label or ""), " (",
        $other_member->genome_db->name, ")\n";
    print "\n";
  }
}
