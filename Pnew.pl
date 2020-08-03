#!/usr/bin/perl

use Tk;
use DBI;
use DBD::mysql;



$database = "student";
$host = "localhost";
$port = "3306";
$user = "root";
$pw = "";

$dsn = "dbi:mysql:database=$database:localhost:3306";



$DBIconnect = DBI->connect($dsn, $user, $pw);

$mw = MainWindow->new;
$mw->geometry( "900x600" );
$mw->Button(
	-width => 90, -height => 10,
    -text    => 'generate new ID',
    -command => \&user_input,
)->place(-x => 150, -y => 50);
$mw->Button(
	-width => 90, -height => 10,
    -text    => 'Get Info about an ID?',
    -command => \&getinfo,
)->place(-x => 150, -y => 350);
MainLoop;

sub user_input
{	$win2 = $mw->Toplevel();
	$fn = $win2->Frame()->pack(-expand=>1 );
	$label1 = $fn->Label(-text=>"Enter first name:");
	$label1->pack(-side=>"left");
	$entry1 = $fn->Entry();
	$entry1->bind("<Return>", \&handle_return );
	$entry1->pack(-side=>"left");
	$ln = $win2->Frame()->pack(-expand=>1 );
	$label2 = $ln->Label(-text=>"Enter last name:");
	$label2->pack(-side=>"left");
	$entry2 = $ln->Entry();
	$entry2->bind("<Return>", \&handle_return1 );
	$entry2->pack(-side=>"left");
	$yn = $win2->Frame()->pack(-expand=>1 );
	$label3 = $yn->Label(-text=>"Enter year:");
	$label3->pack(-side=>"left");
	$entry3 = $yn->Entry();
	$entry3->bind("<Return>", \&handle_return2 );
	$entry3->pack(-side=>"left");
	$bn = $win2->Frame()->pack(-expand=>1 );
	$label4 = $bn->Label(-text=>"Enter branch:");
	$label4->pack(-side=>"left");
	$entry4 = $bn->Entry();
	$entry4->bind("<Return>", \&handle_return3 );
	$entry4->pack(-side=>"left");
	$an = $win2->Frame()->pack(-expand=>1 );
	$label5 = $an->Label(-text=>"Enter address:");
	$label5->pack(-side=>"left");
	$entry5 = $an->Entry();
	$entry5->bind("<Return>", \&handle_return4 );
	$entry5->pack(-side=>"left");
	$bu = $win2->Frame()->pack(-expand=>1 );
	$bu->Button(
		-text    => 'ok',
		-command => \&data,
	)->pack();
	sub handle_return {
		$first = $entry1->get();
	}
	sub handle_return1 {
		$last = $entry2->get();
	}
	sub handle_return2 {
		$year = $entry3->get();
	}
	sub handle_return3 {
		$branch = $entry4->get();
	}
	sub handle_return4 {
		$address = $entry5->get();
	}
	sub data
	{
	
	
		$sth = $DBIconnect->prepare("INSERT INTO student
							   (fname , lname, year, branch, address  )
								values
							   (?,?,?,?,?)");
		$sth->execute( $first, $last, $year, $branch, $address) 
		or die $DBI::errstr;
		$sth = $DBIconnect->prepare("SELECT * FROM student ORDER BY ID DESC LIMIT 1");
		$sth->execute() or die $DBI::errstr;
		@row;
			while (@row = $sth->fetchrow_array) {  
				print "GENERATED_ID:", @row[5], "\n";
				$newvar = @row[5];
			}
		
		$pn = $win2->Frame()->pack(-expand=>1 );
		$label99 = $pn->Label(-text=>"GENERATED_ID:");
		$label99->pack(-side=>"left");
		
		my $ent_sec = $win2 -> Entry(-textvariable=>\$newvar) -> pack();
		
		$sth->finish();
	}
}
sub getinfo
{
	$win3 = $mw->Toplevel();
	$tn = $win3->Frame()->pack(-expand=>1 );
	$label0 = $tn->Label(-text=>"\nEnter Student ID:\n");
	$label0->pack(-side=>"left");
	$entry0 = $tn->Entry();
	$entry0->bind("<Return>", \&handle_return0 );
	$entry0->pack(-side=>"left");
	$but = $win3->Frame()->pack(-expand=>1 );
	$but->Button(
		-text    => 'ok',
		-command => \&data0,
	)->pack();
	sub handle_return0 {
		$ID = $entry0->get();
	}
	sub data0{
		$sth = $DBIconnect->prepare("SELECT fname,lname,branch,year,address,ID FROM student where ID = (?)");
		$sth->execute($ID) or die $DBI::errstr;
		@row;
		while (@row = $sth->fetchrow_array) {  
				$q=@row[5];
				print $q;
				$p=@row[0];
				$k=@row[1];
				
				$f=@row[2];
				
				$g=@row[3];
				
				$h=@row[4];
		}
		$namesk = $p." ".$k;
		print $namesk;
		$xn = $win3->Frame()->pack(-expand=>1 );
		$label90 = $xn->Label(-text=>"ID:");
		$label90->pack(-side=>"left");
		$ent_se = $xn -> Entry(-textvariable=>\$q) -> pack();
		$zn = $win3->Frame()->pack(-expand=>1 );
		$label91 = $zn->Label(-text=>"Name:");
		$label91->pack(-side=>"left");
		$ent_s = $zn -> Entry(-textvariable=>\$namesk) -> pack();
		$cn = $win3->Frame()->pack(-expand=>1 );
		$label92 = $cn->Label(-text=>"Year:");
		$label92->pack(-side=>"left");
		$ent = $cn -> Entry(-textvariable=>\$f) -> pack();
		$vn = $win3->Frame()->pack(-expand=>1 );
		$label93 = $vn->Label(-text=>"Branch:");
		$label93->pack(-side=>"left");
		$en = $vn -> Entry(-textvariable=>\$g) -> pack();
		$bn = $win3->Frame()->pack(-expand=>1 );
		$label94 = $bn->Label(-text=>"Address:");
		$label94->pack(-side=>"left");
		$lnt_sec = $bn -> Entry(-textvariable=>\$h) -> pack();
	}
}