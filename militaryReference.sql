USE [SU_STUDENTSDATABASE]
GO

/****** Object:  StoredProcedure [dbo].[VoennoOkrujie]    Script Date: 19-Dec-16 08:51:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[VoennoOkrujie]
	@year int
AS
SET NOCOUNT ON;

SELECT pd.FullName as name, r.RegionName as region, m.MunicipalityName as municipality, ct.CityTypeName as citytype, ci.CityName as cityname, a.PostCode as postcode,
		a.AddressText as addres, pd.PersonalNumber as egn, ep.EducationPlanName as speciality
FROM Students s inner join EducationStatuts es on s.EducationStatut_ID = es.EducationStatut_ID
				inner join PersonData pd on pd.PersonData_ID = s.PersonData_ID
				inner join Addresses a on a.PersonData_ID = pd.PersonData_ID
				inner join AddressTypes atype on atype.AddressType_ID = a.AddressType_ID
				inner join Countries c on c.Country_ID = a.Country_ID
				inner join Regions r on r.Region_ID = a.Region_ID 
				inner join Municipalities m on m.Municipality_ID = a.Municipality_ID
				inner join Cities ci on ci.City_ID = a.City_ID
				inner join CityTypes ct on ct.CityType_ID = ci.CityType_ID
				inner join EducationPlans ep on ep.EducationPlan_ID = s.EducationPlan_ID
WHERE (ep.EducationPlanName = N'Медицина' or ep.EducationPlanName = N'Психология' or ep.EducationPlanName = N'Медицинска сестра'  or ep.EducationPlanName = N'Медицинска рехабилитация и ерготерапия' )
		and year(s.StateExaminationCommitteeProtocolDate) = @year and es.EducationStatut_ID = 4 and atype.Permanent = 1 and a.Country_ID = 100;


GO

