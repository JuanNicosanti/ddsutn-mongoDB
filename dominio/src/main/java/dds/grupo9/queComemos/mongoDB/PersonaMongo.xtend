package dds.grupo9.queComemos.mongoDB

import org.eclipse.xtend.lib.annotations.Accessors
import dds.grupo9.queComemos.Receta
import org.mongojack.ObjectId
import com.fasterxml.jackson.annotation.JsonProperty
import dds.grupo9.queComemos.condicionPreexistente.CondPreexistente
import java.util.Collection
import dds.grupo9.queComemos.repoRecetas.RepoRecetas
import dds.grupo9.queComemos.Persona

class PersonaMongo {
	@ObjectId
	@JsonProperty("_id")
	String idMongo
	
	@Accessors float peso	/* Peso de un Usuario */
	@Accessors float altura		/* Altura de un Usuario */
	@Accessors String nombre	/* Nombre de un Usuario */
	@Accessors String sexo		/* Sexo de un Usuario: M/m: Masculino y F/f: Femenino */
	@Accessors long fechaNacimiento		/* Fecha de nacimiento de un Usuario */
	@Accessors var Collection<CondPreexistente> condicionesPreexistentes = newHashSet() /* Condicionantes de un Usuario */
	@Accessors String rutina /* Tipo de rutina que lleva a cabo el Usuario */
    @Accessors var Collection<Receta> recetasPropias = newHashSet() /*Recetas de un Usuario */
    @Accessors RepoRecetas repoRecetas
    @Accessors var Collection<Receta> recetasFavoritas = newHashSet()
    @Accessors HomeUsuarios homeUsuarios
    @Accessors Receta recetaSeleccionada
    @Accessors String contrasegna
    
    new(Persona persona){
    	this.peso = persona.peso
    	this.altura = persona.altura
    	this.nombre = persona.nombre
    	this.sexo = persona.sexo
    	this.fechaNacimiento = persona.fechaNacimiento
    	this.condicionesPreexistentes.addAll(persona.condicionesPreexistentes)
    	this.rutina = persona.rutina
    	this.recetasPropias.addAll(persona.recetasPropias)
    	this.repoRecetas = persona.repoRecetas
    	this.recetasFavoritas.addAll(persona.recetasFavoritas)
    	this.homeUsuarios = persona.homeUsuarios
    	this.recetaSeleccionada = persona.recetaSeleccionada
    	this.contrasegna = persona.contrasegna    	
    }

}