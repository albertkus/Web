#!/usr/bin/perl -T

use strict;
use warnings;
use CGI qw(:standard);

print "Content-type: text/html\n\n";

my $firstName    = param('firstName');
my $lastName     = param('lastName');
my $phone        = param('phone');
my $email        = param('email');
my @research     = param('research');
my $day1         = param('day1');
my $day2         = param('day2');
my $day3         = param('day3');
my $session      = param('session');
my $message      = param('message');

my $error_message;
my @possible_sessions = ('Workshop', 'Presentation');
my @possible_research = ('Genomics', 'Proteomics', 'Bioinformatics', 'Systems Biology');


if (!$firstName || !$lastName || !$email || !$phone) {
    $error_message .= "<p>Some required fields are missing. Please go back and try again.</p>";
}

if ($email !~ /^[\w\.\-]+@[\w\.\-]+\.\w+$/) {
    $error_message .= "<p>Invalid email format. Please correct it.</p>";
}

if ($phone !~ /^\d{3}-\d{2}-\d{3}-\d{3}$/) {
    $error_message .= "<p>Invalid phone number format. Please follow the format: 370-67-323-332.</p>";
}

if (!$day1 && !$day2 && !$day3) {
    $error_message .= "<p>Please select at least one day you are attending.</p>";
}

if (!$session || !(grep { $_ eq $session } @possible_sessions)) {
    $error_message .= "<p>Please select your preferred session type from the available options: Workshop or Presentation.</p>";
}

foreach my $r (@research) {
    if (!grep { $_ eq $r } @possible_research) {
        $error_message .= "<p>Invalid research area selected. Please choose from: Genomics, Proteomics, Bioinformatics, Systems Biology.</p>";
    }
}

if ($error_message) {
    print "<html><body><h1>Error</h1>";
    print $error_message;
    print "</body></html>";
    exit;
}

my @days_attending;
push @days_attending, $day1 if $day1;
push @days_attending, $day2 if $day2;
push @days_attending, $day3 if $day3;

print "<html><body>";
print "<h1>Thank you for your submission!</h1>";
print "<p>Here is the information you submitted:</p>";
print "<ul>";
print "<li><strong>First Name:</strong> $firstName</li>";
print "<li><strong>Last Name:</strong> $lastName</li>";
print "<li><strong>Phone:</strong> $phone</li>";
print "<li><strong>Email:</strong> $email</li>";
print "<li><strong>Research Areas:</strong> " . join(', ', @research) . "</li>";
print "<li><strong>Days Attending:</strong> " . join(', ', @days_attending) . "</li>";
print "<li><strong>Preferred Session Type:</strong> $session</li>";
print "<li><strong>Message:</strong> $message</li>";
print "</ul>";
print "</body></html>";
