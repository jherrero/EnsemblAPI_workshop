use strict;
use warnings;

use Bio::EnsEMBL::Registry;
use Bio::SeqIO;

## Load the registry automatically
my $reg = "Bio::EnsEMBL::Registry";
$reg->load_registry_from_url('mysql://anonymous@ensembldb.ensembl.org');

## Get the SliceAdaptor for Human
my $slice_adaptor = $reg->get_adaptor("Homo sapiens", "core", "Slice");

## Fetch the Slice for chr.20:100,000-110,000
my $slice = $slice_adaptor->fetch_by_region('chromosome', '20', 100_000, 110_000);

## Create a Bio::SeqIO instance, define output as fasta format
my $chromosome_output= Bio::SeqIO->new(
    -file   => '>seq1.fa',
    -format => 'Fasta');

## Print the sequence
$chromosome_output->write_seq($slice);

