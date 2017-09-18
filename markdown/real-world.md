<!-- .slide: data-background="images/world.jpg" data-transition="slide" data-background-transition="fade" -->
<p class="source">
(Real) World</p><br><br><br><br><br>
<img data-src="images/real-world-demo.png" width="100%" height="100%">
[https://github.com/npalm/tf-ecs-demo](https://github.com/npalm/tf-ecs-demo)

!SUB
### <strong>Build</strong> - <strong>Ship</strong> - Run
- Java based micro service <!-- .element: class="fragment" -->
- Build with Gradle + Docker <!-- .element: class="fragment" -->
- Ship Docker image <!-- .element: class="fragment" -->

<pre class="fragment"><code class="dockerfile">
FROM openjdk:8u121-jdk-alpine AS build

RUN ./gradlew build

FROM openjdk:8u121-jre-alpine
COPY --from=build /build/libs/service.jar /app/service.jar

EXPOSE 8080
CMD java -jar /app/service.jar
</code></pre>


!SUB
### Build - Ship - <strong>Run</strong>
<img data-src="images/personal-containers.jpg">

!SUB
### Build - Ship - <strong>Run</strong>
<img data-src="images/ship.jpg" width="66%" height="66%">


!SUB
### Build - Ship - <strong>Run</strong>
<img data-src="images/vpc-white.png">


!SUB
### VPC
<pre class="fragment"><code>
resource "aws_vpc" "vpc" {
   ...
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = "${aws_vpc.vpc.id}"
  ...
}

resource "aws_nat_gateway" "nat" {
  ...
}
</code></pre>

!SUB
### Subnets
<pre class="fragment"><code>
resource "aws_route_table" "routetable" {
  vpc_id = "${aws_vpc.vpc.id}"
  ...
}

resource "aws_subnet" "subnet" {
  vpc_id = "${aws_vpc.vpc.id}"
  ...
}

resource "aws_route_table_association" "public_routing_table" {
  ...
}
</code></pre>

!SUB
### Modules
<pre class="fragment"><code>
module "vpc" {
  source = "git::https://github.com/npalm/tf-aws-vpc.git?ref=1.0.0"

  aws_region  = "eu-central-1"

  // optional, example
  availability_zones = {
    eu-central-1 = ["eu-central-1a",  "eu-central-1c"]
  }
}
</code></pre>

<div class="fragment">
<i class="fa fa-star fa-1g" aria-hidden="true"></i> Abstract common parts to **versioned** modules
</div>



!SUB
### Organize Code
<div align="left">
<ul>
<li class="fragment">One repo per external module</li>
<li class="fragment">One repo per artifact</li>
<li class="fragment">Organize terraform code </li>
</ul>
</div>


<pre class="fragment"><code>
&#9507&#9473&#9473 README.md
&#9507&#9473&#9473 module
&#9475   &#9507&#9473&#9473 main.tf
&#9475   &#9507&#9473&#9473 outputs.tf
&#9475   &#9495&#9473&#9473 variables.tf
&#9507&#9473&#9473 main.tf
&#9507&#9473&#9473 outputs.tf
&#9507&#9473&#9473 terraform.tfvars
&#9495&#9473&#9473 variables.tf
</code></pre>

<div align="left" class="fragment">
<i class="fa fa-star fa-1g" aria-hidden="true"></i> `terraform validate` can **validate** the code
</div>
<div align="left" class="fragment">
<i class="fa fa-star fa-1g" aria-hidden="true"></i> linters can **validate** and check **best practices**
</div>



<!-- !SUB
# DEMO
<img data-src="images/giphy-programming.gif" height="60%" width="60%"> -->

!SUB
# **PLAN**
<!-- .slide: class="vpcPlan" data-background-video="videos/terraform-ecs-demo-vpc-plan.mp4" data-transition="slide" data-background-transition="fade"   data-background-size="contain" data-background-color="#000000" -->

!SUB
# **APPLY**
<!-- .slide: class="vpcApply" data-background-video="videos/terraform-ecs-demo-vpc-apply.mp4" data-transition="slide" data-background-transition="fade"   data-background-size="contain" data-background-color="#000000" -->


!SUB
### Build - Ship - **Run**
<img data-src="images/vpc-white.png">

!SUB
### Build - Ship - **Run**
<img data-src="images/ecs-white.png">


!SUB
### ECS Cluster
<small>
- aws_autoscaling_group, aws_launch_configuration, aws_security_group
- aws_ecs_cluster
- aws_iam_role_policy and aws_iam_role
- aws_cloudwatch_log_group

</small>

<div class="fragment">So again wrap to a module</div>

<pre class="fragment"><code>
module "ecs-cluster" {
  source      = "ecs-cluster"
  aws_region  = "${var.aws_region}"

  vpc_id   = "${module.vpc.vpc_id}"
  vpc_cidr = "${module.vpc.vpc_cidr}"
  subnets  = "${module.vpc.private_subnets}"
}
</code></pre>



!SUB
### ECS Service
<small>
- aws_ecs_task_definition aws_ecs_service
- aws_alb_target_group aws_alb aws_alb_listener
- aws_cloudwatch_log_group

</small>

<pre class="fragment"><code>
module "graphql" {
  source      = "ecs-service"
  aws_region  = "${var.aws_region}"

  cluster_id     = "${module.ecs-cluster.cluster_id}"
  service_name   = "graphql"
  image_url      = "npalm/graphql-demo:release-1.0.0"

  vpc_id  = "${module.vpc.vpc_id}"
  subnets = "${module.vpc.public_subnets}"
}
</code></pre>

!SUB
<div align="left"  class="fragment">
<i class="fa fa-star fa-1g" aria-hidden="true"></i> Choose **defaults** when possible for modules
</div>
<br><br>

<div align="left"  class="fragment">
<i class="fa fa-star fa-1g" aria-hidden="true"></i> Hack your way with **conditionals**
<pre><code>
count = "${var.enable_bastion ? 1 : 0}"
</pre></code>

</div>



!SUB
# **PLAN**
<!-- .slide: class="ecsPlan" data-background-video="videos/terraform-ecs-demo-ecs-plan.mp4" data-transition="slide" data-background-transition="fade" data-background-size="contain" data-background-color="#000000" -->


!SUB
# **Apply**
<!-- .slide: class="ecsApply" data-background-video="videos/terraform-ecs-demo-ecs-apply.mp4" data-transition="slide" data-background-transition="fade" data-background-size="contain" data-background-color="#000000" -->


!SUB
<!-- .slide: data-background="images/change.jpg" data-transition="none" data-background-transition="fade" -->
<bold>
<h1 align="right" style="color:red;">SCALE</h1>
</bold>

!SUB
# DEMO
<img data-src="images/giphy-bart.gif" height="60%" width="60%">

!SUB
# **PLAN**
<!-- .slide: class="ecsPlan" data-background-video="videos/terraform-ecs-demo-scale-plan.mp4" data-transition="slide" data-background-transition="fade" data-background-size="contain" data-background-color="#000000" -->


!SUB
# **Apply**
<!-- .slide: class="ecsApply" data-background-video="videos/terraform-ecs-demo-scale-apply.mp4" data-transition="slide" data-background-transition="fade" data-background-size="contain" data-background-color="#000000" -->

<!--
!SUB
## Service Discovery
<img data-src="images/ecs-discovery.png"  height="150%" width="150%"> -->
