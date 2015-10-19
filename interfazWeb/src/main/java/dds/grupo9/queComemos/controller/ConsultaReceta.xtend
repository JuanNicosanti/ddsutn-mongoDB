package dds.grupo9.queComemos.controller

import org.eclipse.xtend.lib.annotations.Data
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Collection
import dds.grupo9.queComemos.Receta
import dds.grupo9.queComemos.repoRecetas.RepoRecetasPropio
import dds.grupo9.queComemos.Persona
import dds.grupo9.queComemos.Estacion
import queComemos.entrega3.dominio.Dificultad

@Data
@Accessors
class ConsultaReceta {

	Collection<Receta> recetas = newHashSet()
	Persona persona
	
	new(Persona persona, RepoRecetasPropio repo){
		this.persona = persona
		this.recetas.addAll(repo.getRecetas)
	}
	
	def filtrarRecetas(FiltrosReceta filtro){
		if(filtro.nombre != null && filtro.nombre != ""){
			var recetasFiltroNombre = recetas.filter[!it.nombre.contains(filtro.nombre)]
			recetas.removeAll(recetasFiltroNombre)
		}
				
		if(filtro.caloriasMax == 0){
			filtro.caloriasMax = 99999999
		}
		var recetasFiltroCalorias = recetas.filter[it.calorias<filtro.caloriasMin || it.calorias>filtro.caloriasMax]
		recetas.removeAll(recetasFiltroCalorias)

		if(filtro.ingrediente != null && filtro.ingrediente != ""){
			var recetasFiltroIngrediente = recetas.filter[ !it.tieneIngrediente(filtro.ingrediente)]
			recetas.removeAll(recetasFiltroIngrediente)
		}

		if(filtro.temporada != null && filtro.temporada != ""){
			var recetasPorEstacion = this.aplicarEstacion(recetas, filtro)
			recetas.removeAll(recetasPorEstacion)
		}
		
		if(filtro.dificultad != null && filtro.dificultad != ""){
			var recetasPorDificultad = this.aplicarDificultad(recetas, filtro)
			recetas.removeAll(recetasPorDificultad)
		}	
		
		if(filtro.filtrado == true){
			var recetasPorCondiciones = this.mapearRecetasNoAptas(recetas, persona)
			recetas.removeAll(recetasPorCondiciones)
		}
	}
	
	def mapearRecetasNoAptas(Collection<Receta> recetas, Persona persona) {
		var Collection<Receta> recetasAptas = newHashSet()
		recetasAptas.addAll(recetas.filter[persona.recetaNoRecomendada(it)])
		recetasAptas
	}
	
	def aplicarEstacion(Iterable<Receta> recetas, FiltrosReceta filtro) {
		var Collection <Receta> recetasPorTemporada = newHashSet()
		if(filtro.temporada == "verano"){
			recetasPorTemporada.addAll(recetas.filter[!it.temporadasCorrespondientes.contains(Estacion.VERANO)])
		}else{
			if(filtro.temporada == "otogno"){
				recetasPorTemporada.addAll(recetas.filter[!it.temporadasCorrespondientes.contains(Estacion.OTOGNO)])
			}else{
				if(filtro.temporada == "invierno"){
					recetasPorTemporada.addAll(recetas.filter[!it.temporadasCorrespondientes.contains(Estacion.INVIERNO)])
				}else{
					if(filtro.temporada == "primavera"){
						recetasPorTemporada.addAll(recetas.filter[!it.temporadasCorrespondientes.contains(Estacion.PRIMAVERA)])
					}else{
						recetasPorTemporada.addAll(recetas)
					}
				}
			}
		}
		return recetasPorTemporada
	}

	def aplicarDificultad(Iterable<Receta> recetas, FiltrosReceta filtro) {	
		var Collection <Receta> recetasPorDificultad = newHashSet()	
		if(filtro.dificultad == "Dificil"){
			recetasPorDificultad.addAll(recetas.filter[it.dificultad != Dificultad.DIFICIL])
		}else{
			if(filtro.temporada == "Media"){
				recetasPorDificultad.addAll(recetas.filter[it.dificultad != Dificultad.MEDIANA])
			}else{
				if(filtro.temporada == "Facil"){
					recetasPorDificultad.addAll(recetas.filter[it.dificultad != Dificultad.FACIL])
				}else{
						recetasPorDificultad.addAll(recetas)
				}
			}
		}
		return recetasPorDificultad
	}
	
}