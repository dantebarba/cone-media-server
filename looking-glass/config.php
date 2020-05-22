<?php

/*
 * Main configuration file example.
 *
 * DO NOT EDIT NOR RENAME, please copy to 'config.php' and edit the new file!
 */

// People to contact
// Set both to null to not display any contact information
$config['contact']['name'] = 'Cone media server';
$config['contact']['mail'] = 'dantebarba.alerts@gmail.com';

// Frontpage configuration

// Title of the page
$config['frontpage']['title'] = 'Dantes Cone Glass';
// Logo to display (remove it to not display any logo)
$config['frontpage']['image'] = 'logo.png';
// Disclaimer to inform people using the looking glass
// Set it to null to not display a disclaimer
$config['frontpage']['disclaimer'] = null;

// Things to remove from the output (PHP compatible regex)
$config['filters']['output'][] = '/(client1|client2)/';
$config['filters']['output'][] = '/^NotToShow/';
// Matched patterns can also replaced inline
$config['filters']['output'][] = ['/replacethis/', 'withthis'];

// If telnet is used in combination with extreme_netiron, uncomment the following filter
//$config['filters']['output'][] = '/([^\x20-\x7E]|User|Please|Disable|telnet|^\s*$)/';

// Google reCaptcha integration
$config['recaptcha']['enabled'] = false;
$config['recaptcha']['apikey'] = 'foobar';
$config['recaptcha']['secret'] = 'foobar';

// If running on *BSD, disable '-A' which is non-existent
$config['tools']['ping_options'] = '-c 5';
// If running on *BSD, disable '-N' which is non-existent
$config['tools']['traceroute_options'] = '-A -q1 -w2 -m15';
// If running on *BSD, there is no '-4' or '-6'
$config['tools']['traceroute6'] = 'traceroute6';
$config['tools']['traceroute4'] = 'traceroute';