Ansible Role: Java Runtime
=========

Ansible role to install/configure the Java Runtime Environment on Windows.

Requirements
------------

* Windows Server 2016
* Windows Server 2019
* Windows Server 2022

Role Variables
--------------

Available variables are listed below, along with default values (see `defaults/main.yml`):

    java_state: present

Determines the state of the Java runtime, consistent with standard declarative language, valid values: `present`, `absent` or `purged`.
`purged` is only currently applicable to Oracle installations and was added to support cleanup of Oracle installations when transitioning to
OpenJDK.

    java_path_temp: C:\Windows\Temp

Set the temp folder path where the Java installer binary is downloaded to.

    java_path_log: "{{ java_path_temp }}\\java-install.log"

Defines the log file containing the Java runtime installation log.

    java_log: false

Boolean indicating whether to log the installation or not.

    java_artifact_source: http

Determines how the Java binary is retrieved, valid values are `smb`, `http` or `local`.

    java_artifact_destination: "{{ java_path_temp }}\\java-installer.exe"

Determines where the Java binary is downloaded to. Typically appended to `java_path_temp`.

    java_artifact_smb_path: '' #\\path\to\smb\share\file.exe

Full path to the SMB location containing the Java installation binary.

    java_artifact_http_path: https://artifactory.air-watch.com/artifactory/euc-cloudops/automation/jre-8u261-windows-x64.exe

Full path to the HTTP location containing the Java installation binary.

    java_paths:
      - C:\Program Files\Java
      - C:\Program Files (x86)\Java

Defines a list of paths to search for Java installations.

    java_vendor: oracle

Specifies which vendor installation method is being used. Supports `oracle` and `openjdk`.

    java_product_id: ''

Specifies a Windows product ID to be used when uninstalling. If not provided, `java_artifact_destination` will be used instead.
Oracle Java requires this property to be provided for install and uninstall.

Dependencies
------------

* None

Example Playbook
----------------

    - hosts: java_servers
      gather_facts: true
      vars:
        java_artifact_source: http
        java_artifact_http_path: https://files.vmweuc.com/jre-8u261-windows-x64.exe
      roles:
         - ansible-role-java

License
-------

Internal Use

Author Information
------------------

Joe Zollo
