<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> 
<%@ page language="java" import="java.sql.*" %>
<%@ page import="org.undp.database.*" %>
<%@ page import="org.undp.utils.*" %>
<%@ page import="org.undp.utils.arrays.*" %>
<%@ page import="org.undp.log.*" %>

<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	String p_country_id = request.getParameter("country_id");
	
	DynStringArray parameters = new DynStringArray();
	parameters.add(p_country_id);    
	DbResults db_country = Database.callProcResults("p_get_country_all_cols", parameters);
	DbResults _db_country_fact = Database.callProcResults("p_get_country_fact", parameters);
	
	String _code_3char = db_country.getRow(0).get(7);
	
	String noncore_prg_prelim_iwp_delivery_forecast = "";
	String prg_regular_resources_trac = "";
	String prg_delivery = "";
	String pct_iwp_delivery_target = "";
	String est_one_month_projected_spend = "";
	String est_cumm_projected_spend = "";
	String year = "";
	String month = "";
	String report_period_date = "";
	String target_delivery = "";

	if (_db_country_fact.hasRows()) {
		noncore_prg_prelim_iwp_delivery_forecast = _db_country_fact.getRow(0).get(2);
		prg_regular_resources_trac = _db_country_fact.getRow(0).get(3);
		prg_delivery = _db_country_fact.getRow(0).get(4);
		pct_iwp_delivery_target = _db_country_fact.getRow(0).get(5);
		est_one_month_projected_spend = _db_country_fact.getRow(0).get(6);
		est_cumm_projected_spend = _db_country_fact.getRow(0).get(7);
		year = _db_country_fact.getRow(0).get(8);
		month = _db_country_fact.getRow(0).get(9);
		report_period_date = _db_country_fact.getRow(0).get(10);
		target_delivery = _db_country_fact.getRow(0).get(11);		
	}

%>		


<script src="/cofiche/assets/js/jquery-2.1.0.min.js"></script>
<script defer src="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<script defer src="https://code.highcharts.com/highcharts.js"></script>
<script defer src="https://code.highcharts.com/highcharts-more.js"></script>
<script defer src="https://code.highcharts.com/modules/solid-gauge.js"></script>


	

<script type="text/javascript">

	$(function () {
		
			var strUrl = "/data/<%= _code_3char.toLowerCase() %>_container_irrf_res.json";
			
			$.getJSON(strUrl, function (data) {
				var stcOptions = {
					chart: {
						polar: true,
						type: 'line'
					},

					title: {
						text: 'Resources, Budget and Pipeline, and Utilization',
						x: -80
					},

					pane: {
						size: '80%'
					},

					xAxis: {
						categories: [],
						tickmarkPlacement: 'on',
						lineWidth: 0
					},

					yAxis: {
						gridLineInterpolation: 'polygon',
						lineWidth: 0,
						min: 0
					},

					tooltip: {
						shared: true,
						pointFormat: '<span style="color:{series.color}">{series.name}: <b>${point.y:,.0f}</b><br/>'
					},

					legend: {
						align: 'right',
						verticalAlign: 'top',
						y: 70,
						layout: 'vertical'
					},

					series: []
				};

				stcOptions.series = data[0].series;
				stcOptions.xAxis.categories = data[0].categories;
				// stcOptions.xAxis.labels.step = 2;
				//stcOptions.xAxis.labels.overflow = false;
				stcOptions.chart.renderTo = "container_irrf_res_spider";
				var IRRFByDevelopmentOutcomesSpider = new Highcharts.Chart(stcOptions);
			});

	});


	
	$(function () {
		var strUrl = "/data/<%= _code_3char.toLowerCase() %>_container_irrf_res.json";
		
		$.getJSON(strUrl, function (data) {
			var stcOptions = {
				chart: {
					defaultSeriesType: 'column'
				},
				title: { text: null },
				tooltip:
					{
        				valuePrefix: '$',
        				valueDecimals: 0,
        				shared: true
        			},
        		colors: [
        			//'#80699b', /* Targets */	
					'#4572A7',
					'#AA4643',
					'#89A54E'
				],
				xAxis: {
					categories: [], /* will get from server */
					title: {
						text: null
					},
					labels: {
						enabled: true
					}
				},
				yAxis: {
					//type: 'logarithmic',
					minorTickInterval: 'auto',
					min: 1,
					minorGridLineWidth: 0,
					gridLineWidth: 1,
					alternateGridColor: null,
					title: {
						text: null
					},
					labels: {
						enabled: true
					}
				},
				legend: {
					enabled: false
				},
				plotOptions: {
					series: {
						borderWidth: 0,
						cursor: 'pointer',
						point: {
							events: {
								click: function () {
									return false;
								}
							}
						}
					}
				},
				series: []
			};

			stcOptions.series = data[0].series;
			stcOptions.xAxis.categories = data[0].categories;
			// stcOptions.xAxis.labels.step = 2;
			//stcOptions.xAxis.labels.overflow = false;
			stcOptions.chart.renderTo = "container_irrf_res";
			var IRRFByDevelopmentOutcomes = new Highcharts.Chart(stcOptions);
		});
	});
</script>


<script type="text/javascript">

	var i=1;

	hexGradient = function (hex1, hex2, steps, filter) {
		if (typeof filter !== "function") {
			filter = function (val) {
				var buffer = "000000" + val.toString(16);
				return "#" + buffer.substring(buffer.length - 6, buffer.length);
			};
		}
		var newArry = [filter(hex1)];
		var r = hex1 >> 16;
		var g = hex1 >> 8 & 0xFF;
		var b = hex1 & 0xFF;
		var rd = (hex2 >> 16) - r;
		var gd = (hex2 >> 8 & 0xFF) - g;
		var bd = (hex2 & 0xFF) - b;
		steps++;
		for (var i = 1; i < steps; i++) {
			var ratio = i / steps;
			newArry.push(
		    	filter((r + rd * ratio) << 16 | (g + gd * ratio) << 8 | (b + bd * ratio))
		    );
		}
		newArry.push(filter(hex2));
		return newArry;
	};
	

    var total_fund_sources = 0; // container to calculate total
    var pieFundingSourcesOptions = {
    	chart: {
    		type: 'pie',
    		margin: [0, 0, 0, 0],
    		plotBackgroundColor: 'none',
    		plotBorderWidth: 0,
    		plotShadow: false,
    		events: {
    			load: function (event) {
    				$(".total_fund_sources").html('$' + Highcharts.numberFormat(total_fund_sources, 0, ','));
    				$('#container_fund_sources .highcharts-legend-item').last().append('<br/><div style="width:280px;font-size:8pt"><hr/><span style="float:left"> Total (US,$) </span><span style="float:right"> ' + Highcharts.numberFormat(total_fund_sources, 0, ',') + '</span> </div>')
    			},
    			redraw: function () {
    				$(".total_fund_sources").html('$' + Highcharts.numberFormat(total_fund_sources, 0, ','));
    				// find out if total is already set
    				if ($('#container_fund_sources .highcharts-legend-item').last().text().indexOf(' Total ') == -1) {
    					$('#container_fund_sources .highcharts-legend-item').last().append('<br/><div style="width:280px;font-size:8pt"><hr/><span style="float:left"> Total (US,$)</span><span style="float:right"> ' + Highcharts.numberFormat(total_fund_sources, 0, ',') + '</span> </div>')
    				}
    			},
    			addSeries: function () {
    				total_fund_sources = 0;
    				$('#container_fund_sources .highcharts-legend-item').last().remove();
    			}
    		}
    	},
    	title: {
    		text: null
    	},
    	subtitle: {
    		text: null
    	},
    	plotOptions: {
    		pie: {
    			// allowPointSelect: true,
    			size: 150,
    			cursor: 'pointer',
    			shadow: true,
    			center: [120, 100],
    			dataLabels: {
    				enabled: true,
    				color: '#000000',
    				// connectorColor: '#000000',
    				crop: false,
    				distance: 15,
    				// connectorWidth: 0.5,
    				// connectorColor: '#000000',
    				formatter: function () {
    					if ((this.y === 0) || (this.y == null)) return null;
    					if (this.percentage == 100) return null;
    					return '<b>' + Highcharts.numberFormat(this.percentage, 2, '.') + '</b>%';
    				}
    			},
    			showInLegend: true
    		},
    		series: {
    			borderWidth: 0.5,
    			cursor: 'pointer',
    			colorByPoint: true,
    			point: {
    				events: {
    					click: function () {
    						var urlParams = {};
    						urlParams["hq_co"] = "CO";
    						urlParams["bureau"] = "RBLAC";
    						urlParams["unit"] = "CUB";
    						urlParams["year"] = "2016";
    						fncUrlChange(null, urlParams, 'ResourcesByCategorySummary.aspx');
    					}
    				}
    			}
    		}
    	},
    	legend: {
    		style: {
    			left: "auto",
    			bottom: "auto",
    			right: "0px",
    			top: "0px",
    			fontFamily: "Tahoma"
    		},
    		y: 25,
    		layout: "vertical",
    		align: "right",
    		verticalAlign: "top",
    		backgroundColor: "#FFFFFF",
    		borderColor: "#CCCCCC",
    		borderWidth: 0,
    		useHTML: true,
    		shadow: false,
    		width: 290,
    		itemStyle: {
    			fontSize: "8pt"
    		},
    		labelFormatter: function () {
    			total_fund_sources += this.options.y;
    			return '<div style="width:260px"><span style="float:left">' + this.name + '</span><span style="float:right">' + Highcharts.numberFormat(this.options.y, 0, ',') + '</span></div>';
    		}
    	},
    	tooltip: {
    		formatter: function () {
    			return '' + this.point.name + '<br/>' +
                    '<em>' + this.series.name + '</em>' +
                    ': <b>$' + Highcharts.numberFormat(this.point.options.y, 0, ',') +
                    '</b> (' + Highcharts.numberFormat(this.percentage, 2, '.') + '%)';
    		},
    		style: {
    			font: 'normal 10px Verdana, sans-serif'
    		}
    	},
    	series: [{
    		type: 'pie',
    		name: 'Resources',
    		data: []
    	}]
    };

    $(function () {
    	var fundsource_finances;
    	var fundsource_fin_data = [];

    	// var strUrl = "/_layouts/execsnapshot/ajax/reportdata.aspx?rid=28&";
    	// var strUrlParams = "year=2016&hq_co=CO&bureau=RBLAC&unit=cub&fund_code=&pid=";
    	// strUrl = strUrl + strUrlParams;
    	var strUrl = "/data/<%= _code_3char.toLowerCase() %>_container_fund_sources.json";
    	// strUrl = strUrl + strUrlParams;
    	$.getJSON(strUrl, function (data) {
    		fundsource_fin_data = data;
			i++;
			
    		// alert("I = " + i);

    		$(fundsource_fin_data[0].fund_categories).each(function () {
    			$("#fundCategory").append($('<option></option>').val(this.value).html(this.label));
				// alert($("#fundCategory").val());
				
				
    		});

    		if (fundsource_fin_data[0].prgresdata.length > 0) {
    			pieFundingSourcesOptions.series[0].data = fundsource_fin_data[0].prgresdata;
    			pieFundingSourcesOptions.series[0].colors = hexGradient(0x4572a7, 0x043861, fundsource_fin_data[0].prgresdata.length);
    		}
    		else if (fundsource_fin_data[0].devresdata.length > 0) {
    			pieFundingSourcesOptions.series[0].data = fundsource_fin_data[0].devresdata;
    			pieFundingSourcesOptions.series[0].colors = hexGradient(0x4572a7, 0x043861, fundsource_fin_data[0].devresdata.length);
    		}
    		else if (fundsource_fin_data[0].mgtresdata.length > 0) {
    			pieFundingSourcesOptions.series[0].data = fundsource_fin_data[0].mgtresdata;
    			pieFundingSourcesOptions.series[0].colors = hexGradient(0x4572a7, 0x043861, fundsource_fin_data[0].mgtresdata.length);
    		}
    		else if (fundsource_fin_data[0].spcresdata.length > 0) {
    			pieFundingSourcesOptions.series[0].data = fundsource_fin_data[0].spcresdata;
    			pieFundingSourcesOptions.series[0].colors = hexGradient(0x4572a7, 0x043861, fundsource_fin_data[0].spcresdata.length);
    		}
    		else if (fundsource_fin_data[0].crdresdata.length > 0) {
    			pieFundingSourcesOptions.series[0].data = fundsource_fin_data[0].crdresdata;
    			pieFundingSourcesOptions.series[0].colors = hexGradient(0x4572a7, 0x043861, fundsource_fin_data[0].crdresdata.length);
    		}

    		pieFundingSourcesOptions.chart.renderTo = "container_fund_sources";
    		fundsource_finances = new Highcharts.Chart(pieFundingSourcesOptions);
			//fundsource_finances=$("#container_fund_sources").highcharts();
    	});

    	$('#fundSourceFinTypeList').change(function () {
    		var fundsourcefinDataType = $('#fundSourceFinTypeList').val();
    		var selFundCategory = $('#fundCategory').val();
    		
    		fundsource_finances.series[0].remove(false);
    		var fundTypeSelection = selFundCategory + '-' + fundsourcefinDataType;
    		addChartSeries(fundTypeSelection, fundsource_finances, fundsourcefinDataType, fundsource_fin_data);
    	});

    	$('#fundCategory').change(function () {
    		var fnsrsfinDataType = $('#fundSourceFinTypeList').val();
    		var fnsrsfundCategory = $('#fundCategory').val();
    	
    		fundsource_finances.series[0].remove(false);
    		var fnsrsfundTypeSelection = fnsrsfundCategory + '-' + fnsrsfinDataType;
    		addChartSeries(fnsrsfundTypeSelection, fundsource_finances, fnsrsfinDataType, fundsource_fin_data);
    	});
    });

    function addChartSeries(fundTypeSelection, fundsource_finances, fundsourcefinDataType, fundsource_fin_data) {
        switch (fundTypeSelection) {
            // color shade: blue         
            case 'Programme-Resources':
                fundsource_finances.addSeries({ type: 'pie', name: fundsourcefinDataType, data: fundsource_fin_data[0].prgresdata, colors: hexGradient(0x4572a7, 0x043861, fundsource_fin_data[0].prgresdata.length) });
                break;
            case 'Development Effectiveness-Resources':
                fundsource_finances.addSeries({ type: 'pie', name: fundsourcefinDataType, data: fundsource_fin_data[0].devresdata, colors: hexGradient(0x4572a7, 0x043861, fundsource_fin_data[0].devresdata.length) });
                break;
            case 'Management-Resources':
                fundsource_finances.addSeries({ type: 'pie', name: fundsourcefinDataType, data: fundsource_fin_data[0].mgtresdata, colors: hexGradient(0x4572a7, 0x043861, fundsource_fin_data[0].mgtresdata.length) });
                break;
            case 'Special Purpose-Resources':
                fundsource_finances.addSeries({ type: 'pie', name: fundsourcefinDataType, data: fundsource_fin_data[0].spcresdata, colors: hexGradient(0x4572a7, 0x043861, fundsource_fin_data[0].spcresdata.length) });
                break;
            case 'UN Coordination-Resources':
                fundsource_finances.addSeries({ type: 'pie', name: fundsourcefinDataType, data: fundsource_fin_data[0].crdresdata, colors: hexGradient(0x4572a7, 0x043861, fundsource_fin_data[0].crdresdata.length) });
                break;
            // color shade: red         
            case 'Programme-Budget':
                fundsource_finances.addSeries({ type: 'pie', name: fundsourcefinDataType, data: fundsource_fin_data[0].prgbuddata, colors: hexGradient(0xc27f7d, 0x690a07, fundsource_fin_data[0].prgbuddata.length) });
                break;
            case 'Development Effectiveness-Budget':
                fundsource_finances.addSeries({ type: 'pie', name: fundsourcefinDataType, data: fundsource_fin_data[0].devbuddata, colors: hexGradient(0xc27f7d, 0x690a07, fundsource_fin_data[0].devbuddata.length) });
                break;
            case 'Management-Budget':
                fundsource_finances.addSeries({ type: 'pie', name: fundsourcefinDataType, data: fundsource_fin_data[0].mgtbuddata, colors: hexGradient(0xc27f7d, 0x690a07, fundsource_fin_data[0].mgtbuddata.length) });
                break;
            case 'Special Purpose-Budget':
                fundsource_finances.addSeries({ type: 'pie', name: fundsourcefinDataType, data: fundsource_fin_data[0].spcbuddata, colors: hexGradient(0xc27f7d, 0x690a07, fundsource_fin_data[0].spcbuddata.length) });
                break;
            case 'UN Coordination-Budget':
                fundsource_finances.addSeries({ type: 'pie', name: fundsourcefinDataType, data: fundsource_fin_data[0].crdbuddata, colors: hexGradient(0xc27f7d, 0x690a07, fundsource_fin_data[0].crdbuddata.length) });
                break;
            // color shade: green         
            case 'Programme-Utilization':
                fundsource_finances.addSeries({ type: 'pie', name: fundsourcefinDataType, data: fundsource_fin_data[0].prgutldata, colors: hexGradient(0x89a54e, 0x304502, fundsource_fin_data[0].prgutldata.length) });
                break;
            case 'Development Effectiveness-Utilization':
                fundsource_finances.addSeries({ type: 'pie', name: fundsourcefinDataType, data: fundsource_fin_data[0].devutldata, colors: hexGradient(0x89a54e, 0x304502, fundsource_fin_data[0].devutldata.length) });
                break;
            case 'Management-Utilization':
                fundsource_finances.addSeries({ type: 'pie', name: fundsourcefinDataType, data: fundsource_fin_data[0].mgtutldata, colors: hexGradient(0x89a54e, 0x304502, fundsource_fin_data[0].mgtutldata.length) });
                break;
            case 'Special Purpose-Utilization':
                fundsource_finances.addSeries({ type: 'pie', name: fundsourcefinDataType, data: fundsource_fin_data[0].spcutldata, colors: hexGradient(0x89a54e, 0x304502, fundsource_fin_data[0].spcutldata.length) });
                break;
            case 'UN Coordination-Utilization':
                fundsource_finances.addSeries({ type: 'pie', name: fundsourcefinDataType, data: fundsource_fin_data[0].crdutldata, colors: hexGradient(0x89a54e, 0x304502, fundsource_fin_data[0].crdutldata.length) });
                break;
            default:
                //fundsource_finances.addSeries({ type: 'pie', name: fundsourcefinDataType, data: fundsource_fin_data[0].prgresdata, colors: hexGradient(0x89a54e, 0x304502, fundsource_fin_data[0].prgresdata.length) });
                break;
        }
    }
</script>


<script type="text/javascript">
$(function () {
	
	$('#container-speed').highcharts({
		chart: {
				type: 'gauge',
				plotBackgroundColor: null,
				plotBackgroundImage: null,
				plotBorderWidth: 0,
				plotShadow: false
		},
		credits:{enabled:false},
		exporting:{enabled:false},
		title: {
			text: 'As of <%= report_period_date %>'
		},			 
		pane: {
			startAngle: -140,
			endAngle: 140,
			background: null
		},		
		plotOptions: {
			gauge: {
				 dataLabels: {
						enabled: true,
						y: 105,
						borderWidth: 0,
						useHTML: true
			 },
				 dial: {
						baseLength: '0%',
						baseWidth: 5,
						radius: '100%',
						rearLength: '0%',
						topWidth: 1
				 }
			}
		},
		yAxis:{
			gridLineWidth: 0,
			labels: { 
				 step: 2,
				 //rotation: 'auto',
				 distance: 12,
				 y: 0,
				 formatter:function(){
						if (this.isLast){
							return this.value + ' %';
						}
						else{
							return this.value;
						}
				}
			},
			minorTickInterval: 'auto', minorTickWidth: 1, minorTickLength: 10, minorTickPosition: 'inside', minorTickColor: '#fff',
			tickPixelInterval: 30, tickWidth: 2, tickPosition: 'inside', tickLength: 10, tickColor: '#fff',
			min: 0,
			max: 100,
			plotBands: [
				{from: 10,to: 100, color: 'rgb(155, 187, 89)', thickness: '50%'},  // green
				{from: 6, to: 10, color: 'rgb(255, 192, 0)', thickness: '50%'}, // yellow
				{from: 0, to: 6, color: 'rgb(192, 0, 0)', thickness: '50%'} // red
			]
		},
    	tooltip: {
    		formatter: function () {
    			return '<strong>' + this.series.name + ' = ' + '<%= pct_iwp_delivery_target %>%'+ '</strong><br/>' +
                    '<em> Target Deliver: $' + Highcharts.numberFormat(<%= target_delivery %>,0,',') + '</em><br/>' +
					'<em> Non-Core Programme Preliminary IWP Delivery Forecast: $' + Highcharts.numberFormat(<%= noncore_prg_prelim_iwp_delivery_forecast %>,0,',') + '</em><br/>' +
					'<em> Programme Regular Resources TRAC: $' + Highcharts.numberFormat(<%= prg_regular_resources_trac %>,0,',') + '</em><br/>' +
					'<em> Programme Delivery: $' + Highcharts.numberFormat(<%= prg_delivery %>,0,',') + '</em>';
    		},
    		style: {
    			font: 'normal 10px Verdana, sans-serif'
    		}
    	},
		series: [{
			name: '% IWP Delivery Target',
			data: [<%= pct_iwp_delivery_target %>],
			dataLabels: {
				 format: '<div style="text-align:center"><span style="font-size:12px;color:black">{y:.2f}%</span><br/><span style="font-size:10px;color:#333;">Indicator value</span></div>'
			},
			tooltip: {
				 valueSuffix: '%'
			},
			wrap: false
		}] 
	}); 
});

</script>
