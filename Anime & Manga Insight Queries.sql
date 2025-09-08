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
