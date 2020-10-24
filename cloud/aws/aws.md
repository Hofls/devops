#### Services:
* `EC2` (Elastic Compute Cloud) - Virtual servers
* `S3` (Simple Storage Service) - File storage
* `Route 53` - DNS + Domains
* `Lambda` - takes care of everything required to run and scale your code, you pay only when code is executing
* `DynamoDB` - Key-value storage
* `CloudFormation` - Infrastructure as Code
* `CloudWatch` - Application and Infrastructure Monitoring (Logs, Metrics, Alarms, Dashboards, KPIs)
* `IAM` (Identity and Access Management) - Users, groups, permissions
* `ELM` (Elastic Load Balancing) - distributes incoming application traffic across multiple targets (e.g. EC2 instances), performs health checks
* `VPC` (Virtual Private Cloud) - logical network which you can provision resources into
* `Trusted Advisor` - scans AWS infrastructure, compares it to best practices, and provides recommendations
* `CloudFront` - CDN (Content Delivery Network)

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
        * `Limits` (Service Quotas) - protect services from excessive load (e.g. software misconfiguration, DDoS)
* `Performance Efficiency` - run services efficiently and scalably in the cloud
    * `Cattle model` - every server is interchangeable and quick to deploy, we can quickly scale our capacity by adding more servers
        * As opposed to old `pet model`, where each server is unique
    * `Selection` - picking right tool(service) for the job
        * Type of service:
            * Compute, e.g. VM vs Containers vs Serverless
            * Storage, e.g. S3 vs EBS vs Glacier
            * Database, e.g. Relational vs Non-relational vs Data Warehouse
        * Degree of Management:
            * More opinionated service = More managed experience = Higher level of abstraction
            * If you picked Compute with VM type - EC2 vs Beanstalk vs Lightsail
            * If you picked relation database - RDS vs Aurora 
    * `Scaling` - system's ability to handle more users/requests/load
        * Vertical Scaling - moving to a bigger instance type (t3.small => t3.large))
            * Disadvantages - single point of failure, low upper limit
        * Horizontal Scaling - increasing the number of instances
            * Disadvantages - Complexity. You need a proxy service to route traffic to services, perform health checks to take bad instances out
* `Cost optimization` - you should provision just enough resources to run everything, and not more 
    * `Pay For Use`
        * `Right Sizing` - matching the service provisioning and configuration to your workload (e.g. choosing small EC2 instance)
        * `Serverless` - you only pay when code is executing (e.g. using Lambda)
        * 
    * `Cost Optimization Lifecycle`
