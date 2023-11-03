{% macro limit_data_in_dev(columname) %}                                -- create a macro called limit_data_in_dev(argument)

    {% if target.name == 'development' %}                               -- create if statement
        where {{columnname}} >= dateadd('day', -30, current_timestamp)  -- if we're in development branch show me the last 30 days for the column i'm calling
    {% endif %}                                                         -- end the if statement

{%endmacro%}                                                            -- end the macro we created