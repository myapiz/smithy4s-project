package hello

import cats.effect.IO
import com.myapiz.smithy4s.middleware.AuthMiddleware.AuthData

import scala.concurrent.duration.*

class HelloServiceImpl(authData: IO[AuthData]) extends Hello[IO] {

  override def sayHello(id: String): IO[HelloOutput] = IO {
    HelloOutput(s"Hello ${id}")
  }
}
