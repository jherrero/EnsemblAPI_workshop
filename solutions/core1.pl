#!/usr/bin/perl

use strict;
use warnings;

use Bio::EnsEMBL::Registry;

my $registry = "Bio::EnsEMBL::Registry";

## Load the databases into the registry and print their names
$registry->load_registry_from_db(
	-host => 'ensembldb.ensembl.org',
	-user => 'anonymous',
	-verbose => '1' );
