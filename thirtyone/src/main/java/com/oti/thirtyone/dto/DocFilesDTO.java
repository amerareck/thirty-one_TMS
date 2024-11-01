package com.oti.thirtyone.dto;

import lombok.Data;

@Data
public class DocFilesDTO {
	private int docFileId; // 문서첨부파일 ID
	private byte[] docFileData; // 문서첨부파일 데이터
	private String docFileName; // 문서첨부파일 이름
	private String docFileType; // 문서첨부파일 MIME 타입
	
	private int reasonId; // 사유서 ID
	private int hdrId; // 휴가 ID
	private String docNumber; // 문서번호
}
