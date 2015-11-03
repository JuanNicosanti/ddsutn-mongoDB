package dds.grupo9.queComemos.consultas

import java.util.Collection
import org.eclipse.xtend.lib.annotations.Accessors
import dds.grupo9.queComemos.Persona
import dds.grupo9.queComemos.Receta
import javax.persistence.Entity
import org.uqbar.commons.utils.Observable
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.Inheritance
import javax.persistence.InheritanceType


@Accessors
@Observable

abstract class Consulta extends ConsultaDecorada {
	
	@Accessors Persona persona
	@Accessors ConsultaDecorada decorado

	def getPersona() {
		this.persona
	}

	override Collection<Receta> resultado() {
		var Collection<Receta> lista = newHashSet()
		lista.addAll(this.filtrar(decorado.resultado))
		persona.setUltimasRecetasConsultadas(lista)
		lista
	}

	override Collection<Consulta> coleccionDeConsultas() {
		var Collection<Consulta> consultas = newHashSet();
		consultas.add(this);
		consultas.addAll(decorado.coleccionDeConsultas());
		return consultas
	}

	def Iterable<Receta> filtrar(Collection<Receta> recetas) //Cada consulta filtrará con su lógica
}
