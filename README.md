graylog2 Cookbook
=================

This cookbook installs graylog2 web-interface and gralyog2 server with oracle java, elasticsearch 
and mongodb. 

Also a default intput for syslog is added and an example drool-rule
to drop monit conncetion checks to postfix.


# Requirements #
----------------

## Platform ##

The Cookbook is tested on the following platforms:
* Ubuntu 14


## Cookbooks ##

cookbook 'monit', github: 'phlipper/chef-monit'
cookbook 'ark'
cookbook 'logrotate'
cookbook 'elasticsearch'
cookbook 'mongodb'
cookbook 'java'


Attributes
----------

#### graylog2::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
      <td><tt>['graylog2']['server_name']</tt></td>
      <td>String</td>
      <td>The full domain name for the graylog server</td>
      <td>nil</td>
  </tr>
  <tr>
    <td><tt>['graylog2']['password_secret']</tt></td>
    <td>String</td>
    <td>Graylog password secret</td>
    <td>nil</td>
  </tr>
  <tr>
      <td><tt>['graylog2']['root_password']</tt></td>
      <td>String</td>
      <td>Root password for graylog</td>
      <td>nil</td>
  </tr>
</table>

Also have a look at java, mongodb and elasticsearch cookbooks for additional parameters.

#### graylog2::syslog_client
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
      <td><tt>['graylog2']['server_name']</tt></td>
      <td>String</td>
      <td>The full domain name for the graylog server</td>
      <td>nil</td>
  </tr> 
</table>

Usage
-----
#### graylog2::default

*Important!* This recipe uses the oracle jvm. you have to accept oracle download terms!
Just include `graylog2` in your node's `run_list`:

```json

"default_attributes": {

        "graylog2":{
                     "server_name" : "syslog.example.com",
                     // use for instance pwgen -s 96
                     "password_secret" : ".......",
                     // plain text is translated via Digest::SHA256.hexdigest
                     "root_password": "my secret for admin"
        },
        "java" : {"oracle" : {
                               "accept_oracle_download_terms": true
                              }
                 }
}

```

#### graylog2::syslog_client


Configures rsyslog to send all logs to graylog.


```json

"default_attributes": {

        "graylog2":{
            "server_name" : "syslog.example.com"
        }
}
```

Contributing
------------


1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github


License and Authors
-------------------
Copyright: 2014, FABER Lotto GmbH &amp; Co. KG

Licensed under the MIT License.
