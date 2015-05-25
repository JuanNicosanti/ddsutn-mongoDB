package dds.grupo9.queComemos.condicionPreexistente

import java.util.Collection
import dds.grupo9.queComemos.Preferencia
import dds.grupo9.queComemos.Receta
import dds.grupo9.queComemos.Persona

class Celiaco implements CondPreexistente {
	
	override boolean subsanaCondicion(Collection<Preferencia> gustos, String rutina, float peso){true}
	
	override boolean recetaNoRecomendada(Receta receta){false}
	
    override boolean verificaDatosSegunCondicion(Persona persona){true}			
}