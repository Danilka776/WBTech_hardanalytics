import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from scipy.stats import chi2_contingency

df = pd.read_csv('shopping_trends.csv', sep=',')

# Поиск самого популярного товара (если их несколько выведет все)
item_counts = dict(df['Item Purchased'].value_counts())
res = sorted(item_counts.items(), key=lambda x: int(x[1]), reverse=True) 
for it in res:
    if int(it[1]) == int(res[0][1]):
        print(it[0])


# Распределение покупателей по полу
gender_counts = df['Gender'].value_counts()
plt.figure(figsize=(8, 6))
gender_counts.plot(kind='bar', color=['blue', 'red'], alpha=0.5, edgecolor='black')
plt.title('Распределение покупателей по полу', fontsize=14)
plt.xlabel('Пол', fontsize=12)
plt.ylabel('Количество покупателей', fontsize=12)
plt.xticks(rotation=0)
plt.grid(axis='y', linestyle='--', alpha=0.6)
plt.show()


# Пол, который покупает больше всего (по количеству товаров)
gender_items_cnt = dict(df.groupby('Gender')['Customer ID'].count())
res = sorted(gender_items_cnt.items(), key=lambda x: int(x[1]), reverse=True) 
for it in res:
    if int(it[1]) == int(res[0][1]):
        print(it[0], end=' ')
        print(it[1])

# Пол, который покупает больше всего (по суммарной стоимости товаров)
gender_items_sum = dict(df.groupby('Gender')['Purchase Amount (USD)'].sum())
res = sorted(gender_items_sum.items(), key=lambda x: int(x[1]), reverse=True) 
for it in res:
    if int(it[1]) == int(res[0][1]):
        print(it[0], end=' ')
        print(it[1])

# Пол, который покупает самые дорогие товары
max_price = df['Purchase Amount (USD)'].max()
gender_highest_price = df[df['Purchase Amount (USD)'] == max_price]
gender_highest_price_cnt = gender_highest_price['Gender'].value_counts()
res = sorted(gender_highest_price_cnt.items(), key=lambda x: int(x[1]), reverse=True) 
for it in res:
    if int(it[1]) == int(res[0][1]):
        print(it[0], end=' ')
        print(it[1])


# Возраст, который покупает больше всего (по количеству товаров)
age_items_cnt = dict(df.groupby('Age')['Customer ID'].count())
res = sorted(age_items_cnt.items(), key=lambda x: int(x[1]), reverse=True) 
for it in res:
    if int(it[1]) == int(res[0][1]):
        print(it[0], end=' ')
        print(it[1])

# Возраст, который покупает больше всего (по суммарной стоимости товаров)
age_items_sum = dict(df.groupby('Age')['Purchase Amount (USD)'].sum())
res = sorted(age_items_sum.items(), key=lambda x: int(x[1]), reverse=True) 
for it in res:
    if int(it[1]) == int(res[0][1]):
        print(it[0], end=' ')
        print(it[1])

# Возраст, который покупает самые дорогие товары
max_price = df['Purchase Amount (USD)'].max()
age_highest_price = df[df['Purchase Amount (USD)'] == max_price]
age_highest_price_cnt = age_highest_price['Age'].value_counts()
res = sorted(age_highest_price_cnt.items(), key=lambda x: int(x[1]), reverse=True) 
for it in res:
    if int(it[1]) == int(res[0][1]):
        print(it[0], end=' ')
        print(it[1])


# зависимость между цветом одежды и сезоном
color_season_table = pd.crosstab(df['Color'], df['Season'])
print("Сводная таблица (частоты):")
print(color_season_table)
chi2 = chi2_contingency(color_season_table)
print(f"Статистика: {chi2[0]:.2f}")
print(f"P-значение: {chi2[1]:.4f}")
alpha = 0.05
if chi2[1] < 0.05:
    print("Есть статистически значимая зависимость между цветом одежды и сезоном.")
else:
    print("Нет статистически значимой зависимости между цветом одежды и сезоном.")


# сезонный mau (уникальных пользователей за сезон) и его динамика
seasonal_mau = df.groupby('Season')['Customer ID'].nunique().reset_index()
seasonal_mau = seasonal_mau.rename(columns={'Customer ID': 'MAU'})
new_order = [2, 0, 3, 1]
seasonal_mau = seasonal_mau.iloc[new_order].reset_index(drop=True)
seasonal_mau['MAU_Diff'] = seasonal_mau['MAU'].diff()
print(seasonal_mau)


# Поиск самой популярной буквы в названии одежды
items = list(df['Item Purchased'])
uniq_items = list(set(items))
all_name = ''.join(uniq_items)
symbol_cnt = {}
for c in all_name:
    c = c.lower()
    if c in symbol_cnt:
        symbol_cnt[c] += 1
    else:
        symbol_cnt[c] = 1
res = sorted(symbol_cnt.items(), key=lambda x: int(x[1]), reverse=True) 
for it in res:
    if int(it[1]) == int(res[0][1]):
        print(it[0], end=' ')
        print(it[1])