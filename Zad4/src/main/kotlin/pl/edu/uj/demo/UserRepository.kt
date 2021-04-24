package pl.edu.uj.demo
import org.springframework.data.repository.CrudRepository;
import javax.persistence.*

@Entity
class User {
    val login: String = ""
    val password: String = ""
    @Id @GeneratedValue var id: Long? = null
}

interface UserRepository: CrudRepository<User, Long> {
    fun findByLoginAndPassword(login: String, password: String): User
    fun findByLogin(login: String): User
}