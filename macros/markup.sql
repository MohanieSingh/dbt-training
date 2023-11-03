{% macro markup(sellingprice, costprice) %}                 -- create a macro called markup

    ({{sellingprice}} - {{costprice}}) / {{costprice}}

{% endmacro %}                                              -- end the macro we created