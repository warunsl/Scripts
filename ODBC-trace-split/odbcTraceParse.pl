#! /usr/bin/perl

open INFILE, $ARGV[0] || die "Cannot open filename: $!\n";

my $choice;
my $odbc = 0;
my $segment = "";
my $odbcSegment = "";

print "Split by :\n";
print "1. Threads\n";
print "2. Processes\n";

$choice = <STDIN>;
chomp ($choice);

if($choice == 1)
{
  print "Splitting the ODBC trace file by threads\n";
}
elsif($choice == 2)
{
  print "Splitting the ODBC trace file by processes\n";
}
else
{
  print "Invalid\n";
  exit(0);
}

while (<INFILE>) 
{
  # Handle the first occurance of [ODBC]
  $indexOfODBC = index($_,"\[ODBC\]");
  if($indexOfODBC==0)
  {
    $odbcSegment = "";
  }
  if($indexOfODBC==0 && $odbc==0)
  {
    $odbc = 1;
    $indexOfODBC = 1;
  }
  
  # Handle the subsequent occurances of [ODBC]
  # $indexOfODBC = index($_,"\[ODBC\]");
  if($indexOfODBC==0 && $odbc==1)
  {
    $odbcSegment = $segment;
    $segment = "";
    $indexOfODBC = 1;
  }
  
  $segment = $segment.$_;
  
  # $segment now has the last odbcSegment, don't lose it.
  if(length($segment)>0)
  {
    $odbcSegment = $segment;
    $segment = "";
  } 
  
  &splitFile($odbcSegment);
}

sub splitFile()
{
  # Index, substr and other string functions might manipulate the base string, not very sure, so better have a back up
  my $odbcSegmentCopy = $_[0];
  
  my $indexOfODBCBlock;
  my $indexOfODBCBlockClose;
  my $indexOfProcessBlock;
  my $indexOfProcessBlockClose;
  my $indexOfThreadBlock;
  my $indexOfThreadBlockClose;

  # print $odbcSegmentCopy;
  
  $indexOfODBCBlock = -1;
  $indexOfODBCBlockClose = -1;

  $indexOfODBCBlock = index($odbcSegment,"\[");
  $indexOfODBCBlockClose = index($odbcSegment,"\]");

  if($indexOfODBCBlock == 0)
  { 
    $indexOfProcessBlock = -1;
    $indexOfProcessBlockClose = -1;
    $indexOfThreadBlock = -1;
    $indexOfThreadBlockClose = -1;
      
    $indexOfProcessBlock = index($odbcSegment,"\[",$indexOfODBCBlockClose);
    if($indexOfProcessBlock > 0)
    {      
      $indexOfProcessBlockClose = index($odbcSegment,"\]",$indexOfProcessBlock);
      $processID = substr($odbcSegment,$indexOfProcessBlock + 1,$indexOfProcessBlockClose - $indexOfProcessBlock - 1);
    }
    
    $indexOfThreadBlock = index($odbcSegment,"\[",$indexOfProcessBlockClose);
    if($indexOfThreadBlock > 0)
    {
      $indexOfThreadBlockClose = index($odbcSegment,"\]",$indexOfThreadBlock);
      $threadID = substr($odbcSegment,$indexOfThreadBlock + 1,$indexOfThreadBlockClose - $indexOfThreadBlock - 1);
    }
  }
  
  if($choice == 1)
  {
     &splitBasedOnThread($threadID,$odbcSegmentCopy);
  }
  
  if($choice == 2)
  {
     &splitBasedOnProcess($processID,$odbcSegmentCopy);
  } 
  
}

sub splitBasedOnProcess()
{
  my $processID = $_[0];
  my $odbcSegmentCopy = $_[1];
  if(length($processID) > 0)
  {
    open OUTFILE, ">>", "$processID.txt" || die "Cannot open filename: $!\n";
    print OUTFILE $odbcSegmentCopy; 
    close OUTFILE;
  }
}

sub splitBasedOnThread()
{
  my $threadID = $_[0];
  my $odbcSegmentCopy = $_[1];
  if(length($threadID) > 0)
  {
    open OUTFILE, ">>", "$threadID.txt" || die "Cannot open filename: $!\n";
    print OUTFILE $odbcSegmentCopy; 
    close OUTFILE;
  }
}
 
close (INFILE);
print "Done!\n";
exit 0;
