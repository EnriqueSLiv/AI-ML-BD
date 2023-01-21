const width = 900
const height = 500
const margin = {
    top: 10, 
    bottom:40, 
    left:40, 
    right:10
}

const svg = d3.select("div#chart").append("svg").attr("width", width).attr("height", height)
const elementGroup = svg.append("g").attr("id", "elementGroup").attr("transform", `translate(${margin.left}, ${margin.top})`)
const axisGroup = svg.append("g").attr("id", "axisGroup")
const xAxisGroup = axisGroup.append("g").attr("id", "xAxisGroup").attr("transform", `translate(${margin.left}, ${height - margin.bottom})`)
const yAxisGroup = axisGroup.append("g").attr("id", "yAxisGroup").attr("transform", `translate(${margin.left}, ${margin.top})`)

const x = d3.scaleBand().range([0, width - margin.left - margin.right]).padding(0.1)
const y = d3.scaleLinear().range([height - margin.top - margin.bottom, 0])

const xAxis = d3.axisBottom().scale(x)
const yAxis = d3.axisLeft().scale(y).ticks(5)

d3.csv("WorldCup.csv").then(data => {
    console.log(data)

    data.map(d => {
        d.Year = +d.Year
    })

    let nest = d3.nest()
        .key(d => d.Winner)
        .entries(data)

    console.log(nest)
   
    nest.sort((a,b) => d3.descending(a.values, b.values))

    x.domain(nest.map(d => d.key))
    y.domain([0, d3.max(nest.map(d => d.values = d.values.length))])
   
    xAxisGroup.call(xAxis).selectAll("text").attr("transform", `rotate(${0})`).attr("text-anchor", "middle").attr("font-size", "15px")
    yAxisGroup.call(yAxis).attr("font-size", "15px")

    let WorldCup = elementGroup.selectAll("rect").data(nest)
    WorldCup.enter().append("rect")
        .attr("class", "Country")
        .attr("class", d => `country ${d.key}`)
        .attr("x", d => x(d.key))
        .attr("y", d => y(d.values))
        .attr("height", d => height - margin.top - margin.bottom - y(d.values))
        .attr("width", x.bandwidth())
        
})

 