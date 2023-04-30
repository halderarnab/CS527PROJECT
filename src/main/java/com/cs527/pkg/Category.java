package com.cs527.pkg;

import java.util.List;
import java.util.ArrayList;

public class Category {
	public int id;
	public String name;
	public List<SubCategory> subCategories;
	public Category(int id, String name)
	{
		this.id = id;
		this.name = name;
		subCategories = new ArrayList();
	}
}
