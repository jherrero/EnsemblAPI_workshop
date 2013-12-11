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

## Get all existing gene object with the name BRCA2
my $these_genes = $human_gene_adaptor->fetch_all_by_external_name('FOSL2');

## For each of these genes...
foreach my $this_gene (@$these_genes) {
  ## Get the compara member
  my $member = $member_adaptor->fetch_by_source_stable_id(
      "ENSEMBLGENE", $this_gene->stable_id);

  ## Get all the homologues in mouse
  my $all_homologies = $homology_adaptor->fetch_all_by_Member_method_link_type($member, "ENSEMBL_PARALOGUES");

  ## For each homology
  foreach my $this_homology (@$all_homologies) {
    ## get the members in this homology (they are sorted)
    my $homologous_members = $this_homology->get_all_Members();
    my ($query_member, $paralog_member) = @$homologous_members;

    ## print the members in this homology
    print $paralog_member->source_name, " ",
        $paralog_member->stable_id, " ",
        ($paralog_member->display_label or ""), " (",
        $paralog_member->genome_db->name, ")\n";
    print "\n";
    get_orthologues($paralog_member, "mus_musculus");
    get_orthologues($paralog_member, "gallus_gallus");
    print "\n";
  }
}

sub get_orthologues {
  my ($member, $paired_species) = @_;

  my $all_homologies = $homology_adaptor->fetch_all_by_Member_paired_species($member, $paired_species);
  foreach my $this_homology (@$all_homologies) {
    ## get the members in this homology (they are sorted)
    my $homologous_members = $this_homology->get_all_Members();
    my ($query_member, $other_member) = @$homologous_members;

    ## print info about the "other" member
    print $other_member->source_name, " ",
        $other_member->stable_id, " ",
        ($other_member->display_label or ""), " (",
        $other_member->genome_db->name, ")\n";
  }
}