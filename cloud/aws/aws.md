#### Services:
* `EC2` (Elastic Compute Cloud) - Virtual servers
* `S3` (Simple Storage Service) - FTP servers
* `Route 53` - DNS + Domains
* `Lambda` - 
* `DynamoDB` - Key-value storage
* `CloudFormation` - Infrastructure as Code
* `CloudWatch` - Application and Infrastructure Monitoring (Logs, Metrics, Alarms, Dashboards, KPIs)
* `IAM` (Identity and Access Management) - Users, groups, permissions
* `ALB` (Application Load Balancer) - distributes incoming application traffic across multiple targets (e.g. EC2 instances)
* `VPC` (Virtual Private Cloud) - logical network which you can provision resources into

#### The Five Pillars:
* `Operational Excellence` - continuously improve your ability to run systems, create better procedures, and gain insights
    * Based on automation, because human error is the primary cause of incidents
    * `IaC` (Infrastructure as Code) - infrastructure management via configuration files
    * `Observability`- process of measuring the internal state of your system. It allows to track the impact of automation and continuously improve it
        * `Collection` - aggregation of metrics (Infrastructure/Application/Account)
        * `Analytics` - find answers in data (most popular X, how many users did Y, users quit using app after Z happened)
        * `Action` - monitoring & alarming, dashboards, data-driven decisions
* `Security` - all application components and services are considered discrete and potentially malicious entities (zero trust model)
    * `IAM` (Identity and Access Management)
    * `Network Security`
    * `Data Encryption` - encrypting our data everywhere, both in transit and at rest
* `Reliability` - build services that are resilient to service and infrastructure disruptions
    * Techniques to deal with the failure when it happens:
        * `Fault Isolation` - limits the blast radius of an incident by using redundant independent components
        * `Limits`
* 
