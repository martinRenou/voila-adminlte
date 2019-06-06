<!DOCTYPE html>
<html>
  <head>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/admin-lte/2.4.10/js/adminlte.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/admin-lte/2.4.10/css/AdminLTE.min.css" rel="stylesheet" type='text/css'>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/admin-lte/2.4.10/css/skins/_all-skins.min.css" rel="stylesheet" type='text/css'>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" type='text/css'>
    <link href="https://unpkg.com/font-awesome@4.5.0/css/font-awesome.min.css" rel="stylesheet" type='text/css'>
    <link href="{{resources.base_url}}voila/static/index.css" rel="stylesheet" type='text/css'>
    <link href="{{resources.base_url}}voila/static/theme-light.css" rel="stylesheet" type='text/css'>
    <script src="{{resources.base_url}}voila/static/require.min.js" integrity="sha256-Ae2Vz/4ePdIu6ZyI/5ZGsYnb+m0JlOmKPjt6XZ9JJkA=" crossorigin="anonymous"></script>
    <script>
        {% include "util.js" %}
    </script>
    <script>
        requirejs.config({
          baseUrl: '{{resources.base_url}}voila',
          waitSeconds: 3000
        });
        requirejs(['static/voila'], (voila) => init(voila));
        requirejs([
          {% for ext in resources.nbextensions -%}
            "{{resources.base_url}}voila/nbextensions/{{ ext }}.js",
          {% endfor %}
        ]);
    </script>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
  </head>

  <body class="skin-blue" data-base-url="{{resources.base_url}}voila/">
      <!-- Main Header -->
      <header class="main-header">

        <!-- Logo -->
        <a href="https://github.com/QuantStack/voila/" class="logo">
          <!-- mini logo for sidebar mini 50x50 pixels -->
          <span class="logo-mini"><b>Voila</b></span>
          <!-- logo for regular state and mobile devices -->
          <span class="logo-lg"><b>Voila!</b></span>
        </a>

        <!-- Header Navbar -->
        <nav class="navbar navbar-static-top" role="navigation">
          <!-- Sidebar toggle button-->
          <a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button">
            <span class="sr-only">Toggle navigation</span>
          </a>
        </nav>
      </header>

      <!-- Left side column. contains the logo and sidebar -->
      <aside class="main-sidebar">

          <!-- sidebar: style can be found in sidebar.less -->
          <section class="sidebar">

            <!-- Sidebar Menu -->
            <ul class="sidebar-menu" data-widget="tree">
              <li class="header">Folders</li>

              {% if breadcrumbs|length > 1: %}
                <li><a href="{{breadcrumbs[-2][0]}}"><i class="fa fa-folder"></i>..</a></li>
              {% endif %}

              {% for content in resources.contents.content %}
                {% if content.type == 'notebook' %}
                  {% if content.path == resources.notebook_name %}
                    <li class="active"><a href="{{resources.base_url}}voila/render/{{content.path}}"><i class="fa fa-book"></i>{{content.name}}</a></li>
                  {% else %}
                    <li><a href="{{resources.base_url}}voila/render/{{content.path}}"><i class="fa fa-book"></i>{{content.name}}</a></li>
                  {% endif %}
                {% endif %}
                {% if content.type == 'directory' %}
                  <li><a href="{{resources.base_url}}voila/tree/{{content.path}}"><i class="fa fa-folder"></i>{{content.name}}</a></li>
                {% endif %}
              {% endfor %}
            </ul>
            <!-- /.sidebar-menu -->

          </section>
          <!-- /.sidebar -->
      </aside>

      <div class="content-wrapper" style="overflow-y: scroll">
          <section class="content">
            <div class="row">
              <div class="col-xs-5">
                  <div class="box box-success">
                      <div class="box-header with-border">
                        <h3 class="box-title">Content 1</h3>
                        <div class="box-tools">
                          <!-- This will cause the box to collapse when clicked -->
                          <button class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse"><i class="fa fa-minus"></i></button>
                        </div>
                        <!-- /.box-tools -->
                      </div>
                      <!-- /.box-header -->
                      <div class="box-body">
                        <div>
                            <!-- A widget with the attribute data-mount-id="content1" should go here -->
                            <div data-mount-id="content1"></div>
                        </div>
                      </div>
                      <!-- /.box-body -->
                      <div class="box-footer">
                      </div>
                      <!-- box-footer -->
                  </div>
                </div>

                <div class="col-xs-5">
                  <!-- /.box -->
                  <div class="box box-warning">
                      <div class="box-header with-border">
                        <h3 class="box-title">Content 2</h3>
                        <div class="box-tools">
                          <!-- This will cause the box to collapse when clicked -->
                          <button class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse"><i class="fa fa-minus"></i></button>
                        </div>
                        <!-- /.box-tools -->
                      </div>
                      <!-- /.box-header -->
                      <div class="box-body">
                        <div>
                            <!-- A widget with the attribute data-mount-id="content2" should go here -->
                            <div data-mount-id="content2"></div>
                        </div>
                      </div>
                      <!-- /.box-body -->
                      <div class="box-footer">
                      </div>
                      <!-- box-footer -->
                  </div>
                  <!-- /.box -->
                </div>
              </div>
            </div>
        </section>
    </div>
  </body>

  <script id="jupyter-config-data" type="application/json">
    {
      "baseUrl": "{{resources.base_url}}",
      "kernelId": "{{resources.kernel_id}}"
    }
  </script>
</html>

