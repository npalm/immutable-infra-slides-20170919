<!-- .slide: data-background="images/infra-as-code.png" data-transition="slide" data-background-transition="fade" -->
<br><br>
<h1>Infrastucture<br>As<br>Code</h1>

<!-- !SUB
<img data-src="images/configuration-managers.png">
Configuration<br>
<div class="fragment">
  <div>
  <strong>VS</strong><br>
  Orchestration
  </div>å
  <img data-src="images/orchestration.png">
</div>
 -->

!NOTE
Configuration management” tools are designed to install and manage software on existing servers. Orchestration tools are designed to provision the servers themselves, leaving the job of configuring those servers to other tools


<!-- !SUB
### Procedural <strong>vs</strong> Declarative
<table class="reveal">
  <tr>
    <td class="fragment"><img data-src="images/ansible-proc1.png"></td>
    <td class="fragment"><img data-src="images/tf-decl1.png"></td>
  </tr>
</table>
<div class="fragment">
<p class="source">
SCALE -> 15
</p>
</div>
<table class="reveal">
  <tr>
    <td class="fragment"><img data-src="images/ansible-proc2.png"></td>
    <td class="fragment"><img data-src="images/tf-decl2.png"></td>
  </tr>
</table> -->


!SUB
### An **Immutable infrastructure** is a composition of immutable components and is predictable, scalable and automated



!SUB
## Immutable artifacts

<img data-src="images/inmutable-builds-w.png">



!SLIDE
## Terraform
<img data-src="images/terraform-overview.png">



!NOTE
Terraform enables you to safely and predictably create, change, and improve production infrastructure. It is an open source tool that codifies APIs into declarative configuration files that can be shared amongst team members, treated as code, edited, reviewed, and versioned.

!SUB
## Write

The most important thing you'll configure with Terraform are <strong>resources</strong>.

!SUB
## Write
<strong>Providers</strong> are responsible in Terraform for managing the lifecycle of a resource.

<img data-src="images/providers.png">

!SUB
## Write
With **input variables** terraform script can be parametrized. <div class="fragment">**Output variables** are a way to query and show data back to the user.</div>


!SUB
## Write
The syntax of Terraform configurations is called <strong>HashiCorp Configuration Language (HCL)</strong>.

<pre class="fragment"><code>
# creates an AWS instance
resource "aws_instance" "web" {
  ami               = "my-ami"
  count             = ${var.number_of_instances}
}
</code></pre>


!NOTE
 It is meant to strike a balance between human readable and editable as well as being machine-friendly. For machine-friendliness.


!SUB
## Plan
<img data-src="images/tf-plan.png">

!SUB
## Apply
<img data-src="images/tf-apply.png">
