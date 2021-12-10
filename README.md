![pfMailReport Logo](https://github.com/jacobdjwilson/pfMailReport/blob/main/images/logo.png)  
# pfMailReport
This project wraps ![pfSense](https://github.com/pfsense) command output into a rich format HTML suitable for email via the `mailreport` package. Currently this project supports pfSense version 2.5.x, users can install this package and script through the WebUI.

This script is designed to gather tabulated command output from the default FreeBSD /bin/sh shell. The design has been structured in a way to be extensible and modular. Many command examples include conversion from CSV and other formats. Output to HTML format follows [bootstrap](https://github.com/twbs/bootstrap) version 5 design guidelines.

This project is not affiliated with pfSense or Rubicon Communications, LLC (Netgate) or Electric Sheep Fencing, LLC.

## Getting Started
Utilizing pfMailReport is simple, first ensure you have the mail report package installed through the WebUI package management system: ` System > Package Manager > Available Packages > mailreport `
Additionally, from the WebUI you will need to ensure your mail relay has been configured.  ` System > Advanced > Notifications `

Navigate to the command prompt ` Diagnostics > Command Prompt ` and issue the following command:

```
curl -LJ https://raw.githubusercontent.com/jacobdjwilson/pfMailReport/main/pfMailReport.sh -o /usr/local/bin/pfMailReport.sh
```

Now you’re ready to utilize pfMailReport by navigating to `Status > Email Reports ` and adding a *New Report*. Configure your description and desired frequency, then select *Add New Command*. Add as many examples from the [command](https://github.com/jacobdjwilson/pfMailReport/tree/main/commands) directory of this project, or create your own. For this example we’ll use a simple command without dependencies.
Paste the following `Listening Ports` command example:

```
sockstat -4l | awk '{print $1, $2, $6, $7}' | uniq | { cat ; echo ; } | sh /usr/local/bin/pfMailReport.sh -t 'Listening Ports and Processes'
```
This example passes the output of ‘sockstat’ IPv4 ports that are listening for incoming connections to the pfMailReport script, with the t (table) flag and secondary string argument ‘Listening Ports and Processes’ that will be parsed as the section header.

Below is the example command output sent via email:
![pfMailReport Command Output Example](https://github.com/jacobdjwilson/pfMailReport/blob/main/images/output_example.png)  

## Command Options
![pfMailReport Command Output Options](https://github.com/jacobdjwilson/pfMailReport/blob/main/images/output_format.png)  
Usage: cmd [-t] table columns [-r] table rows [-l] ordered list

* -t table  
An HTML formatted table that parses columns (tabs or spaces) and rows (new lines). By default the first line of the command output will be used for a table header.

* -r row  
An HTML formatted table that parses ONLY rows (new lines) and avoids columns completely. This option still parses the first line of the command output for a table header.

* -l list  
An HTML ordered list that parses rows as list items. No header or column parsing is included with this option.

* ‘Header String’  
The secondary argument, passed as a string, will be utilized as a HTML section header `<h1>` before the table. Example:

```
echo log_file.log | { cat ; echo ; } | sh /usr/local/bin/pfMailReport.sh -r 'Log Name'
```  

## Future Development
* Ability to specify output stream delimiter
* Visual data representations ie. graphing
