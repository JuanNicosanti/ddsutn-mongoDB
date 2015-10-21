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

abstract class RepoDefault<T> {
	private static final SessionFactory sessionFactory = new AnnotationConfiguration().configure().
		addAnnotatedClass(Receta).addAnnotatedClass(Persona).addAnnotatedClass(Ingrediente).
		addAnnotatedClass(RecetaSimple).addAnnotatedClass(RecetaCompuesta).addAnnotatedClass(Celiaco).
		addAnnotatedClass(Vegano).addAnnotatedClass(Hipertenso).addAnnotatedClass(Diabetico).buildSessionFactory()

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

	def Persona searchById(Long id) {
		val session = openSession
		try {
			val zonas = session.createCriteria(Persona).setFetchMode("recetasPropias", FetchMode.JOIN).add(
				Restrictions.eq("id", id)).list
			if (zonas.empty) {
				return null
			} else {
				return zonas.head
			}
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}
}
