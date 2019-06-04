<!DOCTYPE html>
<html>
    <head>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/admin-lte/2.4.10/js/adminlte.min.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/admin-lte/2.4.10/css/AdminLTE.min.css" rel="stylesheet">
        <script src="{{resources.base_url}}voila/static/require.min.js" integrity="sha256-Ae2Vz/4ePdIu6ZyI/5ZGsYnb+m0JlOmKPjt6XZ9JJkA=" crossorigin="anonymous"></script>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
    </head>

    <body data-base-url="{{resources.base_url}}voila/">
        <script>
            {% include "util.js" %}
        </script>

        {% include "app.html" %}
    </body>

    <script id="jupyter-config-data" type="application/json">
        {
          "baseUrl": "{{resources.base_url}}",
          "kernelId": "{{resources.kernel_id}}"
        }
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
</html>

