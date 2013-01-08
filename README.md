# puppet-ssh

Puppet module to manage SSH host and user access.

The recommended usage is to place the configuration is hiera and just:

    include ssh

Example hiera config:

    ssh::access::allow:
      - 'alice'
      - 'bob'
      - '@sysadmins'
    ssh::access::deny:
      - 'mallory'
      - '@dev'
    
    ssh::keys::bob:
      type: 'ssh-rsa'
      public_key: 'AAAAB3NzaC1yc2EAAAABJQAAAQBaSth67VpPf6i737TWFYwBUwZdovDyfr2df94YbINWOkOQTBoaR5TnUSgqorpTUGmif8w2khqWWb/ZI+l5HQckR8WVVgBDnFPnXcYZ2ok0qV85bD/ttlpw4QDMb82+f72YcBu4h5A2eKxroqFQCyigfXtE3JjgakIm3iW7OW6XQUkAT8MZFhy3xlodJCdNOxvxawd9CVpw70cTeA7bXBiS8AFUpcKp20Z45tixiESrH2E4TRCy8HHxnN6fGUG+Xt6No265fPpEc+Bg+/hkrguIVEuj2NoIoQcS4F8Kew73jnJte4qugNbJIwcKTWn3NvgjA2CwPIWxvkvJerx129cf'

    ssh::users:
      bob:
        allow: [ 'alice', 'bob' ]
        deny:  [ 'mallory' ]
      tomcat1:
        allow: [ 'alice', 'bob', 'sam' ]

## Host SSH access

Access to the host using is restricted using OpenSSH sshd directives to allow
and deny access to users or group members.  As per the sshd_config(5) man page,
the allow/deny directives are processed in the following order: DenyUsers,
AllowUsers, DenyGroups, and finally AllowGroups.

**ssh::access** parameters:

*allow*: The list of users or groups who will be allowed SSH access. Group
names are prefixed with an '@' sign.

*deny* The list of users or groups that will not be allowed SSH access. Group
names are prefixed with an '@' sign.

## SSH public keys

User SSH public keys are configured using **ssh::keys::<username>** entries -
for example to specify the public key for the bob user:

    ssh::keys::bob:
      type: 'ssh-rsa'
      public_key: 'AAAAB3NzaC1yc2EAAAABJQAAAQBaSth67VpPf6i737TWFYwBUwZdovDyfr2df94YbINWOkOQTBoaR5TnUSgqorpTUGmif8w2khqWWb/ZI+l5HQckR8WVVgBDnFPnXcYZ2ok0qV85bD/ttlpw4QDMb82+f72YcBu4h5A2eKxroqFQCyigfXtE3JjgakIm3iW7OW6XQUkAT8MZFhy3xlodJCdNOxvxawd9CVpw70cTeA7bXBiS8AFUpcKp20Z45tixiESrH2E4TRCy8HHxnN6fGUG+Xt6No265fPpEc+Bg+/hkrguIVEuj2NoIoQcS4F8Kew73jnJte4qugNbJIwcKTWn3NvgjA2CwPIWxvkvJerx129cf'

**ssh::keys::<username>** parameters:

*type*: The type of SSH key, usually either 'ssh-rsa' or 'ssh-dsa'. *Required*

*public_key*: The base64-encoded public key. *Required*

## User SSH access

Access to a user account is determined by the public keys listed in the user's
$HOME/.ssh/ssh_authorized_keys file.  

For example to allow access to the bob user account using both bob and alice's
public keys:

    ssh::users:
      bob:
        allow: [ 'alice', 'bob' ]
        deny:  [ 'mallory' ]

For each **ssh::users** user specified the following parameters can be
specified:

*allow*: The list of users whose public key must be added to the user's
authorized_keys file and who will be allowed access to the user account using
SSH

*deny*: The list of users to allow whose public key must not be present in the
user's authorized_keys file and who will not be allowed access to the user
account using SSH

## Notes

* Only a single SSH public key can be specified for each user

## Support

License: Apache License, Version 2.0

GitHub URL: https://github.com/erwbgy/puppet-ssh
