package pl.edu.uj.demo
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.*
import org.springframework.stereotype.Service
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.apache.coyote.Response

@Service
class AuthService @Autowired constructor(val userRepository: UserRepository) {
    fun register(user: User): User {
        return userRepository.save(user)
    }

    fun login(login: String, password: String): User {
        return userRepository.findByLoginAndPassword(login, password)
    }

    fun logout(login: String): User {
        return userRepository.findByLogin(login)
    }
}

@RestController
@RequestMapping("/service")
class Controller @Autowired constructor(private val service: AuthService) {

    @PostMapping("/register")
    @ResponseBody
    fun register(@RequestBody user: User): ResponseEntity<Response> {
        if (service.register(user)!=null) return ResponseEntity(HttpStatus.OK)
        else return return ResponseEntity(HttpStatus.UNAUTHORIZED)
    }

    @GetMapping("/login")

    fun login(@RequestParam("login") login: String, @RequestParam("password") password: String): User {
        return service.login(login, password)
    }

    @GetMapping("/logout")
    @ResponseBody
    fun logout(@RequestParam("login") login: String): ResponseEntity<Response> {
        if (service.logout(login)!=null) return  ResponseEntity(HttpStatus.OK)
        else return return ResponseEntity(HttpStatus.UNAUTHORIZED)
    }
}