package com.example.myapplicationasdfsadf

import android.app.Activity
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import android.os.Bundle
import android.view.View
import android.widget.EditText
import com.jjoe64.graphview.GraphView
import com.jjoe64.graphview.series.DataPoint
import com.jjoe64.graphview.series.LineGraphSeries


class MainActivity : Activity(), SensorEventListener {
    private lateinit var series: LineGraphSeries<DataPoint>
    private var lastXPoint = 0.0

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        // Inicjalizacja GraphView i serii danych
        val graph = findViewById<GraphView>(R.id.graph)
        series = LineGraphSeries()
        graph.addSeries(series)
        graph.viewport.isScalable = true // umożliwia skalowanie i przewijanie
        graph.viewport.setScalableY(true)

        // Inicjalizacja sensora
        val sensorService = getSystemService(SENSOR_SERVICE) as
                SensorManager
        val sensorList = sensorService.getSensorList(Sensor.TYPE_ACCELEROMETER)
        if (sensorList.isNotEmpty()) {
            val acceleroMeter = sensorList[0]
            sensorService.registerListener(this, acceleroMeter, SensorManager.SENSOR_DELAY_GAME)
        }
    }


    override fun onSensorChanged(event: SensorEvent?) {
        // Tutaj aktualizujesz wartości EditText i dodajesz nowy punkt do serii
        event?.values?.let {
            val xValue = it[0] // Odczyt wartości X z sensora
            findViewById<EditText>(R.id.xName).setText(xValue.toString())

            // Dodawanie punktów danych do serii
            series.appendData(DataPoint(lastXPoint, xValue.toDouble()), true, 50)
            lastXPoint += 1.0
        }
    }

    override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {
        // Tutaj możesz zaimplementować reakcję na zmianę dokładności sensora, jeśli jest to potrzebne
    }
}



