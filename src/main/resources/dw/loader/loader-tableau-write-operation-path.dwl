vars.loaderDetails.tableau.outputDir as String
++ "/"
++ vars.metricsGroup as String
++ (if (vars.rawData == "true") "_raw_" else "_agg_")
++ ((vars.date as DateTime) as String {format: 'yyyyMMddHHmmssSSS'})
++ ".json"