package jp.co.seattle.library.dto;

import java.util.List;

import org.springframework.context.annotation.Configuration;

import lombok.Data;

/**
 * ユーザー情報格納DTO
 *
 */
@Configuration
@Data
public class BookInfoError {

 private BookDetailsInfo bookDetailsInfo;

 private List<String> errorList;


 public BookInfoError() {

 }


}