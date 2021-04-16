package main

import (
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	"net/http"
)

func main() {
	e := echo.New()
	e.Use(middleware.Logger())
	e.Use(middleware.Recover())
	s := GetInstance()
	
	/*CREATE*/
	e.POST("/book", func(c echo.Context) error{
		s.Open() 
		newBook := new (Book)
		if error := c.Bind(newBook); error != nil {
			return error
		}
		s.Query("INSERT INTO book(title, author) VALUES(?,?)", newBook.Title, newBook.Author)
		s.Close()
		return c.JSON(http.StatusCreated, "Created")
	})

	/*READ*/
	e.GET("/book", func(c echo.Context) error{
		s.Open()
		books, error := s.Search("SELECT id, title, author FROM book")
		if error != nil{
			return error
		}
		s.Close()
		return c.JSON(http.StatusCreated, books)
	})

	/*UPDATE*/
	e.PUT("/book", func(c echo.Context) error{
		s.Open()
		updatedBook := new (Book)
		if error := c.Bind(updatedBook); error != nil {
			return error
		}
		s.Query("UPDATE book SET title=?, author=? WHERE id=?", updatedBook.Title, updatedBook.Author, updatedBook.Id)
		s.Close()
		return c.JSON(http.StatusCreated, updatedBook)
	})

	/*DELETE*/
	e.DELETE("/book/:id", func(c echo.Context) error{
		s.Open()
		s.Query("DELETE FROM book Where id = ?", c.Param("id"))
		s.Close()
		return c.JSON(http.StatusOK, "Deleted")
	})

	if err := e.Start(":1323"); err != nil {
		panic(err)
	}


}
