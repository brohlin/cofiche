/**
 * PNDU theme for Highcharts JS
 * @author Diana O
 */

Highcharts.theme = {

	colors: ["#ff5c24", "#712e8e", "#2051E6", "#E38644", "#1F949A", "#599FEB", "#86777F", "#42A07B"],
	chart: {
		className: 'indica',
		borderWidth: 0,
		backgroundColor:'rgba(255, 255, 255, 0.1)',
		plotBorderWidth: 0, //null,
		plotShadow: false,
		spacingTop: 30,
		fontFamily: 'Lato',
		width: 350,
		

	},
	title: {
		style: {
			color: '#222',
			font: '24px Roboto Condensed, Lucida Sans Unicode, Verdana, Arial, Helvetica, sans-serif',
			fontWeight: '400',
			itemMarginTop: 30,
        itemMarginBottom: 10
		}
	},
	subtitle: {
		style: {
			color: '#333',
			font: '16px Lato, Lucida Sans Unicode, Verdana, Arial, Helvetica, sans-serif'
		},
		itemMarginTop: 30,
        itemMarginBottom: 10
	},
	xAxis: {
		gridLineWidth: 0,
		lineColor: '#C0D0E0',
		tickColor: '#C0D0E0',
		labels: {
			style: {
				color: '#333',
				font: '12px Lato, Lucida Sans Unicode, Verdana, Arial, Helvetica, sans-serif',
				fontWeight: ''
			}
		},
		title: {
			style: {
				color: '#666',
				font: '12px Lato, Lucida Sans Unicode, Verdana, Arial, Helvetica, sans-serif'
			}
		}
	},
	yAxis: {
		gridLineWidth: 1,
		alternateGridColor: 'rgba(255, 255, 255, .5)',
		lineColor: '#C0D0E0',
		tickColor: '#C0D0E0',
		tickWidth: 1,
		labels: {
			y: 20,
			style: {
				color: '#333',
				fontWeight: 'normal',
							}
		},
		title: {
			style: {
				color: '#666',
				font: '12px Lato, Lucida Sans Unicode, Verdana, Arial, Helvetica, sans-serif'
			}

		}
	},
	legend: {
		itemStyle: {
			font: '12pt Lato, Verdana, sans-serif',
			color: '#333',
		},
		itemMarginBottom: 15,
       

		itemHoverStyle: {
			color: 'black'
		},
		itemHiddenStyle: {
			color: 'silver'
		}
	},
	labels: {
		style: {
			color: '#3E576F'
		}
	}
};

// Apply the theme
var highchartsOptions = Highcharts.setOptions(Highcharts.theme);