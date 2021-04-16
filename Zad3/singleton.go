package main

import (
	"database/sql"
	_ "github.com/mattn/go-sqlite3"
	"fmt"
	"sync"
)

type Book struct{
	Id int `json:"id"`
	Title string `json:"title"`
	Author string `json:"author"`
}

type Books struct {
	Books []Book `json:"books"`
}

type Singleton struct {
	db *sql.DB
}

var once sync.Once
var instance *Singleton


func GetInstance() *Singleton {

	once.Do(func(){
		instance = new(Singleton)
	
	})
	return instance

}

func (s *Singleton)Open() *sql.DB {
	db, error := sql.Open("sqlite3", "./books_db.db")
	
	if error != nil {
		fmt.Println(error.Error())
	} 
	
	_, error = db.Exec("CREATE TABLE book (id INTEGER PRIMARY KEY AUTOINCREMENT, title text NOT NULL, author text NOT NULL)") 
	
	if error != nil {
		fmt.Println(error.Error())
	}
	
	if error = db.Ping(); error != nil {
		panic(error)
	}
	 
	s.db=db
	return db
}

func (s *Singleton) Close(){
	if error := s.db.Close(); error != nil {
		panic(error)
	}
}

func (s *Singleton) Query(query string, args ...interface{}) (sql.Result){
	stmt, error := s.db.Prepare(query)
	if error != nil {
		fmt.Println(error)
	}
	result, error := stmt.Exec(args...)
	if error != nil{
		panic(error)
	}
	return result
}

func (s *Singleton) Search(query string) (*Books, error) {
		rows, error := s.db.Query(query)
		if error != nil {
			fmt.Println(error)
		}
		books := Books{}
		
		for rows.Next() {
			book := Book{}
			rows.Scan(&book.Id, &book.Title, &book.Author)
			books.Books = append(books.Books, book)
		}
	return &books, nil
}




