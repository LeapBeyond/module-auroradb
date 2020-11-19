# module-auroradb
This is a very bare bones Terraform module to create an AuroraDB cluster inside pre-existing subnets.

## Prerequisites
This module does make use of Terraform version constraints (see `versions.tf`) but can be summarised as:

 - Terraform 0.13.4 or above
 - Terraform AWS provider 3.7.0 or above

## Usage
This is intended to be very simple to use, for example:

```
module test_vpc {
  source       = "github.com/LeapBeyond/module-auroradb"

  vpc_id       = "vpc-c363feab"
  subnet_id    = ["subnet-6082e509", "subnet-19b04155"]
  access_ip    = ["89.36.68.26/32", "35.176.208.98/32", "3.9.34.0/24"]
  tags         = { Owner = "Leap Beyond", Client = "Internal", Project = "AuroraDB Module Test" }
  basename     = "mytest"
  db_name      = "mydbase"
  cluster_size = 4
}
```

| Variable | Comment |
| :------- | :------ |
| vpc_id | the ID of the VPC we are installing into |
| subnet_id | the list of subnets inside that VPC that we can use for cluster members |
| access_ip | a list of CIDR blocks that are allowed to access the database |
| tags | a map of strings to use as the common set of tags for all generated assets |
| basename | a string used as the prefix on various names - this should be unique |
| db_name | the name of the database that is first created |
| cluster_size | this defaults to 2, but can be overridden. Be aware that the configured instances are very generously provisioned |

The following outputs are provided:

| Output | Comment |
| :----- | :------ |
| db_password | the generated password for the `admin` user - note this is distinctly not secure and should be set after initial database configuration! |
| db_writer_jdbc | the JDBC url for the read/write endpoint to the cluster |
| db_reader_jdbc | the JDBC url for the read-only endpoint to the cluster |

## License
Copyright 2020 Leap Beyond Emerging Technologies B.V.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
