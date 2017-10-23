select 
-- running and queued queries / no# of free query tasks = query pressure
-- scale : < 1 --> low pressure , 1 = equal pressure , > 1 depending on the capacity or pre defined volume. 
-- if the capacity is zero, a divide by zero exception will occur
-- useful to know if a query has the potential to run normally 
 (sum(state.num_queued_queries +  state.num_executing_queries ) )::float
 / 
 (  sum(config.num_query_tasks) -  
       (sum(state.num_queued_queries +  state.num_executing_queries )) 
 )::float as query_pressure
from
STV_WLM_CLASSIFICATION_CONFIG class,
STV_WLM_SERVICE_CLASS_CONFIG config,
STV_WLM_SERVICE_CLASS_STATE state
where
class.action_service_class = config.service_class
and class.action_service_class = state.service_class
and config.service_class > 4;


