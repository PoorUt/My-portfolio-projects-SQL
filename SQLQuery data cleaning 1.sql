
--Thank you Alex The Analyst (You tube) for this tutorial

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [UniqueID ]
      ,[ParcelID]
      ,[LandUse]
      ,[PropertyAddress]
      ,[SaleDate]
      ,[SalePrice]
      ,[LegalReference]
      ,[SoldAsVacant]
      ,[OwnerName]
      ,[OwnerAddress]
      ,[Acreage]
      ,[TaxDistrict]
      ,[LandValue]
      ,[BuildingValue]
      ,[TotalValue]
      ,[YearBuilt]
      ,[Bedrooms]
      ,[FullBath]
      ,[HalfBath]
  FROM [Portfolio project].[dbo].[NashvilleHousing]

--Data cleaning road map (what I will do in this project)
select*
from [Portfolio project]..NashvilleHousing


--1. Standardize date format
select Saledateconverted, convert(Date,SaleDate)
from [Portfolio project]..NashvilleHousing 

update NashvilleHousing
set SaleDate=convert(Date,SaleDate)

ALTER TABLE NashvilleHousing
add Saledateconverted Date;

update NashvilleHousing
set Saledateconverted = convert(Date,SaleDate) 


--2. Populate missing property address data where parcelID is same as another cell
select*
from [Portfolio project]..NashvilleHousing 
--where propertyaddress is null
order by parcelID

select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, isnull(a.PropertyAddress, b.PropertyAddress)
from [Portfolio project]..NashvilleHousing a
join [Portfolio project]..NashvilleHousing b
	on a.ParcelID=b.ParcelID
	AND a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null


update a
set PropertyAddress = isnull(a.PropertyAddress, b.PropertyAddress)
from [Portfolio project]..NashvilleHousing a
join [Portfolio project]..NashvilleHousing b
	on a.ParcelID=b.ParcelID
	AND a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null


--3. Breaking out Address in to individual coulmns (Address, city, state)

select PropertyAddress
from [Portfolio project]..NashvilleHousing 
--where propertyaddress is null
--order by parcelID


select
SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1) as StreetAddress, 
SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1, len(PropertyAddress)) as Area
from [Portfolio project]..NashvilleHousing 


ALTER TABLE NashvilleHousing
add PropertySplitAddress Nvarchar(255);

update NashvilleHousing
set PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1)

ALTER TABLE NashvilleHousing
add PropertySplitcity Nvarchar(255);

update NashvilleHousing
set PropertySplitcity = SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1, len(PropertyAddress))

select *
from [Portfolio project]..NashvilleHousing 


--Lets do the same for OwnerAddress

select Owneraddress
from [Portfolio project]..NashvilleHousing 

select
PARSENAME(Replace(owneraddress,',','.'),3),
PARSENAME(Replace(owneraddress,',','.'),2),
PARSENAME(Replace(owneraddress,',','.'),1)
from [Portfolio project]..NashvilleHousing 





ALTER TABLE NashvilleHousing
add OwnerSplitAddress Nvarchar(255);

update NashvilleHousing
set OwnerSplitAddress = PARSENAME(Replace(owneraddress,',','.'),3)

ALTER TABLE NashvilleHousing
add OwnerSplitcity Nvarchar(255);

update NashvilleHousing
set OwnerSplitcity = PARSENAME(Replace(owneraddress,',','.'),2)

ALTER TABLE NashvilleHousing
add OwnerSplitstate Nvarchar(255);

update NashvilleHousing
set ownerSplitstate = PARSENAME(Replace(owneraddress,',','.'),1)


select*
from [Portfolio project]..NashvilleHousing 




--4. Change Y and N to "Yes" and "No" in "Sold As Vancant" field

select distinct(soldAsVacant), count(soldAsVacant)
from [Portfolio project]..NashvilleHousing 
group by (soldAsVacant)
order by 2


select soldAsVacant, case when SoldAsVacant = 'Y' Then 'Yes'  when SoldAsVacant = 'N' Then 'No'
	else SoldAsVacant
	end
from [Portfolio project]..NashvilleHousing

update NashvilleHousing
set SoldAsVacant = case when SoldAsVacant = 'Y' Then 'Yes'  when SoldAsVacant = 'N' Then 'No'
	else SoldAsVacant
	end

--5. Remove duplicates
with RowNumCTE AS(
Select*,
	Row_NUMBER() over (
	Partition by ParcelID,
			     SalePrice,
				 SaleDate,
				 LegalReference
				 Order by 
					UniqueID
					) row_num
from [Portfolio project]..NashvilleHousing
--order by ParcelID
)
Select*
from RowNumCTE
where row_num > 1
--Order by PropertyAddress



--6.Delete unused columns (We are going to delete property address, owner address, and sale date because we have better replacement of these two columns)


select*
from [Portfolio project]..NashvilleHousing 

Alter Table [Portfolio project]..NashvilleHousing 
Drop column OwnerAddress, PropertyAddress, TaxDistrict, SaleDate
