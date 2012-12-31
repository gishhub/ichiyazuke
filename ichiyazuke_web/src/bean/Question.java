package bean;

import java.util.Date;

public class Question {

	private int id;
	private int grade;
	private int category;
	private int level;
	private String title;
	private String contents;
	private String choice1;
	private String choice2;
	private String choice3;
	private String choice4;
	private String answer;
	private String explanation;
	private int count;
	private Date regDate;

	public Question() {
	}

	public Question(int id, String title, String contents, Date regDate) {
		this.id = id;
		this.title = title;
		this.contents = contents;
		this.regDate = regDate;
	}

	public Question(int id, String title, String contents, String choice1, String choice2,String choice3, String choice4, String answer, String explanation,Date regDate) {
		this.id = id;
		this.title = title;
		this.contents = contents;
		this.choice1 = choice1;
		this.choice2 = choice2;
		this.choice3 = choice3;
		this.choice4 = choice4;
		this.answer = answer;
		this.explanation = explanation;
		this.regDate = regDate;
	}

	public Question(int id, int grade, int category, int level,
			String title, String contents, String choice1, String choice2,
			String choice3, String choice4, String answer, String explanation,
			int count, Date regDate) {
		this.id = id;
		this.grade = grade;
		this.category = category;
		this.level = level;
		this.title = title;
		this.contents = contents;
		this.choice1 = choice1;
		this.choice2 = choice2;
		this.choice3 = choice3;
		this.choice4 = choice4;
		this.answer = answer;
		this.explanation = explanation;
		this.count = count;
		this.regDate = regDate;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getGrade() {
		return grade;
	}

	public void setGrade(int grade) {
		this.grade = grade;
	}

	public int getCategory() {
		return category;
	}

	public void setCategory(int category) {
		this.category = category;
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getChoice1() {
		return choice1;
	}

	public void setChoice1(String choice1) {
		this.choice1 = choice1;
	}

	public String getChoice2() {
		return choice2;
	}

	public void setChoice2(String choice2) {
		this.choice2 = choice2;
	}

	public String getChoice3() {
		return choice3;
	}

	public void setChoice3(String choice3) {
		this.choice3 = choice3;
	}

	public String getChoice4() {
		return choice4;
	}

	public void setChoice4(String choice4) {
		this.choice4 = choice4;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public String getExplanation() {
		return explanation;
	}

	public void setExplanation(String explanation) {
		this.explanation = explanation;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
}
