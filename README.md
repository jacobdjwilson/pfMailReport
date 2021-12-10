# pfMailReport
This project wraps pfSense command output into a rich format HTML suitable for email via the [mailreport] package.Currently this project supports pfSense version 2.5.x, users can install this package and script through the WebUI.

This script is designed to gather tabulated command output from the default FreeBSD /bin/sh shell. The design has been structured in a way to be extensible and modular. Many command examples include conversion from CSV and other formats.

This project is not affiliated with pfSense or Rubicon Communications, LLC (Netgate) or Electric Sheep Fencing, LLC.

## Getting Started
Utilizing pfMailReport is simple, first ensure you have the mail report package installed through the WebUI package management system: [ System > Package Manager > Available Packages > mailreport ]
Additionally, from the WebUI you will need to ensure your mail relay has been configured:  [ System > Advanced > Notifications ]

Navigate to the command prompt [ Diagnostics > Command Prompt ] and issue the following command:
