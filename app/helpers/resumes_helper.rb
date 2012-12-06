module ResumesHelper
	def frequency_distribution_chart(data, div_id = nil)
		string = ""

		# Load the visualization API and the piechart package
string << "google.load('visualization', '1.0', {'packages':['corechart']});"

		# Set a callback to run when the Google Visualization API is loaded
string << "google.setOnLoadCallback(drawChart);"
string << "function drawChart() {"
			  # Create and populate the data table
string << "var data = new google.visualization.DataTable();"
string << "data.addColumn('string', 'Topping');"
string << "data.addColumn('number', 'Slices');"
string << "data.addRows([['Mushrooms', 3],['Onions', 1],['Olives', 1],['Zucchini', 1],['Pepperoni', 2],['','']]);"
#				data.each do |key, value|
#					string << "['#{key.to_s}',  #{value}],"
#				end

string << "var options = {'title':'How Much Pizza I Ate Last Night','width':400,'height':300};"
string << "var chart = new google.visualization.PieChart(document.getElementById('chart_div'));"
string << "chart.draw(data, options);"
string << "}"
		return string
	end
end

