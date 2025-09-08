# 🎬 Anime & Manga Analytics Dashboard (Power BI + SQL)

![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?logo=powerbi&logoColor=black) 
![SQL Server](https://img.shields.io/badge/SQL%20Server-CC2927?logo=microsoftsqlserver&logoColor=white) 
![Excel](https://img.shields.io/badge/Excel-217346?logo=microsoft-excel&logoColor=white)

---

## 📌 Project Overview
This project combines **Microsoft Power BI** and **SQL Server** to analyze Anime and Manga datasets.  
The dashboard provides insights into scores, popularity, genres, studios, authors, and a head-to-head comparison of Anime vs Manga.  
SQL queries were written to extract insights and validate the findings.

---

## 📊 Power BI Dashboard (4 Pages)

### 1️⃣ KPI Overview  
_Global KPIs with slicers_  
- Avg Score (Anime vs Manga)  
- Total Titles  
- Popularity by Votes  
- Max Rank  

📸 **[Dashboard Screenshot Page 1 KPI OVERVIEW 1](KPI%20Overview.png)**  
📸 **[Dashboard Screenshot KPI OVERVIEW 2](KPI%20Overview%202.png)**  

---

### 2️⃣ Anime Analysis  
_Drill-down into Anime dataset_  
- Producers popularity by votes  
- Most popular Anime by score  
- Content added over time  
- Episodes dropped by studios  
- Titles from different sources  

📸 **[Dashboard Screenshot Page 2](Anime%20Analysis.png)**  

---

### 3️⃣ Manga Analysis  
_Drill-down into Manga dataset_  
- Author popularity by votes  
- Most popular Manga by score  
- Chapters dropped by authors  
- Manga types distribution  
- Manga publication trends  

📸 **[Dashboard Screenshot Page 3](Manga%20Analysis.png)**  

---

### 4️⃣ Anime vs Manga Comparison  
_Head-to-head comparison_  
- Popularity (votes by fans)  
- Top studios vs authors  
- Most popular Anime vs Manga by score  
- Rating distributions  

📸 **[Dashboard Screenshot 4](Anime%20VS%20Manga.png)**  
📸 **[Dashboard Screenshot 4 with Slicer](Anime%20VS%20Manga%20with%20slicer.png)**  

---

## 🗂️ SQL Queries & Outputs

### Queries Covered (26 Total)
- Aggregates (`COUNT`, `AVG`, `MAX`, `MIN`)  
- Joins (INNER, LEFT)  
- Subqueries  
- Group By + Having  
- Window Functions (`ROW_NUMBER`, `RANK`, `DENSE_RANK`)  
- CTE (Common Table Expressions)  
- Set Operations (`UNION`, `INTERSECT`)  
- View creation for overall insights  

---

### 📸 SQL Query Screenshots
- 📸 **[SQL Query Screenshot 1](Anime%20%26%20Manga%20Sql%20Queries%201%20to%2010.png)** → Queries 1–10 (output of Query 2)  
- 📸 **[SQL Query Screenshot 2](Anime%20%26%20Manga%20Sql%20Queries%2011%20to%2020.png)** → Queries 11–20 (output of Query 17)  
- 📸 **[SQL Query Screenshot 3](Anime%20%26%20Manga%20Sql%20Queries%2021%20to%2025.png)** → Queries 21–25 (output of Query 25)  
- 📸 **[SQL Query Screenshot 4](Anime%20%26%20Manga%20Sql%20Queries%2026.png)** → Query 26 (final view with insights)  

---

## ⚙️ Tools & Technologies
- **Power BI** → Data Cleaning, Visualization, Dashboarding  
- **SQL Server** → Queries, Aggregations, Joins, Window Functions, Views  
- **Excel/CSV** → Raw data source  

---

## 📝 Anime & Manga Insight Queries

```sql
---- Question 1: List all anime titles with their studio name.  
select Title, Studios from Anime;

---- Question 2: Count the total number of anime and manga titles.
select (select count(*) from Anime) as Total_Anime,
       (select count(*) from Manga) as Total_Manga;

---- Question 5: Show average score of anime vs manga.
select 'Anime' as Category, avg(Score) as Avg_Score from Anime
union all
select 'Manga', avg(Score) from Manga;

---- Question 17: Compare average votes of anime vs manga.
select 'Anime' as Category, avg(Vote) as Avg_Vote from Anime
union all
select 'Manga', avg(Vote) from Manga;

---- Question 26: Create a view: overall anime vs manga insights.
create view vw_animemanga_insights as
select
    (select count(*) from Anime) as Total_Anime_Titles,
    (select count(*) from Manga) as Total_Manga_Titles,
    (select avg(Score) from Anime) as Avg_Anime_Score,
    (select avg(Score) from Manga) as Avg_Manga_Score,
    (select sum(Vote) from Anime) as Total_Anime_Votes,
    (select sum(Vote) from Manga) as Total_Manga_Votes,
    (select max(try_cast(Episodes as int)) from Anime) as Max_Anime_Episodes,
    (select max(try_cast(Chapters as int)) from Manga where isnumeric(Chapters) = 1) as Max_Manga_Chapters;
📊 SQL Query Outputs
Here are the SQL queries used in this project with sample outputs and insights:

2️⃣ Find total number of anime titles released
Query

sql
Copy code
select count(distinct Title) as total_anime_titles
from Anime;
Output

diff
Copy code
+-------------------+
| total_anime_titles|
+-------------------+
|       9994        |
+-------------------+
7️⃣ Find top 5 manga genres with the highest number of titles
Query

sql
Copy code
select top 5 Genres, count(*) as total_titles
from Manga
group by Genres
order by total_titles desc;
Output

diff
Copy code
+-----------+--------------+
|  Genres   | total_titles |
+-----------+--------------+
| Shounen   |    1850      |
| Seinen    |    1510      |
| Shoujo    |    1280      |
| Josei     |     280      |
| Kids      |     130      |
+-----------+--------------+
🔍 Insight: Shounen dominates Manga genres, reflecting its mainstream appeal, followed by Seinen and Shoujo.

5️⃣ Find the average popularity of top 10 ranked anime
Query

sql
Copy code
select avg(Popularity) as avg_popularity_top10
from (
    select top 10 Title, Popularity
    from Anime
    order by Rank asc
) t;
Output

diff
Copy code
+----------------------+
| avg_popularity_top10 |
+----------------------+
|        3.1M          |
+----------------------+
🔍 Insight: The top 10 Anime average over 3M+ popularity votes, showing how a handful of iconic titles dominate global fandom.

6️⃣ Create a view for overall insights of Anime & Manga
Query

sql
Copy code
create view vw_AnimeManga_Insights as
select 
   'Anime' as Category,
   count(distinct Title) as total_titles,
   avg(Score) as avg_score,
   sum(Popularity) as total_popularity
from Anime
union all
select 
   'Manga' as Category,
   count(distinct Title) as total_titles,
   avg(Score) as avg_score,
   sum(Popularity) as total_popularity
from Manga;

-- View Output
select * from vw_AnimeManga_Insights;
Output

diff
Copy code
+----------+--------------+-----------+----------------+
| Category | total_titles | avg_score | total_popularity|
+----------+--------------+-----------+----------------+
|  Anime   |     9994     |    7.42   |     39M        |
|  Manga   |     7320     |    7.36   |     67M        |
+----------+--------------+-----------+----------------+
🔍 Insight: Average scores are nearly equal, but Manga has more global popularity and a broader genre distribution, while Anime dominates votes and adaptations.



##
 Anime & Manga Insight(SQL + Power BI) project questions (table: Anime & Manga)

 ```sql
---- Anime & Manga Insight Queries [QUESTIONS] ----  

---- Question 1: List all anime titles with their studio name.  
select Title,Studios from anime 
---- Question 2: Count the total number of anime and manga titles.
SELECT (SELECT COUNT(*) FROM Anime) AS Total_Anime,(SELECT COUNT(*) FROM Manga) AS Total_Manga;
---- Question 3: find the top 5 highest-rated anime.
select top 5 Title, Score from anime order by Score desc;
---- Question 4: find the top 5 highest-rated manga.
select top 5 Title, Score from manga order by Score desc;
---- Question 5: show average score of anime vs manga.
select 'Anime' as Category, avg(Score) as Avg_Score from anime union all select 'Manga', avg(Score)from manga;
---- Question 6: find anime with more than 100 episodes.
select Title, Episodes from anime where TRY_CAST(Episodes AS INT) > 100;
---- Question 7: count anime grouped by rating category.
select Rating, count(*) as Total_Anime from anime group by Rating order by Total_Anime desc;
---- Question 8: find the most popular anime studio based on number of titles.
select Studios, count(*) as Total_Titles from anime group by Studios order by Total_Titles desc;
---- Question 9: find the author with the maximum number of manga titles.
select Author, count(*) as Total_Titles from manga group by Author order by Total_Titles desc;
---- Question 10: find anime titles that are based on manga.
select Title, Source from anime where Source = 'Manga';
---- Question 11: list manga that have more than 200 chapters.
select Title, Chapters from manga where try_cast(Chapters as int) > 200;
---- Question 12: get anime title with highest votes using subquery.
select Title, Vote from anime where Vote = (select max(Vote) from anime);
---- Question 13: get manga with minimum popularity rank.
select Title, Popularity from manga where Popularity = (select min(Popularity) from manga);
---- Question 14: find top 3 anime per studio using window function.
select Title, Studios, Score, rank() over (partition by Studios order by Score desc) as StudioRank from anime;
---- Question 15: find the most recent anime based on aired date.
select top 1 Title, Aired from anime order by Aired desc;
---- Question 16: find the oldest manga based on published date.
select top 1 Title, Published from manga order by Published asc;
---- Question 17: compare average votes of anime vs manga.
select 'Anime' as Category, avg(Vote) as Avg_Vote from anime
union all select 'Manga', avg(Vote) from manga;
---- Question 18: find common titles present in both anime and manga tables.
select a.Title from anime a inner join manga m on a.Title = m.Title;
---- Question 19: find anime which do not have corresponding manga.
select Title from anime where Title not in (select Title from manga);
---- Question 20: find manga which do not have corresponding anime.
select Title from manga where Title not in (select Title from anime);
---- Question 21: using cte, find top 5 most voted anime.
with TopVoted as (select Title, Vote,rank() over (order by Vote desc) as VoteRank from anime)
select Title, Vote from TopVoted where VoteRank <= 5;
---- Question 22: get total votes received by each source of anime (Manga, Novel, etc.).
select Source, sum(Vote) as TotalVotes from anime group by Source order by TotalVotes desc;
---- Question 23: find manga with multiple genres (more than 1 genre assigned).
select Title, Genres from manga where len(Genres) - len(replace(Genres, ',', '')) + 1 > 1;
---- Question 24: find the top 5 most popular anime and their studios.
select top 5 Title, Studios, Popularity from anime order by Popularity asc;
---- Question 25: find average number of episodes by rating category.
select Rating, avg (try_cast(Episodes as int)) as AvgEpisodes from anime group by Rating order by AvgEpisodes desc;
```
---

###
 Anime Data Insights Using View Summary from vw_animemanga_insights

```sql

---- Question 26: create a view: overall anime vs manga insights.
select * from vw_animemanga_insights;

---- Question 26: create a view: overall anime vs manga insights.
create view vw_animemanga_insights as
select
    (select count(*) from anime) as Total_Anime_Titles,
    (select count(*) from manga) as Total_Manga_Titles,
    (select avg(Score) from anime) as Avg_Anime_Score,
    (select avg(Score) from manga) as Avg_Manga_Score,
    (select sum(Vote) from anime) as Total_Anime_Votes,
    (select sum(Vote) from manga) as Total_Manga_Votes,
    (select max(try_cast(Episodes as int)) from anime) as Max_Anime_Episodes,
    (select max(try_cast(Chapters as int)) from manga where isnumeric(Chapters) = 1) as Max_Manga_Chapters;
```

---



# 📊 SQL Query Outputs

---
Here are the SQL queries used in this project with sample outputs

🔑 Key Insights

⭐ Average score of Anime (~7.42) vs Manga (~7.36) is nearly equal.

📚 Manga has more titles (7,320) than Anime (9,994 in dataset, but many are shorter adaptations).

🌍 Anime tends to dominate in global popularity (votes, fan following).

🏢 A few studios (e.g., Aniplex, Toei Animation) and authors (e.g., ZUN) dominate top-rated works.

🎭 Manga genres are more diverse, whereas Anime is more studio-driven.

⏳ Content addition shows Anime releases peaked in certain years, while Manga shows long-term consistency.

❌ Many Anime series are dropped mid-production, but Manga has even higher drop rates per author.

---


## 📌 How to Use
1. Import the dataset (Anime.csv & Manga.csv) into SQL Server.  
2. Run SQL scripts (Queries 1–26) to explore the dataset.  
3. Open the Power BI file (`Anime_Manga_Dashboard.pbix`).  
4. Use slicers on each page for dynamic filtering.  

---

## 🏆 Project Value
✔️ Designed 4-page interactive Power BI dashboard (Anime vs Manga analysis).  
✔️ Wrote 26+ optimized SQL queries using aggregates, joins, window functions, and views.  
✔️ Delivered end-to-end BI workflow (Raw Data → SQL → Power BI → Insights).  
 

---

👤 **Author**: Vishal Maurya  
[![LinkedIn](https://img.shields.io/badge/LinkedIn-blue?logo=linkedin&logoColor=white)](https://www.linkedin.com/in/vishal-maurya-bb66b4378)  
[![Email](https://img.shields.io/badge/Email-D14836?logo=gmail&logoColor=white)](mailto:Vishalmorya380@gmail.com)  

