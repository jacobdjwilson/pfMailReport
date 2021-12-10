# pfMailReport
This project wraps pfSense command output into a rich format HTML suitable for email via the [mailreport]package.Users can install this package through the WebUI via:
System > Package Manager > Available Packages > mailreport

By default, this script is designed to gather tabulated command output from the default FreeBSD /bin/sh shell. However, the design has been structured in a way to be extensible and modular. Many command examples include conversion from CSV and other formats.

This project is not affiliated with pfSense or Rubicon Communications, LLC (Netgate) or Electric Sheep Fencing, LLC.
