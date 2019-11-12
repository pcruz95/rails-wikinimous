class Article < ApplicationRecord
  include PgSearch
  after_create :add_words

  pg_search_scope :search_articles,
    against: {
      title: 'A',
      content: 'C'
      },
    using: {
      tsearch: {
        prefix:     true,
        dictionary: "simple",
        highlight: {
          start_sel:  '<b>',
          stop_sel:   '</b>'
        }
      }
    }

  pg_search_scope :search_simple_h,
    against: :content,
    using: {
      tsearch: {
        prefix:     true,
        dictionary: "simple",
        tsvector_column: "tsv_content",
        highlight: {
          start_sel:  '<b>',
          stop_sel:   '</b>'
        }
      }
    }

  pg_search_scope :search_simple,
    against: :content,
    using: {
      tsearch: {
        # dictionary: "simple",
        tsvector_column: "tsv_content"
      }
    }

  def self.search(query)
    # Article.search_simple(query).with_pg_search_highlight.limit(20)
    Article.search_simple_h(query).limit(20)
  end

  def extract(keywords = "")
    content[0..100]
  end

  private

  def add_words
    words = content.split(/\W+/)
    words.each do |word|
      new_word = Word.new(word: word.downcase, word_indexed: word.downcase)
      new_word.save if word.size > 2 && new_word.valid?
    end
  end
end
