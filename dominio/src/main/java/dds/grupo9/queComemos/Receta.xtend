package dds.grupo9.queComemos

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Collection
import dds.grupo9.queComemos.condicionPreexistente.CondPreexistente
import dds.grupo9.queComemos.modificacionRecetas.Modificacion
import queComemos.entrega3.dominio.Dificultad
import dds.grupo9.queComemos.repoRecetas.RepoRecetas
import org.uqbar.commons.utils.Observable
import dds.grupo9.queComemos.condicionPreexistente.Hipertenso
import dds.grupo9.queComemos.condicionPreexistente.Celiaco
import dds.grupo9.queComemos.condicionPreexistente.Vegano
import dds.grupo9.queComemos.condicionPreexistente.Diabetico

@Observable
@Accessors
abstract class Receta{
	
	String nombre /*Nombre del plato */
    String explicacion /*Pasos a seguir en la receta */
    int calorias /*Calorías de la receta (A modificar) */
    Dificultad dificultad /*Dificultad de la receta */
    int tiempoPreparacion
    var Collection<Ingrediente> ingredientes= newHashSet() /*Ingredientes de la receta */
    var Collection<String> condimentos= newHashSet() /*Ingredientes de la receta */
    var Collection<Estacion> temporadasCorrespondientes = newHashSet() /*Temporadas a las que corresponde la receta */
    var Collection<CondPreexistente> condiciones = newHashSet() /* Condiciones preexistentes */
    var PrivacidadReceta privacidad /* Condición de privacidad de la receta (publica o privada) */
    String nombreDuenio
    
    new (RepoRecetas repositorio){
    	
    	privacidad = new RecetaPublica ()
    	nombreDuenio = getNombreDueño()
//    	condicionesPreexistentes.addAll(new Hipertenso(), new Celiaco(), new Vegano(), new Diabetico())
//    	repositorio.agregarRecetaPublica(this)	
    }
    new(Persona persona){
    	privacidad = new RecetaPrivada(persona)
    	nombreDuenio = getNombreDueño()
//    	condicionesPreexistentes.addAll(new Hipertenso(), new Celiaco(), new Vegano(), new Diabetico())
    }
    
    def cambioAPrivada(Persona persona){
    	
    	privacidad= new RecetaPrivada(persona)
    }
    
    def getIngredientes(){
		this.ingredientes
	}
	
	def getCondimentos(){
		this.condimentos
	}
	
	def getCondiciones(){
		var Collection<CondPreexistente> condicionesParaFiltrar = newHashSet()
		var Collection<CondPreexistente> condicionesFiltradas = newHashSet()
		condicionesParaFiltrar.addAll(new Hipertenso(), new Celiaco(), new Vegano(), new Diabetico())
//		condicionesParaFiltrar.forEach[println(it.toString)]
		condicionesFiltradas.addAll(condicionesParaFiltrar.filter[it.recetaNoRecomendada(this)])
//		condicionesFiltradas.forEach[println(it.toString)]
		condicionesFiltradas
	}
	
	def agregarIngredientes(Collection<Ingrediente> i){
		ingredientes.addAll(i)
	}
	
	def agregarCondimentos(Collection<String> c){
		condimentos.addAll(c)
	}
	
	def agregarTemporada(Estacion tc){
		temporadasCorrespondientes.add(tc)
	}
	
       
   	def agregarIngrediente(Ingrediente ingrediente){/*Agrega un ingrediente a la lista de la receta*/
   		ingredientes.add(ingrediente)
   	} 
   	
   	def agregarCondimento(String cond){/*Agrega un condimento a la lista de la receta*/
   		condimentos.add(cond)
   	} 
   	
   	def agregarTodosLosIngredientes(Collection<Ingrediente> ingredientesParaAgregar ){/*Agrega ingredientes a la lista de la receta*/
   		ingredientes.addAll(ingredientesParaAgregar)
   	} 
   	
   	def eliminarIngrediente(Ingrediente ingrediente){
   		ingredientes.remove(ingrediente)
   	}
   	
   	def eliminarTodosLosIngredientes(Collection<Ingrediente> ingredientesParaRemover){
   		ingredientes.removeAll(ingredientesParaRemover)
   	}
   		
	def eliminarIngredientesPorNombre(String nombreIngrediente){
		ingredientes.removeAll(this.filtrarIngredientesPorNombre(nombreIngrediente))
	}
   
	def recetaValida(){ /*Evalúa si una receta cumple con las condiciones para considerarse como tal */
   		(this.tieneIngredientes && this.contieneCaloriasRazonables) 
   	}
   
   	def tieneIngredientes(){/* Evalúa si la receta tiene al menos 1 ingrediente */
   		ingredientes.size>0
   	}
  
  	def contieneCaloriasRazonables(){ /*Define límites de calorías para una receta */
  		calorias>10 && calorias <5000
  	}
  
  	def tieneMasDeUnaCantidadDe(int cantidadMax, Ingrediente ingredienteBuscado){ /* Calcula si la receta tiene más de X gramos de un determinado Ingrediente */
    	(ingredientes.filter[ingrediente | ingrediente.tieneMasDeLoPermitidoDe(cantidadMax, ingredienteBuscado)]).size > 0
  	}
  	
  	def tieneIngrediente(String nombreIngrediente){ /* Evalúa si dado el nombre de un ingrediente, la receta lo contiene */
  		!filtrarIngredientesPorNombre(nombreIngrediente).isEmpty
  	}
  	
  	def tieneCondimento(String condimento){
  		condimentos.exists[it == condimento]
  	}
  	 
  	def filtrarIngredientesPorNombre(String nombreIngrediente){  
  		ingredientes.filter[ingrediente|ingrediente.soyYo(nombreIngrediente)]
  	}
  
  	def recetaInadecuadaPara (){ /*Muestra las condiciones para la que una receta es inadecuada */
		this.getCondiciones.filter[condicion|condicion.recetaNoRecomendada(this)]
  		
  	}
  		
  	def boolean puedeVerOModificarReceta(Persona persona){
		privacidad.puedeVermeOModificarme(persona)
	}
	
		
	def void sufrirCambios(Persona persona, Modificacion modificacion){
		privacidad.cambiosDeReceta(persona,modificacion,this)
  	}
	
	
	def agregarTemporadas(Collection<Estacion> temporadasParaAgregar){
		temporadasCorrespondientes.addAll(temporadasParaAgregar)
	} // Habria que hacerlo dinámico
	
	def cantidadIngredientes(){
		ingredientes.size
	}
		
	def Receta copiaReceta(Persona persona) 
	
	def void agregarSubreceta(Receta c)	
		
	def Receta copiarAtributosComunes(Receta recetaCopia, Persona persona){
		recetaCopia.nombre = nombre
		recetaCopia.explicacion = explicacion
		recetaCopia.calorias = calorias
		recetaCopia.dificultad = dificultad
		recetaCopia.agregarTemporadas(temporadasCorrespondientes)
		return recetaCopia	
	}
	
	/*Entrega 2 Punto 1. Invocar con: receta.puedeSerSugeridaA(unaPresona/unGrupo) double dispatch */
	def puedeSerSugeridaA(Persona unaPersona){
		unaPersona.noContieneIngredientesQueLeDisgusten(this)	&& !unaPersona.recetaNoRecomendada(this)
	}
	
	def puedeSerSugeridaA(GrupoDePersonas unGrupo){
		unGrupo.contieneAlgunIngredienteQuePrefiereElGrupo(this) && unGrupo.laRecetaEsApropiadaParaTodos(this)	
	}
	
	def tieneIngredientesCaros(){
		ingredientes.exists[it.esCaro()]
	}
	
	/*Entrega 3 */
	def Persona getDueño(){
		privacidad.getDueño()
	}
	
	def esDificil(){
		this.dificultad == Dificultad.DIFICIL
	}
	
	def getNombre(){
		this.nombre
	}	
	
	def String getNombreDueño(){
		privacidad.getNombreDueño()
	}
	
	def  Collection<String> nombreIngredientes(){
		ingredientes.map[it.nombre].toSet
	}
	
	def eliminarCondimento(String string){
		this.condimentos.remove(string)
	}
	
}