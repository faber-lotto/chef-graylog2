name             'graylog2'
maintainer       'Faber Lotto'
maintainer_email 'd.spaeth@faber.de'
license          'MIT'
description      'Installs/Configures graylog2'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'


depends 'monit'
depends 'ark'
depends 'logrotate'
depends 'elasticsearch'
depends 'mongodb'
depends 'java'