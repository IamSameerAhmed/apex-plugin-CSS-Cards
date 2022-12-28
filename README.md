# apex-plugin-CSS-Cards
This plugin is based on HTML CSS to give your finance Dashboard Summary Cards .


<h2>Here is the quick view of plugin.</h2>


![image](https://user-images.githubusercontent.com/121421319/209770928-b1e0ca79-1939-4bb6-b690-e356a46a1e71.png)

</br>
</br>

<h2>The SQl Query Format should be like </h2>
</br>
<code>select label,
value,
Prev_value
from table
order by value</code></br>
  
<b>Label</b> is the label ...</br>
<b>Value</b> is the value ... and has to be of type NUMBER</br>
<b>Previous Value</b> Prev Value is the value on which the Percentage has been calculated ... and has to be type NUMBER</br>

  </br>



<h3>These are the attributes of Plugin<h3> .
</br>

![image](https://user-images.githubusercontent.com/121421319/209767007-48fda96b-6d90-4d73-bc68-78f62027edb4.png)



<h2>Prefix for Value</h2>
Specify the prefix which should be added to the displayed value.

<h2>Postfix for Percentage</h2>
Specify the postfix which should be added after the percentage value.

<h2>Page Items to Submit</h2>
Specify a comma separated list of page items that will be submitted to the server and thus, available for use from within your region source SQL statement.

<h2>Maximum Rows</h2>
Defines the maximum number of rows to query and to display.

<h2>Add percentage Area.</h2>
To include or disclude the area carries the percentage.

<h2>Display As.</h2>
This Option use to set the float of cards.

<h2>Link.</h2>
This option use to redirect to your cards to any application page.
  
</br>
<h3>here is Demo.</h3>
https://apex.oracle.com/pls/apex/r/smdashboard/css-cards-plugin/financial-statement?session=6730073886799




