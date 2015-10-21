package dds.grupo9.queComemos.controller

import org.eclipse.xtend.lib.annotations.Data
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Collection
import dds.grupo9.queComemos.condicionPreexistente.CondPreexistente
import dds.grupo9.queComemos.Receta
import dds.grupo9.queComemos.Persona
import dds.grupo9.queComemos.repoUsuarios.RepoUsuarios

@Data
@Accessors
class UsuarioLogueado {
	
	float altura
	float peso
	float imc	/* imc de un Usuario */
	String complexion
	String nombre	/* Nombre de un Usuario */
	String sexo		/* Sexo de un Usuario: M/m: Masculino y F/f: Femenino */
	String fechaNacimiento		/* Fecha de nacimiento de un Usuario */
	Collection<String> gustos = newHashSet() /* Gustos de un Usuario */
	Collection<String> disgustos = newHashSet() /*Disgustos de un Usuario */
	Collection<String> condicionesPreexistentes = newHashSet() /* Condicionantes de un Usuario */
	String rutina /* Tipo de rutina que lleva a cabo el Usuario */
    Collection<String> recetasFavoritas = newHashSet()
	
	new(Persona persona) {
		this.altura = persona.altura
		this.peso = persona.peso
		this.imc = persona.imc
		this.complexion = calcularComplexion(imc)
		this.nombre = persona.nombre
		this.sexo = persona.sexo
		this.fechaNacimiento = this.mapearFechaNacimiento(persona.fechaNacimiento)
		this.gustos.addAll(persona.gustos)
		this.disgustos.addAll(persona.disgustos)
		mapearCondicionesPreexistentes(this.condicionesPreexistentes, persona.condicionesPreexistentes)
		this.rutina = persona.rutina
		mapearRecetasFavoritas(this.recetasFavoritas, persona)
		
	}
	
	def calcularComplexion(float imc) {
		if(imc<18) return "Delgado"
		if(imc>=18 && imc <=25) return "Normal"
		if(imc>25 && imc <30) return "Robusto"
		if(imc>30) return "Obseo"
		
	}
	
	def mapearCondicionesPreexistentes(Collection<String> nombreCondiciones, Collection<CondPreexistente> condiciones) {
		nombreCondiciones.addAll(condiciones.map[it.toString])
	}
	
	def mapearFechaNacimiento(long fecha) {
		var String año = (fecha/10000).toString()
		var String mes = ((fecha%10000)/100).toString()
		var String dia = (fecha%100).toString()
		var String fechaFinal = dia +'/' + mes + '/' + año
		fechaFinal
	}
	
	def mapearRecetasFavoritas(Collection<String> recetas, Persona persona) {
		var Collection<Receta> recetasFavoritas = persona.recetasFavoritas
		recetas.addAll(recetasFavoritas.map[it.nombre])
	}
	def void setPersonaSeleccionada(Persona zona) {
		//personaSeleccionada = RepoUsuarios.instance.searchById(zona.id)
	}
	
}