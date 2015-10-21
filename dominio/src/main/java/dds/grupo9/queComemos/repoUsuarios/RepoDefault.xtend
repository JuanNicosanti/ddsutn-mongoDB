package dds.grupo9.queComemos.repoUsuarios

import org.hibernate.SessionFactory
import org.hibernate.cfg.AnnotationConfiguration
import dds.grupo9.queComemos.Receta
import dds.grupo9.queComemos.Persona
import dds.grupo9.queComemos.Ingrediente
import dds.grupo9.queComemos.RecetaSimple
import dds.grupo9.queComemos.RecetaCompuesta
import dds.grupo9.queComemos.condicionPreexistente.Celiaco
import dds.grupo9.queComemos.condicionPreexistente.Diabetico
import dds.grupo9.queComemos.condicionPreexistente.Vegano
import dds.grupo9.queComemos.condicionPreexistente.Hipertenso
import java.util.List
import org.hibernate.HibernateException
import org.hibernate.Criteria
import org.hibernate.criterion.Restrictions
import org.hibernate.FetchMode
import dds.grupo9.queComemos.PrivacidadReceta
import dds.grupo9.queComemos.RecetaPrivada
import dds.grupo9.queComemos.RecetaPublica
import dds.grupo9.queComemos.consultas.Consulta
import dds.grupo9.queComemos.consultas.ConsultaDecorada
import dds.grupo9.queComemos.consultas.ConsultaPorCaloriasMaximas
import dds.grupo9.queComemos.consultas.ConsultaPorDisgusto
import dds.grupo9.queComemos.consultas.ConsultaPorIngredientesCaros
import dds.grupo9.queComemos.consultas.ConsultaPorCondicionesPreexistentes

abstract class RepoDefault<T> {
	private static final SessionFactory sessionFactory = new AnnotationConfiguration().configure().
		addAnnotatedClass(Receta).addAnnotatedClass(Persona).addAnnotatedClass(Ingrediente).
		addAnnotatedClass(RecetaSimple).addAnnotatedClass(RecetaCompuesta).addAnnotatedClass(Celiaco).
		addAnnotatedClass(Vegano)
		.addAnnotatedClass(Hipertenso)
		.addAnnotatedClass(PrivacidadReceta)
		.addAnnotatedClass(RecetaPrivada)
		.addAnnotatedClass(RecetaPublica)
		.addAnnotatedClass(Consulta)
		.addAnnotatedClass(ConsultaDecorada)
		.addAnnotatedClass(ConsultaPorCaloriasMaximas)
		.addAnnotatedClass(ConsultaPorDisgusto)
		.addAnnotatedClass(ConsultaPorCondicionesPreexistentes)
		.addAnnotatedClass(ConsultaPorIngredientesCaros)
		.addAnnotatedClass(Diabetico).buildSessionFactory()

	def List<T> allInstances() {
		val session = sessionFactory.openSession
		try {
			return session.createCriteria(getEntityType).list()
		} finally {
			session.close
		}
	}

	def List<T> searchByExample(T t) {
		val session = sessionFactory.openSession
		try {
			val criteria = session.createCriteria(getEntityType)
			this.addQueryByExample(criteria, t)
			return criteria.list()
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}

	def void create(T t) {
		val session = sessionFactory.openSession
		try {
			session.beginTransaction
			session.save(t)
			session.getTransaction.commit
		} catch (HibernateException e) {
			session.getTransaction.rollback
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}

	def abstract Class<T> getEntityType()

	def abstract void addQueryByExample(Criteria criteria, T t)

	def void update(T t) {
		val session = sessionFactory.openSession
		try {
			session.beginTransaction
			session.update(t)
			session.getTransaction.commit
		} catch (HibernateException e) {
			session.getTransaction.rollback
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}

	def openSession() {
		sessionFactory.openSession
	}

	
}
